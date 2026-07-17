#!/usr/bin/env python3
"""Prepare the frozen, outcome-blind balanced long-code contingency waves.

This script reads no model result directory and performs no model inference. It
uses only frozen manifests/sources, the immutable CodeContests parquet, JDK 17,
and the protocol files in this workspace. Exact tokenizer gating is a separate
tokenizer-only step performed by ``preflight_long_code_tokenizer.py``.
"""

from __future__ import annotations

import argparse
import copy
import json
import os
import shutil
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Mapping, Sequence

import pyarrow
import pyarrow.parquet as pq

from prepare_long_code_variants import atomic_write_json, atomic_write_text, sha256_file, sha256_text
from prepare_supplemental_cases import (
    audit_jsonl,
    one_case_validation,
    validation_case,
    write_selected_case_files,
)


sys.dont_write_bytecode = True

WORK_ROOT = Path(__file__).resolve().parent
DEFAULT_CANDIDATE_MANIFEST = WORK_ROOT / "candidate_pool" / "candidate_manifest.json"
DEFAULT_PREPARED_MANIFEST = WORK_ROOT / "prepared_variants" / "eligible_variants.json"
DEFAULT_ELIGIBLE_MANIFEST = WORK_ROOT / "tokenizer_preflight" / "inference_eligible_variants.json"
DEFAULT_SUPPLEMENTAL_MANIFEST = WORK_ROOT / "supplemental_cases" / "supplemental_manifest.json"
DEFAULT_DATASET = WORK_ROOT / "codecontests-valid-802411c3.parquet"
DEFAULT_PROTOCOL_MD = WORK_ROOT / "BALANCED_CONTINGENCY_PROTOCOL.md"
DEFAULT_PROTOCOL_JSON = WORK_ROOT / "balanced_contingency_protocol.json"
DEFAULT_OUTPUT_ROOT = WORK_ROOT / "balanced_contingency"
DEFAULT_JAVA_HOME = Path("/people/cs/x/xxr230000/jdks/jdk-17.0.11+9")

SCHEMA_VERSION = "long-code-balanced-contingency-v1"
DATASET_ID = "deepmind/code_contests"
DATASET_REVISION = "802411c3010cb00d1b05bad57ca77365a3c699d6"
DATASET_SPLIT = "valid"
DATASET_SHA256 = "02e8c1ccedae716f1e43cc813fcb7823c3db666ea92638820aba80e8cef451ab"
SUITES = ("private_tests", "generated_tests")
SUITE_RANK = {suite: index for index, suite in enumerate(SUITES)}
INPUT_MIN_BYTES = 5
INPUT_MAX_BYTES = 512
OUTPUT_MAX_BYTES = 60
OUTPUT_MAX_LINES = 7
INPUT_TARGET_BYTES = 80
CASES_PER_PROBLEM = 4
WAVE_SIZE_PER_PROBLEM = 2
EXPECTED_SOURCE_DENOMINATOR = 25
EXPECTED_TOKENIZER_ELIGIBLE_SOURCES = 23
EXPECTED_PROBLEMS = 19
EXPECTED_INITIAL_CASES = 23
EXPECTED_SUPPLEMENTAL_CASES = 60
EXPECTED_SUPPLEMENTAL_UNIQUE_KEYS = 48
EXPECTED_WAVE_CASES = 38

PARENT_CASE_ALIASES = {
    "stdin",
    "stdin_path",
    "input",
    "expected_stdout",
    "expected_stdout_path",
    "expected_output",
    "expected_output_path",
    "argv",
    "args",
    "case_spec",
}

TIMING_DISCLOSURE = (
    "Specified after the initial 23-case screen and while the corrected 60-case "
    "supplemental screen was running, before corrected supplemental model outputs "
    "or scores were inspected."
)
OUTCOME_BLIND_DISCLOSURE = (
    "Selection used no model completion, score, or other model outcome; this preparer "
    "performs no language-model inference."
)
DENOMINATOR_DISCLOSURE = (
    "The source denominator remains 25 frozen source/obfuscation variants; 23 are "
    "tokenizer-eligible and span 19 canonical problems. These waves add only repeated "
    "concrete inputs."
)


@dataclass(frozen=True)
class BalancedCandidate:
    row_index: int
    suite: str
    dataset_test_index: int
    stdin: str
    expected_stdout: str
    input_bytes: int
    output_bytes: int
    output_lines: int

    @property
    def rank_key(self) -> tuple[int, int, int, int, int]:
        return (
            SUITE_RANK[self.suite],
            self.output_lines,
            self.output_bytes,
            abs(self.input_bytes - INPUT_TARGET_BYTES),
            self.dataset_test_index,
        )

    @property
    def case_id(self) -> str:
        suite = self.suite.removesuffix("_tests")
        return f"balanced-{suite}-{self.dataset_test_index:06d}"

    @property
    def canonical_key(self) -> tuple[int, str, int]:
        return self.row_index, self.suite, self.dataset_test_index


def read_json(path: Path) -> Any:
    with path.open("r", encoding="utf-8") as handle:
        return json.load(handle)


def require_file(path: Path, label: str) -> Path:
    resolved = path.expanduser().resolve()
    if not resolved.is_file():
        raise FileNotFoundError(f"{label} does not exist: {resolved}")
    return resolved


def require_output_root(path: Path) -> Path:
    resolved = path.expanduser().resolve()
    try:
        resolved.relative_to(WORK_ROOT)
    except ValueError as exc:
        raise ValueError(f"Output must remain under {WORK_ROOT}: {resolved}") from exc
    protected = {
        WORK_ROOT.resolve(),
        (WORK_ROOT / "candidate_pool").resolve(),
        (WORK_ROOT / "prepared_variants").resolve(),
        (WORK_ROOT / "supplemental_cases").resolve(),
        (WORK_ROOT / "tokenizer_preflight").resolve(),
    }
    if resolved in protected:
        raise ValueError(f"Refusing protected output root: {resolved}")
    return resolved


def resolve_manifest_path(value: Any, manifest_path: Path, label: str) -> Path:
    if not isinstance(value, str) or not value:
        raise ValueError(f"Missing {label}")
    path = Path(value).expanduser()
    if not path.is_absolute():
        path = manifest_path.parent / path
    return require_file(path, label)


def strict_utf8_size(value: Any) -> tuple[bool, int | None]:
    if not isinstance(value, str):
        return False, None
    try:
        return True, len(value.encode("utf-8", "strict"))
    except UnicodeEncodeError:
        return False, None


def output_line_count(value: str) -> int:
    return len(value.splitlines())


def canonical_identity(row_index: int) -> str:
    return f"{DATASET_ID}@{DATASET_REVISION}:{DATASET_SPLIT}:row-{row_index:06d}"


def assess_pair(
    *,
    row_index: int,
    suite: str,
    dataset_test_index: int,
    stdin: Any,
    expected_stdout: Any,
    previously_screened: set[tuple[int, str, int]],
    tokenizer_rejections: set[tuple[int, str, int]],
) -> tuple[BalancedCandidate | None, dict[str, Any]]:
    key = (row_index, suite, dataset_test_index)
    audit: dict[str, Any] = {
        "canonical_problem_identity": canonical_identity(row_index),
        "row_index": row_index,
        "suite": suite,
        "dataset_test_index": dataset_test_index,
        "canonical_case_key": [row_index, suite, dataset_test_index],
        "executed_jdk": False,
        "selected": False,
    }
    if key in previously_screened:
        audit["eligibility"] = "excluded_previously_screened"
        return None, audit
    if key in tokenizer_rejections:
        audit["eligibility"] = "excluded_recorded_tokenizer_rejection"
        return None, audit

    input_ok, input_bytes = strict_utf8_size(stdin)
    output_ok, output_bytes = strict_utf8_size(expected_stdout)
    output_lines = output_line_count(expected_stdout) if output_ok else None
    audit.update(
        {
            "input_valid_utf8": input_ok,
            "expected_output_valid_utf8": output_ok,
            "input_bytes": input_bytes,
            "expected_output_bytes": output_bytes,
            "expected_output_lines": output_lines,
        }
    )
    reasons: list[str] = []
    if not input_ok:
        reasons.append("input_not_strict_utf8")
    if not output_ok:
        reasons.append("expected_output_not_strict_utf8")
    if input_ok and not (INPUT_MIN_BYTES <= int(input_bytes) <= INPUT_MAX_BYTES):
        reasons.append("input_size_outside_5_512_bytes")
    if output_ok and int(output_bytes) > OUTPUT_MAX_BYTES:
        reasons.append("expected_output_over_60_bytes")
    if output_lines is not None and output_lines > OUTPUT_MAX_LINES:
        reasons.append("expected_output_over_7_lines")
    if reasons:
        audit.update({"eligibility": "ineligible", "reasons": reasons})
        return None, audit

    candidate = BalancedCandidate(
        row_index=row_index,
        suite=suite,
        dataset_test_index=dataset_test_index,
        stdin=str(stdin),
        expected_stdout=str(expected_stdout),
        input_bytes=int(input_bytes),
        output_bytes=int(output_bytes),
        output_lines=int(output_lines),
    )
    audit.update(
        {
            "eligibility": "statically_eligible",
            "case_id": candidate.case_id,
            "rank_key": list(candidate.rank_key),
            "input_sha256": sha256_text(candidate.stdin),
            "raw_expected_stdout_sha256": sha256_text(candidate.expected_stdout),
        }
    )
    return candidate, audit


def candidate_rows(payload: Mapping[str, Any]) -> list[Mapping[str, Any]]:
    rows = payload.get("samples")
    if not isinstance(rows, list):
        raise ValueError("Candidate manifest does not contain samples")
    return rows


def variant_rows(payload: Mapping[str, Any], label: str) -> list[Mapping[str, Any]]:
    rows = payload.get("variants")
    if not isinstance(rows, list):
        raise ValueError(f"{label} does not contain variants")
    return rows


def variant_id(row: Mapping[str, Any]) -> str:
    value = row.get("id") or row.get("variant_id")
    if not isinstance(value, str) or not value:
        raise ValueError("Variant lacks a stable id")
    return value


def provenance_for_variant(row: Mapping[str, Any]) -> Mapping[str, Any]:
    metadata = row.get("candidate_metadata")
    if not isinstance(metadata, Mapping):
        raise ValueError(f"Variant {variant_id(row)} lacks candidate_metadata")
    provenance = metadata.get("provenance")
    if not isinstance(provenance, Mapping):
        raise ValueError(f"Variant {variant_id(row)} lacks provenance")
    return provenance


def validate_dataset_provenance(provenance: Mapping[str, Any], *, label: str) -> int:
    expected = {
        "dataset_id": DATASET_ID,
        "dataset_revision": DATASET_REVISION,
        "split": DATASET_SPLIT,
        "dataset_file_sha256": DATASET_SHA256,
    }
    for key, value in expected.items():
        if provenance.get(key) != value:
            raise ValueError(f"{label} provenance mismatch for {key}: {provenance.get(key)!r}")
    row_index = provenance.get("row_index")
    if not isinstance(row_index, int):
        raise ValueError(f"{label} lacks integer row_index")
    return row_index


def collect_screened_keys(
    payload: Mapping[str, Any],
    *,
    label: str,
    expected_case_count: int,
) -> tuple[set[tuple[int, str, int]], list[dict[str, Any]]]:
    keys: set[tuple[int, str, int]] = set()
    records: list[dict[str, Any]] = []
    case_count = 0
    for row in variant_rows(payload, label):
        provenance = provenance_for_variant(row)
        row_index = validate_dataset_provenance(provenance, label=f"{label}/{variant_id(row)}")
        cases = row.get("cases")
        if not isinstance(cases, list) or not cases:
            raise ValueError(f"{label}/{variant_id(row)} has no concrete cases")
        for case in cases:
            case_count += 1
            if not isinstance(case, Mapping):
                raise ValueError(f"Malformed case in {label}/{variant_id(row)}")
            metadata = case.get("source_case_metadata")
            if not isinstance(metadata, Mapping):
                raise ValueError(f"Case lacks source_case_metadata in {label}/{variant_id(row)}")
            suite = metadata.get("suite")
            index = metadata.get("dataset_test_index")
            recorded_row = metadata.get("row_index", row_index)
            if recorded_row != row_index or suite not in SUITES or not isinstance(index, int):
                raise ValueError(f"Invalid canonical test identity in {label}/{variant_id(row)}")
            key = (row_index, str(suite), index)
            keys.add(key)
            records.append(
                {
                    "source_manifest": label,
                    "variant_id": variant_id(row),
                    "case_id": case.get("case_id"),
                    "canonical_case_key": list(key),
                    "input_sha256": case.get("input_sha256"),
                    "raw_expected_stdout_sha256": case.get("raw_expected_stdout_sha256"),
                }
            )
    if case_count != expected_case_count:
        raise ValueError(f"{label} case count {case_count} != {expected_case_count}")
    return keys, records


def load_tokenizer_rejections(path: Path | None) -> set[tuple[int, str, int]]:
    if path is None:
        return set()
    payload = read_json(require_file(path, "tokenizer rejection manifest"))
    rows = payload.get("rejections") if isinstance(payload, Mapping) else None
    if not isinstance(rows, list):
        raise ValueError("Tokenizer rejection manifest must contain a rejections list")
    result: set[tuple[int, str, int]] = set()
    for row in rows:
        if not isinstance(row, Mapping):
            raise ValueError("Malformed tokenizer rejection row")
        key = (row.get("row_index"), row.get("suite"), row.get("dataset_test_index"))
        if not isinstance(key[0], int) or key[1] not in SUITES or not isinstance(key[2], int):
            raise ValueError(f"Malformed tokenizer rejection identity: {key}")
        result.add((int(key[0]), str(key[1]), int(key[2])))
    return result


def choose_sources(
    prepared: Sequence[Mapping[str, Any]],
    eligible_ids: set[str],
) -> list[Mapping[str, Any]]:
    grouped: dict[int, list[Mapping[str, Any]]] = {}
    for row in prepared:
        identity = variant_id(row)
        if identity not in eligible_ids:
            continue
        provenance = provenance_for_variant(row)
        row_index = validate_dataset_provenance(provenance, label=f"prepared/{identity}")
        grouped.setdefault(row_index, []).append(row)
    if len(grouped) != EXPECTED_PROBLEMS:
        raise ValueError(f"Tokenizer-eligible sources span {len(grouped)} problems, expected 19")
    return [grouped[row_index][0] for row_index in sorted(grouped)]


def relative_path(path: Path, base: Path) -> str:
    return os.path.relpath(path.resolve(), base.resolve())


def render_variant(
    *,
    frozen_variant: Mapping[str, Any],
    selected_cases: Sequence[Mapping[str, Any]],
    wave_id: str,
    output_root: Path,
    prepared_manifest: Path,
) -> dict[str, Any]:
    rendered = copy.deepcopy(dict(frozen_variant))
    for key in PARENT_CASE_ALIASES:
        rendered.pop(key, None)
    original_path = resolve_manifest_path(
        frozen_variant.get("original_path"), prepared_manifest, "frozen original source"
    )
    obfuscated_path = resolve_manifest_path(
        frozen_variant.get("obfuscated_path"), prepared_manifest, "frozen obfuscated source"
    )
    rendered["original_path"] = relative_path(original_path, output_root)
    rendered["obfuscated_path"] = relative_path(obfuscated_path, output_root)
    if isinstance(rendered.get("original"), dict):
        rendered["original"]["path"] = rendered["original_path"]
    if isinstance(rendered.get("obfuscated"), dict):
        rendered["obfuscated"]["path"] = rendered["obfuscated_path"]

    cases: list[dict[str, Any]] = []
    for case in selected_cases:
        if case["wave_id"] != wave_id:
            continue
        cases.append(
            {
                "case_id": case["case_id"],
                "stdin_path": case["stdin_path"],
                "expected_output_path": case["oracle_stdout_path"],
                "argv": [],
                "suite": case["suite"],
                "dataset_test_index": case["dataset_test_index"],
                "canonical_case_key": case["canonical_case_key"],
                "accepted_rank": case["accepted_rank"],
                "rank_key": case["rank_key"],
                "input_bytes": case["input_bytes"],
                "expected_output_bytes": case["expected_output_bytes"],
                "expected_output_lines": case["expected_output_lines"],
                "input_sha256": case["input_sha256"],
                "raw_expected_stdout_sha256": case["raw_expected_stdout_sha256"],
                "raw_original_stdout_sha256": case["raw_original_stdout_sha256"],
                "raw_original_stderr_sha256": case["raw_original_stderr_sha256"],
                "raw_obfuscated_stdout_sha256": case["raw_obfuscated_stdout_sha256"],
                "raw_obfuscated_stderr_sha256": case["raw_obfuscated_stderr_sha256"],
                "original_trimmed_exact_to_oracle": True,
                "obfuscated_trimmed_exact_to_oracle": True,
                "original_obfuscated_trimmed_agreement": True,
                "validation_path": case["validation_path"],
                "original_stdout_path": case["original_stdout_path"],
                "original_stderr_path": case["original_stderr_path"],
                "obfuscated_stdout_path": case["obfuscated_stdout_path"],
                "obfuscated_stderr_path": case["obfuscated_stderr_path"],
                "source_case_metadata": {
                    "dataset_id": DATASET_ID,
                    "dataset_revision": DATASET_REVISION,
                    "split": DATASET_SPLIT,
                    "row_index": case["row_index"],
                    "suite": case["suite"],
                    "dataset_test_index": case["dataset_test_index"],
                    "selection_stage": "balanced_outcome_blind_contingency",
                    "wave_id": wave_id,
                },
            }
        )
    if len(cases) != WAVE_SIZE_PER_PROBLEM:
        raise ValueError(f"{variant_id(frozen_variant)}/{wave_id} does not have two cases")
    rendered["cases"] = cases
    rendered["balanced_contingency_selection"] = {
        "schema_version": SCHEMA_VERSION,
        "protocol": "../BALANCED_CONTINGENCY_PROTOCOL.md",
        "wave_id": wave_id,
        "canonical_problem_identity": canonical_identity(int(cases[0]["source_case_metadata"]["row_index"])),
        "selected_source_rule": (
            "first tokenizer-eligible frozen source in prepared-variant manifest order"
        ),
        "source_denominator_unchanged": True,
    }
    return rendered


def manifest_payload(*, wave_id: str, variants: Sequence[Mapping[str, Any]]) -> dict[str, Any]:
    return {
        "schema_version": SCHEMA_VERSION,
        "protocol_date": "2026-07-13",
        "purpose": f"pre-tokenizer runner manifest for {wave_id}",
        "state": "model-free JDK validated; exact tokenizer gate pending",
        "timing_disclosure": TIMING_DISCLOSURE,
        "outcome_blind_disclosure": OUTCOME_BLIND_DISCLOSURE,
        "denominator_disclosure": DENOMINATOR_DISCLOSURE,
        "wave_id": wave_id,
        "frozen_source_denominator": EXPECTED_SOURCE_DENOMINATOR,
        "tokenizer_eligible_source_denominator": EXPECTED_TOKENIZER_ELIGIBLE_SOURCES,
        "canonical_problem_count": EXPECTED_PROBLEMS,
        "variant_count": len(variants),
        "case_count": sum(len(row.get("cases", [])) for row in variants),
        "selection_unit": "canonical dataset row + suite + dataset test index",
        "variants": list(variants),
    }


def verify_loaded_manifest(
    manifest_path: Path,
    expected_by_sample: Mapping[str, Mapping[str, Any]],
) -> dict[str, Any]:
    if str(WORK_ROOT) not in sys.path:
        sys.path.insert(0, str(WORK_ROOT))
    import run_long_code_experiment as runner

    samples, _ = runner.load_manifest(manifest_path)
    if len(samples) != EXPECTED_WAVE_CASES:
        raise ValueError(f"Runner expanded {len(samples)} cases from {manifest_path}, expected 38")
    checks: list[dict[str, Any]] = []
    for sample in samples:
        expected = expected_by_sample.get(sample.sample_id)
        if expected is None:
            raise ValueError(f"Unexpected expanded sample id: {sample.sample_id}")
        stdin_hash = sha256_text(sample.stdin)
        oracle_hash = sha256_text(sample.expected_stdout or "")
        original_hash = sha256_file(sample.original_path)
        obfuscated_hash = sha256_file(sample.obfuscated_path)
        row = {
            "sample_id": sample.sample_id,
            "stdin_sha256_loaded": stdin_hash,
            "stdin_sha256_expected": expected["input_sha256"],
            "oracle_sha256_loaded": oracle_hash,
            "oracle_sha256_expected": expected["raw_expected_stdout_sha256"],
            "original_sha256_loaded": original_hash,
            "original_sha256_expected": expected["original_sha256"],
            "obfuscated_sha256_loaded": obfuscated_hash,
            "obfuscated_sha256_expected": expected["obfuscated_sha256"],
        }
        row["all_match"] = bool(
            stdin_hash == row["stdin_sha256_expected"]
            and oracle_hash == row["oracle_sha256_expected"]
            and original_hash == row["original_sha256_expected"]
            and obfuscated_hash == row["obfuscated_sha256_expected"]
        )
        checks.append(row)
    if not all(row["all_match"] for row in checks):
        raise RuntimeError("Runner-loaded child stdin/oracle/source hash mismatch")
    return {
        "schema_version": SCHEMA_VERSION,
        "manifest": str(manifest_path.relative_to(WORK_ROOT)),
        "manifest_sha256": sha256_file(manifest_path),
        "expanded_case_count": len(samples),
        "parent_shadow_regression_checked": True,
        "all_loaded_hashes_match": True,
        "checks": checks,
    }


def prepare(args: argparse.Namespace) -> int:
    candidate_manifest = require_file(args.candidate_manifest, "candidate manifest")
    prepared_manifest = require_file(args.prepared_manifest, "prepared variant manifest")
    eligible_manifest = require_file(args.eligible_manifest, "tokenizer-eligible manifest")
    supplemental_manifest = require_file(args.supplemental_manifest, "supplemental manifest")
    dataset_path = require_file(args.dataset, "CodeContests parquet")
    protocol_md = require_file(args.protocol_md, "balanced protocol markdown")
    protocol_json = require_file(args.protocol_json, "balanced protocol JSON")
    output_root = require_output_root(args.output_root)
    tokenizer_rejections = load_tokenizer_rejections(args.tokenizer_rejections)

    if output_root.exists():
        if not args.overwrite:
            raise FileExistsError(f"Output exists; pass --overwrite: {output_root}")
        shutil.rmtree(output_root)
    output_root.mkdir(parents=True)
    scratch_root = output_root / "_scratch"

    input_paths = {
        "candidate_manifest": candidate_manifest,
        "prepared_manifest": prepared_manifest,
        "eligible_manifest": eligible_manifest,
        "supplemental_manifest": supplemental_manifest,
        "dataset": dataset_path,
        "protocol_md": protocol_md,
        "protocol_json": protocol_json,
        "preparer": Path(__file__).resolve(),
    }
    input_hashes_before = {key: sha256_file(path) for key, path in input_paths.items()}
    if input_hashes_before["dataset"] != DATASET_SHA256:
        raise ValueError("Immutable CodeContests parquet hash mismatch")

    candidates_payload = read_json(candidate_manifest)
    prepared_payload = read_json(prepared_manifest)
    eligible_payload = read_json(eligible_manifest)
    supplemental_payload = read_json(supplemental_manifest)
    candidate_list = candidate_rows(candidates_payload)
    prepared_list = variant_rows(prepared_payload, "prepared manifest")
    eligible_list = variant_rows(eligible_payload, "tokenizer-eligible manifest")
    if len(candidate_list) != EXPECTED_SOURCE_DENOMINATOR or len(prepared_list) != EXPECTED_SOURCE_DENOMINATOR:
        raise ValueError("Frozen source denominator is not exactly 25")
    eligible_ids = {variant_id(row) for row in eligible_list}
    if len(eligible_ids) != EXPECTED_TOKENIZER_ELIGIBLE_SOURCES:
        raise ValueError("Tokenizer-eligible source count is not exactly 23")

    candidate_map = {str(row.get("id")): row for row in candidate_list}
    if len(candidate_map) != EXPECTED_SOURCE_DENOMINATOR:
        raise ValueError("Candidate ids are missing or duplicated")

    initial_keys, initial_records = collect_screened_keys(
        eligible_payload,
        label="initial_tokenizer_eligible_manifest",
        expected_case_count=EXPECTED_INITIAL_CASES,
    )
    supplemental_keys, supplemental_records = collect_screened_keys(
        supplemental_payload,
        label="supplemental_manifest",
        expected_case_count=EXPECTED_SUPPLEMENTAL_CASES,
    )
    if len(supplemental_keys) != EXPECTED_SUPPLEMENTAL_UNIQUE_KEYS:
        raise ValueError(
            f"Supplemental unique canonical test count {len(supplemental_keys)} != 48"
        )
    previously_screened = initial_keys | supplemental_keys
    chosen_sources = choose_sources(prepared_list, eligible_ids)

    # Public tests are intentionally absent from this read.
    columns = ["private_tests", "generated_tests", "solutions"]
    table = pq.read_table(dataset_path, columns=columns)
    dataset_rows = table.to_pylist()

    from prepare_long_code_variants import validate_jdk17

    javac, java, jdk = validate_jdk17(args.java_home, scratch_root)
    all_audits: list[dict[str, Any]] = []
    problem_entries: list[dict[str, Any]] = []
    frozen_sources: list[dict[str, Any]] = []
    executed_total = 0
    validation_rejection_total = 0

    for source_order, frozen_variant in enumerate(chosen_sources):
        identity = variant_id(frozen_variant)
        provenance = provenance_for_variant(frozen_variant)
        row_index = validate_dataset_provenance(provenance, label=f"chosen/{identity}")
        candidate_id = str(frozen_variant.get("candidate_id"))
        candidate = candidate_map.get(candidate_id)
        if candidate is None:
            raise ValueError(f"Chosen variant refers to unknown candidate {candidate_id}")
        candidate_provenance = candidate.get("provenance")
        if not isinstance(candidate_provenance, Mapping):
            raise ValueError(f"Candidate lacks provenance: {candidate_id}")
        if validate_dataset_provenance(candidate_provenance, label=candidate_id) != row_index:
            raise ValueError(f"Candidate/variant row mismatch: {candidate_id}")

        solution_index = candidate_provenance.get("solution_index")
        if not isinstance(solution_index, int):
            raise ValueError(f"Invalid solution index for {candidate_id}")
        original_path = resolve_manifest_path(
            frozen_variant.get("original_path"), prepared_manifest, "original source"
        )
        obfuscated_path = resolve_manifest_path(
            frozen_variant.get("obfuscated_path"), prepared_manifest, "obfuscated source"
        )
        original_source = original_path.read_text(encoding="utf-8")
        obfuscated_source = obfuscated_path.read_text(encoding="utf-8")
        original_hash = sha256_text(original_source)
        obfuscated_hash = sha256_text(obfuscated_source)
        if original_hash != candidate.get("source_sha256"):
            raise ValueError(f"Original source hash mismatch: {identity}")
        if original_hash != frozen_variant.get("original", {}).get("sha256"):
            raise ValueError(f"Prepared original hash mismatch: {identity}")
        if obfuscated_hash != frozen_variant.get("obfuscated", {}).get("sha256"):
            raise ValueError(f"Prepared obfuscated hash mismatch: {identity}")

        dataset_row = dataset_rows[row_index]
        solutions = dataset_row.get("solutions")
        if not isinstance(solutions, Mapping):
            raise ValueError(f"Missing solutions in row {row_index}")
        texts = solutions.get("solution") or []
        if not 0 <= solution_index < len(texts):
            raise ValueError(f"Solution index out of range: {candidate_id}")
        if sha256_text(texts[solution_index]) != original_hash:
            raise ValueError(f"Parquet source differs from chosen frozen source: {identity}")

        audits_by_key: dict[tuple[int, str, int], dict[str, Any]] = {}
        ranked: list[BalancedCandidate] = []
        for suite in SUITES:
            tests = dataset_row.get(suite)
            if not isinstance(tests, Mapping):
                raise ValueError(f"Missing {suite} in row {row_index}")
            inputs = tests.get("input") or []
            outputs = tests.get("output") or []
            if len(inputs) != len(outputs):
                raise ValueError(f"Mismatched {suite} arrays in row {row_index}")
            for index, (stdin, expected_stdout) in enumerate(zip(inputs, outputs)):
                item, audit = assess_pair(
                    row_index=row_index,
                    suite=suite,
                    dataset_test_index=index,
                    stdin=stdin,
                    expected_stdout=expected_stdout,
                    previously_screened=previously_screened,
                    tokenizer_rejections=tokenizer_rejections,
                )
                audit.update(
                    {
                        "chosen_source_order": source_order,
                        "variant_id": identity,
                        "candidate_id": candidate_id,
                    }
                )
                audits_by_key[(row_index, suite, index)] = audit
                if item is not None:
                    ranked.append(item)
        ranked.sort(key=lambda item: item.rank_key)

        selected: list[dict[str, Any]] = []
        for tractable_rank, item in enumerate(ranked, start=1):
            audit = audits_by_key[item.canonical_key]
            audit["tractable_rank"] = tractable_rank
            if len(selected) >= CASES_PER_PROBLEM:
                audit["selection_status"] = "not_executed_problem_quota_filled"
                continue
            executed_total += 1
            audit["executed_jdk"] = True
            validation = one_case_validation(
                candidate=item,
                original_source=original_source,
                original_main_class=str(frozen_variant["original_main_class"]),
                obfuscated_source=obfuscated_source,
                obfuscated_main_class=str(frozen_variant["obfuscated_main_class"]),
                javac=javac,
                java=java,
                runtime_timeout=args.timeout_seconds,
                compile_timeout=args.compile_timeout_seconds,
                scratch_root=scratch_root,
            )
            validation_relpath = Path("validation") / identity / f"{item.case_id}.json"
            atomic_write_json(output_root / validation_relpath, validation)
            audit["validation_path"] = str(validation_relpath)
            audit["validation_accepted"] = bool(validation.get("accepted"))
            if not validation.get("accepted"):
                validation_rejection_total += 1
                audit["selection_status"] = "executed_rejected_by_jdk_validation"
                continue

            accepted_rank = len(selected) + 1
            wave_id = "balanced_wave_1" if accepted_rank <= 2 else "balanced_wave_2"
            audit.update(
                {
                    "selected": True,
                    "selection_status": "selected",
                    "accepted_rank": accepted_rank,
                    "wave_id": wave_id,
                }
            )
            files = write_selected_case_files(
                output_root=output_root,
                variant_id=identity,
                candidate=item,
                validation=validation,
            )
            original_case = validation_case(validation, "original")
            obfuscated_case = validation_case(validation, "obfuscated")
            selected.append(
                {
                    "case_id": item.case_id,
                    "canonical_case_key": list(item.canonical_key),
                    "canonical_problem_identity": canonical_identity(row_index),
                    "row_index": row_index,
                    "suite": item.suite,
                    "dataset_test_index": item.dataset_test_index,
                    "tractable_rank": tractable_rank,
                    "accepted_rank": accepted_rank,
                    "wave_id": wave_id,
                    "rank_key": list(item.rank_key),
                    "input_bytes": item.input_bytes,
                    "expected_output_bytes": item.output_bytes,
                    "expected_output_lines": item.output_lines,
                    "input_sha256": sha256_text(item.stdin),
                    "raw_expected_stdout_sha256": sha256_text(item.expected_stdout),
                    "raw_original_stdout_sha256": original_case.get("raw_stdout_sha256"),
                    "raw_original_stderr_sha256": original_case.get("raw_stderr_sha256"),
                    "raw_obfuscated_stdout_sha256": obfuscated_case.get("raw_stdout_sha256"),
                    "raw_obfuscated_stderr_sha256": obfuscated_case.get("raw_stderr_sha256"),
                    "validation_path": str(validation_relpath),
                    **files,
                }
            )

        if len(selected) != CASES_PER_PROBLEM:
            raise RuntimeError(f"Row {row_index} produced {len(selected)} passing cases, expected 4")
        for suite in SUITES:
            tests = dataset_row[suite]
            for index in range(len(tests.get("input") or [])):
                all_audits.append(audits_by_key[(row_index, suite, index)])

        problem_entries.append(
            {
                "chosen_source_order": source_order,
                "canonical_problem_identity": canonical_identity(row_index),
                "row_index": row_index,
                "problem_key": candidate.get("problem_key"),
                "variant_id": identity,
                "candidate_id": candidate_id,
                "solution_index": solution_index,
                "physical_loc": candidate.get("physical_loc"),
                "original_path": str(original_path.relative_to(WORK_ROOT)),
                "original_sha256": original_hash,
                "obfuscated_path": str(obfuscated_path.relative_to(WORK_ROOT)),
                "obfuscated_sha256": obfuscated_hash,
                "eligible_pair_count_after_static_filters": len(ranked),
                "executed_jdk_count": sum(
                    bool(audits_by_key[item.canonical_key].get("executed_jdk")) for item in ranked
                ),
                "selected_cases": selected,
            }
        )
        frozen_sources.extend(
            [
                {
                    "variant_id": identity,
                    "role": "original",
                    "path": str(original_path.relative_to(WORK_ROOT)),
                    "sha256_before": original_hash,
                },
                {
                    "variant_id": identity,
                    "role": "obfuscated",
                    "path": str(obfuscated_path.relative_to(WORK_ROOT)),
                    "sha256_before": obfuscated_hash,
                },
            ]
        )

    selected_keys = {
        tuple(case["canonical_case_key"])
        for problem in problem_entries
        for case in problem["selected_cases"]
    }
    if len(selected_keys) != EXPECTED_PROBLEMS * CASES_PER_PROBLEM:
        raise RuntimeError("Selected canonical row/test identities are not globally unique")
    if selected_keys & previously_screened:
        raise RuntimeError("A balanced case overlaps an initial or supplemental case")

    wave_variants: dict[str, list[dict[str, Any]]] = {
        "balanced_wave_1": [],
        "balanced_wave_2": [],
    }
    expected_by_wave: dict[str, dict[str, dict[str, Any]]] = {
        "balanced_wave_1": {},
        "balanced_wave_2": {},
    }
    chosen_map = {variant_id(row): row for row in chosen_sources}
    for problem in problem_entries:
        identity = str(problem["variant_id"])
        for wave_id in wave_variants:
            rendered = render_variant(
                frozen_variant=chosen_map[identity],
                selected_cases=problem["selected_cases"],
                wave_id=wave_id,
                output_root=output_root,
                prepared_manifest=prepared_manifest,
            )
            if any(key in rendered for key in PARENT_CASE_ALIASES):
                raise RuntimeError(f"Parent case alias survived rendering: {identity}")
            wave_variants[wave_id].append(rendered)
            for case in rendered["cases"]:
                sample_id = f"{identity}__{case['case_id']}"
                expected_by_wave[wave_id][sample_id] = {
                    **case,
                    "original_sha256": problem["original_sha256"],
                    "obfuscated_sha256": problem["obfuscated_sha256"],
                }

    manifest_paths: dict[str, Path] = {}
    loader_audits: dict[str, dict[str, Any]] = {}
    for wave_number, wave_id in enumerate(("balanced_wave_1", "balanced_wave_2"), start=1):
        manifest_path = output_root / f"wave_{wave_number}_manifest_pre_tokenizer.json"
        payload = manifest_payload(wave_id=wave_id, variants=wave_variants[wave_id])
        if payload["variant_count"] != EXPECTED_PROBLEMS or payload["case_count"] != EXPECTED_WAVE_CASES:
            raise RuntimeError(f"{wave_id} manifest count mismatch")
        atomic_write_json(manifest_path, payload)
        manifest_paths[wave_id] = manifest_path
        loader_audits[wave_id] = verify_loaded_manifest(
            manifest_path, expected_by_wave[wave_id]
        )
        atomic_write_json(
            output_root / f"wave_{wave_number}_loader_hash_audit.json",
            loader_audits[wave_id],
        )

    wave_1_keys = {
        tuple(case["canonical_case_key"])
        for row in wave_variants["balanced_wave_1"]
        for case in row["cases"]
    }
    wave_2_keys = {
        tuple(case["canonical_case_key"])
        for row in wave_variants["balanced_wave_2"]
        for case in row["cases"]
    }
    if wave_1_keys & wave_2_keys:
        raise RuntimeError("Wave manifests overlap")

    input_hashes_after = {key: sha256_file(path) for key, path in input_paths.items()}
    if input_hashes_after != input_hashes_before:
        raise RuntimeError("A frozen input changed during preparation")
    for source in frozen_sources:
        source["sha256_after"] = sha256_file(WORK_ROOT / source["path"])
        source["unchanged"] = source["sha256_before"] == source["sha256_after"]
    if not all(source["unchanged"] for source in frozen_sources):
        raise RuntimeError("A frozen source changed during preparation")

    atomic_write_text(output_root / "selection_audit.jsonl", audit_jsonl(all_audits))
    atomic_write_json(
        output_root / "previous_screened_case_audit.json",
        {
            "schema_version": SCHEMA_VERSION,
            "initial_case_record_count": len(initial_records),
            "initial_unique_canonical_case_count": len(initial_keys),
            "supplemental_case_record_count": len(supplemental_records),
            "supplemental_unique_canonical_case_count": len(supplemental_keys),
            "combined_unique_canonical_case_count": len(previously_screened),
            "records": initial_records + supplemental_records,
        },
    )
    atomic_write_json(
        output_root / "source_denominator_audit.json",
        {
            "schema_version": SCHEMA_VERSION,
            "timing_disclosure": TIMING_DISCLOSURE,
            "outcome_blind_disclosure": OUTCOME_BLIND_DISCLOSURE,
            "denominator_disclosure": DENOMINATOR_DISCLOSURE,
            "frozen_source_denominator": EXPECTED_SOURCE_DENOMINATOR,
            "tokenizer_eligible_source_count": EXPECTED_TOKENIZER_ELIGIBLE_SOURCES,
            "canonical_problem_count": EXPECTED_PROBLEMS,
            "chosen_source_count": len(problem_entries),
            "wave_1_case_count": len(wave_1_keys),
            "wave_2_case_count": len(wave_2_keys),
            "sources": problem_entries,
        },
    )
    atomic_write_json(
        output_root / "loader_hash_audit.json",
        {
            "schema_version": SCHEMA_VERSION,
            "parent_shadow_regression_checked": True,
            "all_loaded_hashes_match": True,
            "waves": loader_audits,
        },
    )

    provenance = {
        "schema_version": SCHEMA_VERSION,
        "timing_disclosure": TIMING_DISCLOSURE,
        "outcome_blind_disclosure": OUTCOME_BLIND_DISCLOSURE,
        "denominator_disclosure": DENOMINATOR_DISCLOSURE,
        "read_scope": [
            "frozen candidate, prepared-variant, tokenizer-eligible, and supplemental manifests",
            "frozen original and obfuscated Java source files",
            "immutable CodeContests private_tests/generated_tests/solutions columns",
            "balanced contingency protocol files",
            "JDK 17 tools",
        ],
        "explicitly_forbidden_read_scope": [
            "supplemental result roots",
            "model completions",
            "model scores",
            "public_tests values",
        ],
        "model_result_files_read": 0,
        "model_inference_calls": 0,
        "model_weights_loaded": False,
        "public_test_values_read": 0,
        "dataset": {
            "id": DATASET_ID,
            "revision": DATASET_REVISION,
            "split": DATASET_SPLIT,
            "file_sha256": DATASET_SHA256,
            "columns_loaded": columns,
            "columns_explicitly_not_loaded": ["public_tests"],
            "pyarrow_version": pyarrow.__version__,
        },
        "inputs": {
            key: {
                "path": str(path.relative_to(WORK_ROOT)),
                "sha256_before": input_hashes_before[key],
                "sha256_after": input_hashes_after[key],
            }
            for key, path in input_paths.items()
        },
        "tokenizer_rejection_manifest": (
            None
            if args.tokenizer_rejections is None
            else {
                "path": str(require_file(args.tokenizer_rejections, "tokenizer rejections").relative_to(WORK_ROOT)),
                "sha256": sha256_file(require_file(args.tokenizer_rejections, "tokenizer rejections")),
                "rejected_key_count": len(tokenizer_rejections),
            }
        ),
        "jdk": jdk,
        "runtime_timeout_seconds": args.timeout_seconds,
        "compile_timeout_seconds": args.compile_timeout_seconds,
        "jdk_executed_candidate_count": executed_total,
        "jdk_validation_rejection_count": validation_rejection_total,
        "frozen_inputs_unchanged": True,
        "frozen_source_hash_audit": frozen_sources,
        "outputs": {
            "wave_1_pre_tokenizer_manifest": str(manifest_paths["balanced_wave_1"].relative_to(output_root)),
            "wave_2_pre_tokenizer_manifest": str(manifest_paths["balanced_wave_2"].relative_to(output_root)),
            "selection_audit": "selection_audit.jsonl",
            "source_denominator_audit": "source_denominator_audit.json",
            "loader_hash_audit": "loader_hash_audit.json",
        },
    }
    atomic_write_json(output_root / "provenance.json", provenance)

    summary = {
        "schema_version": SCHEMA_VERSION,
        "state": "prepared_and_jdk_validated_tokenizer_gate_pending",
        "source_denominator": EXPECTED_SOURCE_DENOMINATOR,
        "tokenizer_eligible_source_count": EXPECTED_TOKENIZER_ELIGIBLE_SOURCES,
        "canonical_problem_count": EXPECTED_PROBLEMS,
        "selected_case_count": len(selected_keys),
        "wave_1_case_count": len(wave_1_keys),
        "wave_2_case_count": len(wave_2_keys),
        "waves_disjoint": not bool(wave_1_keys & wave_2_keys),
        "overlap_with_previously_screened": len(selected_keys & previously_screened),
        "jdk_executed_candidate_count": executed_total,
        "jdk_validation_rejection_count": validation_rejection_total,
        "tokenizer_rejection_key_count": len(tokenizer_rejections),
        "model_result_files_read": 0,
        "model_inference_calls": 0,
        "public_test_values_read": 0,
        "parent_shadow_regression_checked": True,
        "all_loaded_hashes_match": True,
    }
    atomic_write_json(output_root / "summary.json", summary)
    atomic_write_text(
        output_root / "README.md",
        f"""# Frozen balanced contingency cases

{TIMING_DISCLOSURE}  {OUTCOME_BLIND_DISCLOSURE}

{DENOMINATOR_DISCLOSURE}

The two pre-tokenizer manifests each contain 38 JDK-validated cases: exactly
two cases for each of 19 canonical CodeContests problems. The waves are
disjoint and have no canonical row/suite/test-index overlap with the initial or
supplemental screens. Complete ranking decisions are in
`selection_audit.jsonl`; JDK records and exact bytes are under `validation/`
and `tests/`; and `loader_hash_audit.json` proves the experiment runner loads
each child case's frozen stdin and oracle.

Exact tokenizer-only gating and final freeze/launch-plan generation are the
next model-free steps. No inference result root is created by this preparer.
""",
    )
    if scratch_root.exists():
        shutil.rmtree(scratch_root)
    print(json.dumps(summary, indent=2, sort_keys=True))
    return 0


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--candidate-manifest", type=Path, default=DEFAULT_CANDIDATE_MANIFEST)
    parser.add_argument("--prepared-manifest", type=Path, default=DEFAULT_PREPARED_MANIFEST)
    parser.add_argument("--eligible-manifest", type=Path, default=DEFAULT_ELIGIBLE_MANIFEST)
    parser.add_argument("--supplemental-manifest", type=Path, default=DEFAULT_SUPPLEMENTAL_MANIFEST)
    parser.add_argument("--dataset", type=Path, default=DEFAULT_DATASET)
    parser.add_argument("--protocol-md", type=Path, default=DEFAULT_PROTOCOL_MD)
    parser.add_argument("--protocol-json", type=Path, default=DEFAULT_PROTOCOL_JSON)
    parser.add_argument("--output-root", type=Path, default=DEFAULT_OUTPUT_ROOT)
    parser.add_argument("--java-home", type=Path, default=DEFAULT_JAVA_HOME)
    parser.add_argument("--timeout-seconds", type=float, default=12.0)
    parser.add_argument("--compile-timeout-seconds", type=float, default=30.0)
    parser.add_argument(
        "--tokenizer-rejections",
        type=Path,
        default=None,
        help=(
            "Optional frozen JSON rejections list keyed by row_index/suite/dataset_test_index. "
            "Rejected pairs are skipped so the same rank rule scans deeper."
        ),
    )
    parser.add_argument("--overwrite", action="store_true")
    return parser


def main() -> None:
    raise SystemExit(prepare(build_parser().parse_args()))


if __name__ == "__main__":
    main()
