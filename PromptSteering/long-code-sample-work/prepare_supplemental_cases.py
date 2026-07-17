#!/usr/bin/env python3
"""Prepare outcome-blind supplemental tests for the frozen long-code screen.

This program reads only the frozen candidate/variant manifests, their Java
sources, the immutable CodeContests parquet, the fixed supplemental protocol,
and JDK tools.  It never imports a model runner and never reads model results.
All writes remain below this script's workspace.
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
from typing import Any, Iterable, Mapping

import pyarrow
import pyarrow.parquet as pq

from prepare_long_code_variants import (
    IOCase,
    atomic_write_json,
    atomic_write_text,
    run_java_suite,
    sha256_file,
    sha256_text,
    validate_jdk17,
)


sys.dont_write_bytecode = True

WORK_ROOT = Path(__file__).resolve().parent
DEFAULT_CANDIDATE_MANIFEST = WORK_ROOT / "candidate_pool" / "candidate_manifest.json"
DEFAULT_VARIANT_MANIFEST = WORK_ROOT / "prepared_variants" / "eligible_variants.json"
DEFAULT_DATASET = WORK_ROOT / "codecontests-valid-802411c3.parquet"
DEFAULT_PROTOCOL = WORK_ROOT / "SUPPLEMENTAL_CASE_PROTOCOL.md"
DEFAULT_OUTPUT_ROOT = WORK_ROOT / "supplemental_cases"
DEFAULT_JAVA_HOME = Path("/people/cs/x/xxr230000/jdks/jdk-17.0.11+9")

SCHEMA_VERSION = "long-code-supplemental-cases-v2"
PROTOCOL_DATE = "2026-07-13"
SUITES = ("private_tests", "generated_tests")
SUITE_RANK = {name: index for index, name in enumerate(SUITES)}
INPUT_MIN_BYTES = 5
INPUT_MAX_BYTES = 512
OUTPUT_MAX_BYTES = 60
OUTPUT_MAX_LINES = 3
INPUT_TARGET_BYTES = 80
MAX_SELECTED_PER_SOURCE = 4

TIMING_DISCLOSURE = (
    "This expansion was designed after the initial 25-source full screen had "
    "started but before that screen completed."
)
OUTCOME_BLIND_DISCLOSURE = (
    "The rules were fixed and cases were selected without reading or using any "
    "model response, score, or other model outcome; this preparer performs no "
    "model inference."
)
DENOMINATOR_DISCLOSURE = (
    "The exact 25 frozen source/obfuscation variants are reused, so the "
    "screened-source denominator remains 25; supplemental cases are repeated "
    "measurements, not new source-level observations."
)


@dataclass(frozen=True)
class SupplementalCandidate:
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
        suite_label = self.suite.removesuffix("_tests")
        return f"supp-{suite_label}-{self.dataset_test_index:03d}"


def read_json(path: Path) -> Any:
    with path.open("r", encoding="utf-8") as handle:
        return json.load(handle)


def require_file(path: Path, label: str) -> Path:
    resolved = path.expanduser().resolve()
    if not resolved.is_file():
        raise FileNotFoundError(f"{label} does not exist: {resolved}")
    return resolved


def require_workspace_output(path: Path) -> Path:
    resolved = path.expanduser().resolve()
    try:
        resolved.relative_to(WORK_ROOT)
    except ValueError as exc:
        raise ValueError(f"Output must remain below {WORK_ROOT}: {resolved}") from exc
    protected = {
        WORK_ROOT.resolve(),
        (WORK_ROOT / "candidate_pool").resolve(),
        (WORK_ROOT / "prepared_variants").resolve(),
        (WORK_ROOT / "full_results").resolve(),
    }
    if resolved in protected:
        raise ValueError(f"Refusing protected output location: {resolved}")
    return resolved


def strict_utf8_size(text: Any) -> tuple[bool, int | None]:
    if not isinstance(text, str):
        return False, None
    try:
        payload = text.encode("utf-8", "strict")
    except UnicodeEncodeError:
        return False, None
    return True, len(payload)


def output_line_count(text: str) -> int:
    return len(text.splitlines())


def assess_pair(
    *,
    suite: str,
    dataset_test_index: int,
    stdin: Any,
    expected_stdout: Any,
    frozen_pairs: set[tuple[str, int]],
) -> tuple[SupplementalCandidate | None, dict[str, Any]]:
    audit: dict[str, Any] = {
        "suite": suite,
        "dataset_test_index": dataset_test_index,
        "selected": False,
        "executed": False,
    }
    if (suite, dataset_test_index) in frozen_pairs:
        audit["eligibility"] = "excluded_frozen_case"
        return None, audit

    input_utf8, input_bytes = strict_utf8_size(stdin)
    output_utf8, output_bytes = strict_utf8_size(expected_stdout)
    audit.update(
        {
            "input_valid_utf8": input_utf8,
            "expected_output_valid_utf8": output_utf8,
            "input_bytes": input_bytes,
            "expected_output_bytes": output_bytes,
        }
    )
    reasons: list[str] = []
    if not input_utf8:
        reasons.append("input_not_strict_utf8")
    if not output_utf8:
        reasons.append("expected_output_not_strict_utf8")
    if input_utf8 and not (INPUT_MIN_BYTES <= int(input_bytes) <= INPUT_MAX_BYTES):
        reasons.append("input_size_outside_5_512_bytes")
    if output_utf8 and int(output_bytes) > OUTPUT_MAX_BYTES:
        reasons.append("expected_output_over_60_bytes")

    lines = output_line_count(expected_stdout) if output_utf8 else None
    audit["expected_output_lines"] = lines
    if lines is not None and lines > OUTPUT_MAX_LINES:
        reasons.append("expected_output_over_3_lines")
    if reasons:
        audit.update({"eligibility": "ineligible", "reasons": reasons})
        return None, audit

    candidate = SupplementalCandidate(
        suite=suite,
        dataset_test_index=dataset_test_index,
        stdin=stdin,
        expected_stdout=expected_stdout,
        input_bytes=int(input_bytes),
        output_bytes=int(output_bytes),
        output_lines=int(lines),
    )
    audit.update(
        {
            "eligibility": "tractable",
            "case_id": candidate.case_id,
            "input_sha256": sha256_text(stdin),
            "raw_expected_stdout_sha256": sha256_text(expected_stdout),
            "rank_key": list(candidate.rank_key),
        }
    )
    return candidate, audit


def frozen_case_keys(variant: Mapping[str, Any]) -> tuple[set[tuple[str, int]], list[dict[str, Any]]]:
    keys: set[tuple[str, int]] = set()
    references: list[dict[str, Any]] = []
    for case in variant.get("cases", []):
        metadata = case.get("source_case_metadata", {})
        suite = metadata.get("suite")
        index = metadata.get("dataset_test_index")
        if suite not in SUITES or not isinstance(index, int):
            raise ValueError(
                f"{variant.get('id')} frozen case lacks private/generated dataset identity"
            )
        key = (suite, index)
        if key in keys:
            raise ValueError(f"{variant.get('id')} repeats frozen case {key}")
        keys.add(key)
        references.append(
            {
                "case_id": case.get("case_id"),
                "suite": suite,
                "dataset_test_index": index,
                "input_sha256": case.get("input_sha256"),
                "raw_expected_stdout_sha256": case.get("raw_expected_stdout_sha256"),
            }
        )
    return keys, references


def resolve_variant_path(value: Any, manifest_path: Path, label: str) -> Path:
    if not isinstance(value, str) or not value:
        raise ValueError(f"Missing {label}")
    path = Path(value).expanduser()
    if not path.is_absolute():
        path = manifest_path.parent / path
    return require_file(path, label)


def strip_nondeterministic_durations(value: Any) -> Any:
    if isinstance(value, Mapping):
        return {
            str(key): strip_nondeterministic_durations(item)
            for key, item in value.items()
            if str(key) != "duration_seconds"
        }
    if isinstance(value, list):
        return [strip_nondeterministic_durations(item) for item in value]
    return value


def one_case_validation(
    *,
    candidate: SupplementalCandidate,
    original_source: str,
    original_main_class: str,
    obfuscated_source: str,
    obfuscated_main_class: str,
    javac: Path,
    java: Path,
    runtime_timeout: float,
    compile_timeout: float,
    scratch_root: Path,
) -> dict[str, Any]:
    io_case = IOCase(
        case_id=candidate.case_id,
        stdin=candidate.stdin,
        expected_stdout=candidate.expected_stdout,
        argv=(),
        metadata={
            "suite": candidate.suite,
            "dataset_test_index": candidate.dataset_test_index,
        },
    )
    try:
        original = run_java_suite(
            source=original_source,
            explicit_main_class=original_main_class,
            cases=[io_case],
            javac=javac,
            java=java,
            timeout_seconds=runtime_timeout,
            compile_timeout_seconds=compile_timeout,
            scratch_root=scratch_root,
        )
        obfuscated = run_java_suite(
            source=obfuscated_source,
            explicit_main_class=obfuscated_main_class,
            cases=[io_case],
            javac=javac,
            java=java,
            timeout_seconds=runtime_timeout,
            compile_timeout_seconds=compile_timeout,
            scratch_root=scratch_root,
        )
    except (UnicodeDecodeError, ValueError) as exc:
        return {
            "accepted": False,
            "validation_exception": f"{type(exc).__name__}: {exc}",
            "original": None,
            "obfuscated": None,
            "original_obfuscated_trimmed_agreement": False,
        }

    original = strip_nondeterministic_durations(original)
    obfuscated = strip_nondeterministic_durations(obfuscated)
    original_case = (original.get("cases") or [{}])[0]
    obfuscated_case = (obfuscated.get("cases") or [{}])[0]
    agreement = bool(
        original_case.get("accepted")
        and obfuscated_case.get("accepted")
        and original_case.get("actual_trimmed") == obfuscated_case.get("actual_trimmed")
    )
    accepted = bool(original.get("accepted") and obfuscated.get("accepted") and agreement)
    return {
        "accepted": accepted,
        "historical_comparator": "replace CRLF with LF, then outer strip; internal whitespace exact",
        "requirements": {
            "both_compile": True,
            "both_runtime_exit_zero": True,
            "both_runtime_stderr_empty": True,
            "both_no_timeout": True,
            "both_trimmed_exact_to_oracle": True,
            "both_trimmed_outputs_agree": True,
        },
        "original_obfuscated_trimmed_agreement": agreement,
        "original": original,
        "obfuscated": obfuscated,
    }


def validation_case(validation: Mapping[str, Any], side: str) -> Mapping[str, Any]:
    section = validation.get(side)
    if not isinstance(section, Mapping):
        return {}
    cases = section.get("cases")
    if not isinstance(cases, list) or not cases or not isinstance(cases[0], Mapping):
        return {}
    return cases[0]


def write_selected_case_files(
    *,
    output_root: Path,
    variant_id: str,
    candidate: SupplementalCandidate,
    validation: Mapping[str, Any],
) -> dict[str, str]:
    case_root = output_root / "tests" / variant_id / candidate.case_id
    original_case = validation_case(validation, "original")
    obfuscated_case = validation_case(validation, "obfuscated")
    files = {
        "stdin_path": case_root / "stdin.txt",
        "oracle_stdout_path": case_root / "oracle_stdout.txt",
        "original_stdout_path": case_root / "original.stdout",
        "original_stderr_path": case_root / "original.stderr",
        "obfuscated_stdout_path": case_root / "obfuscated.stdout",
        "obfuscated_stderr_path": case_root / "obfuscated.stderr",
    }
    contents = {
        "stdin_path": candidate.stdin,
        "oracle_stdout_path": candidate.expected_stdout,
        "original_stdout_path": str(original_case.get("stdout", "")),
        "original_stderr_path": str(original_case.get("stderr", "")),
        "obfuscated_stdout_path": str(obfuscated_case.get("stdout", "")),
        "obfuscated_stderr_path": str(obfuscated_case.get("stderr", "")),
    }
    for key, path in files.items():
        atomic_write_text(path, contents[key])
    return {key: str(path.relative_to(output_root)) for key, path in files.items()}


def audit_jsonl(rows: Iterable[Mapping[str, Any]]) -> str:
    return "".join(
        json.dumps(row, sort_keys=True, ensure_ascii=False, separators=(",", ":")) + "\n"
        for row in rows
    )


def relative_path(path: Path, base: Path) -> str:
    return os.path.relpath(path.resolve(), base.resolve())


def inference_variant(
    *,
    frozen_variant: Mapping[str, Any],
    source_entry: Mapping[str, Any],
    output_root: Path,
) -> dict[str, Any] | None:
    """Copy a frozen variant into the runner schema with supplemental cases.

    Sources remain the immutable files below ``prepared_variants``.  Their paths
    are rebased to the supplemental manifest directory; no Java source is
    copied or rewritten.
    """

    selected = source_entry.get("supplemental_cases")
    if not isinstance(selected, list) or not selected:
        return None
    row = copy.deepcopy(dict(frozen_variant))
    original_path = WORK_ROOT / str(source_entry["original_path"])
    obfuscated_path = WORK_ROOT / str(source_entry["obfuscated_path"])
    row["original_path"] = relative_path(original_path, output_root)
    row["obfuscated_path"] = relative_path(obfuscated_path, output_root)
    if isinstance(row.get("original"), dict):
        row["original"]["path"] = row["original_path"]
    if isinstance(row.get("obfuscated"), dict):
        row["obfuscated"]["path"] = row["obfuscated_path"]

    concrete_cases: list[dict[str, Any]] = []
    for case in selected:
        concrete_cases.append(
            {
                "case_id": case["case_id"],
                "stdin_path": case["stdin_path"],
                "expected_output_path": case["oracle_stdout_path"],
                "argv": [],
                "suite": case["suite"],
                "dataset_test_index": case["dataset_test_index"],
                "tractable_rank": case["tractable_rank"],
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
                "original_trimmed_exact_to_oracle": case[
                    "original_trimmed_exact_to_oracle"
                ],
                "obfuscated_trimmed_exact_to_oracle": case[
                    "obfuscated_trimmed_exact_to_oracle"
                ],
                "original_obfuscated_trimmed_agreement": case[
                    "original_obfuscated_trimmed_agreement"
                ],
                "validation_path": case["validation_path"],
                "original_stdout_path": case["original_stdout_path"],
                "original_stderr_path": case["original_stderr_path"],
                "obfuscated_stdout_path": case["obfuscated_stdout_path"],
                "obfuscated_stderr_path": case["obfuscated_stderr_path"],
                "source_case_metadata": {
                    "suite": case["suite"],
                    "dataset_test_index": case["dataset_test_index"],
                    "row_index": source_entry["row_index"],
                    "solution_index": source_entry["solution_index"],
                    "selection_stage": "outcome_blind_supplemental_expansion",
                },
            }
        )
    row["cases"] = concrete_cases
    row["supplemental_case_selection"] = {
        "schema_version": SCHEMA_VERSION,
        "protocol": "../SUPPLEMENTAL_CASE_PROTOCOL.md",
        "frozen_source_position": source_entry["source_position"],
        "frozen_case_references": source_entry["frozen_case_references"],
        "raw_private_generated_pair_count": source_entry[
            "raw_private_generated_pair_count"
        ],
        "tractable_nonfrozen_pair_count": source_entry[
            "tractable_nonfrozen_pair_count"
        ],
        "executed_supplemental_candidate_count": source_entry[
            "executed_supplemental_candidate_count"
        ],
        "selected_supplemental_case_count": len(concrete_cases),
        "source_denominator_unchanged": True,
    }
    return row


def validate_manifest_alignment(
    candidate_payload: Mapping[str, Any], variant_payload: Mapping[str, Any]
) -> tuple[list[Mapping[str, Any]], dict[str, Mapping[str, Any]]]:
    samples = candidate_payload.get("samples")
    variants = variant_payload.get("variants")
    if not isinstance(samples, list) or not isinstance(variants, list):
        raise ValueError("Expected samples and variants arrays in frozen manifests")
    if len(samples) != 25 or len(variants) != 25:
        raise ValueError(f"Expected exactly 25 frozen sources, got {len(samples)} and {len(variants)}")
    sample_map = {str(row.get("id")): row for row in samples}
    if len(sample_map) != 25:
        raise ValueError("Candidate IDs are not unique")
    variant_ids: set[str] = set()
    candidate_ids: list[str] = []
    for variant in variants:
        variant_id = str(variant.get("id") or variant.get("variant_id") or "")
        candidate_id = str(variant.get("candidate_id") or "")
        if not variant_id or variant_id in variant_ids:
            raise ValueError(f"Missing or duplicate variant ID: {variant_id!r}")
        if candidate_id not in sample_map:
            raise ValueError(f"Variant refers to unknown candidate: {candidate_id}")
        if not variant.get("eligible"):
            raise ValueError(f"Frozen variant is not eligible: {variant_id}")
        nested_id = variant.get("candidate_metadata", {}).get("id")
        if nested_id != candidate_id:
            raise ValueError(f"Nested candidate ID mismatch for {variant_id}")
        variant_ids.add(variant_id)
        candidate_ids.append(candidate_id)
    if set(candidate_ids) != set(sample_map) or len(candidate_ids) != len(set(candidate_ids)):
        raise ValueError("Frozen manifests do not describe the same one-to-one 25-candidate set")
    return variants, sample_map


def prepare(args: argparse.Namespace) -> int:
    candidate_manifest = require_file(args.candidate_manifest, "candidate manifest")
    variant_manifest = require_file(args.variant_manifest, "variant manifest")
    dataset_path = require_file(args.dataset, "CodeContests parquet")
    protocol_path = require_file(args.protocol, "supplemental protocol")
    output_root = require_workspace_output(args.output_root)
    if output_root.exists():
        if not args.overwrite:
            raise FileExistsError(f"Output already exists (use --overwrite): {output_root}")
        shutil.rmtree(output_root)
    output_root.mkdir(parents=True)
    scratch_root = output_root / "_scratch"

    frozen_manifest_hashes_before = {
        "candidate_manifest": sha256_file(candidate_manifest),
        "eligible_variant_manifest": sha256_file(variant_manifest),
    }
    candidate_payload = read_json(candidate_manifest)
    variant_payload = read_json(variant_manifest)
    variants, sample_map = validate_manifest_alignment(candidate_payload, variant_payload)

    parquet_hash = sha256_file(dataset_path)
    expected_dataset_hashes = {
        str(row.get("provenance", {}).get("dataset_file_sha256")) for row in sample_map.values()
    }
    if expected_dataset_hashes != {parquet_hash}:
        raise ValueError(
            f"Parquet hash does not match all frozen candidate records: {expected_dataset_hashes} != {parquet_hash}"
        )

    # Deliberately omit public_tests: that suite is neither loaded nor inspected.
    columns = ["private_tests", "generated_tests", "solutions"]
    table = pq.read_table(dataset_path, columns=columns)
    dataset_rows = table.to_pylist()

    javac, java, jdk = validate_jdk17(args.java_home, scratch_root)
    all_audit_rows: list[dict[str, Any]] = []
    source_entries: list[dict[str, Any]] = []
    frozen_source_snapshot: list[dict[str, Any]] = []
    selected_total = 0
    executed_total = 0
    validation_rejection_total = 0

    for source_position, variant in enumerate(variants):
        variant_id = str(variant.get("id") or variant.get("variant_id"))
        candidate_id = str(variant["candidate_id"])
        sample = sample_map[candidate_id]
        provenance = sample.get("provenance", {})
        nested_provenance = variant.get("candidate_metadata", {}).get("provenance", {})
        row_index = provenance.get("row_index")
        solution_index = provenance.get("solution_index")
        if not isinstance(row_index, int) or not 0 <= row_index < len(dataset_rows):
            raise ValueError(f"Invalid row_index for {candidate_id}: {row_index}")
        if nested_provenance.get("row_index") != row_index or nested_provenance.get(
            "solution_index"
        ) != solution_index:
            raise ValueError(f"Nested provenance mismatch for {candidate_id}")

        original_path = resolve_variant_path(variant.get("original_path"), variant_manifest, "original source")
        obfuscated_path = resolve_variant_path(
            variant.get("obfuscated_path"), variant_manifest, "obfuscated source"
        )
        original_source = original_path.read_text(encoding="utf-8")
        obfuscated_source = obfuscated_path.read_text(encoding="utf-8")
        original_hash = sha256_text(original_source)
        obfuscated_hash = sha256_text(obfuscated_source)
        if original_hash != sample.get("source_sha256") or original_hash != variant.get("original", {}).get(
            "sha256"
        ):
            raise ValueError(f"Frozen original source hash mismatch for {variant_id}")
        if obfuscated_hash != variant.get("obfuscated", {}).get("sha256"):
            raise ValueError(f"Frozen obfuscated source hash mismatch for {variant_id}")

        row = dataset_rows[row_index]
        solutions = row.get("solutions", {})
        solution_texts = solutions.get("solution", []) if isinstance(solutions, Mapping) else []
        if not isinstance(solution_index, int) or not 0 <= solution_index < len(solution_texts):
            raise ValueError(f"Invalid solution_index for {candidate_id}: {solution_index}")
        if sha256_text(solution_texts[solution_index]) != original_hash:
            raise ValueError(f"Exact parquet solution does not match frozen original: {candidate_id}")

        frozen_pairs, frozen_references = frozen_case_keys(variant)
        audit_by_key: dict[tuple[str, int], dict[str, Any]] = {}
        candidates: list[SupplementalCandidate] = []
        raw_pair_count = 0
        for suite in SUITES:
            tests = row.get(suite)
            if not isinstance(tests, Mapping):
                raise ValueError(f"Missing {suite} in parquet row {row_index}")
            inputs = tests.get("input") or []
            outputs = tests.get("output") or []
            if len(inputs) != len(outputs):
                raise ValueError(f"Mismatched test arrays in row {row_index} {suite}")
            for dataset_test_index, (stdin, expected_stdout) in enumerate(zip(inputs, outputs)):
                raw_pair_count += 1
                candidate, audit = assess_pair(
                    suite=suite,
                    dataset_test_index=dataset_test_index,
                    stdin=stdin,
                    expected_stdout=expected_stdout,
                    frozen_pairs=frozen_pairs,
                )
                audit.update(
                    {
                        "source_position": source_position,
                        "variant_id": variant_id,
                        "candidate_id": candidate_id,
                        "row_index": row_index,
                    }
                )
                audit_by_key[(suite, dataset_test_index)] = audit
                if candidate is not None:
                    candidates.append(candidate)

        candidates.sort(key=lambda item: item.rank_key)
        selected_rows: list[dict[str, Any]] = []
        for rank, candidate in enumerate(candidates, start=1):
            audit = audit_by_key[(candidate.suite, candidate.dataset_test_index)]
            audit["tractable_rank"] = rank
            if len(selected_rows) >= MAX_SELECTED_PER_SOURCE:
                audit["selection_status"] = "not_executed_quota_filled"
                continue

            executed_total += 1
            audit["executed"] = True
            validation = one_case_validation(
                candidate=candidate,
                original_source=original_source,
                original_main_class=str(variant["original_main_class"]),
                obfuscated_source=obfuscated_source,
                obfuscated_main_class=str(variant["obfuscated_main_class"]),
                javac=javac,
                java=java,
                runtime_timeout=args.timeout_seconds,
                compile_timeout=args.compile_timeout_seconds,
                scratch_root=scratch_root,
            )
            validation_relpath = Path("validation") / variant_id / f"{candidate.case_id}.json"
            atomic_write_json(output_root / validation_relpath, validation)
            audit["validation_path"] = str(validation_relpath)
            audit["validation_accepted"] = bool(validation.get("accepted"))
            if not validation.get("accepted"):
                validation_rejection_total += 1
                audit["selection_status"] = "executed_rejected_by_jdk_validation"
                continue

            selected_total += 1
            audit["selected"] = True
            audit["selection_status"] = "selected"
            files = write_selected_case_files(
                output_root=output_root,
                variant_id=variant_id,
                candidate=candidate,
                validation=validation,
            )
            original_case = validation_case(validation, "original")
            obfuscated_case = validation_case(validation, "obfuscated")
            selected_rows.append(
                {
                    "case_id": candidate.case_id,
                    "suite": candidate.suite,
                    "dataset_test_index": candidate.dataset_test_index,
                    "tractable_rank": rank,
                    "rank_key": list(candidate.rank_key),
                    "input_bytes": candidate.input_bytes,
                    "expected_output_bytes": candidate.output_bytes,
                    "expected_output_lines": candidate.output_lines,
                    "input_sha256": sha256_text(candidate.stdin),
                    "raw_expected_stdout_sha256": sha256_text(candidate.expected_stdout),
                    "raw_original_stdout_sha256": original_case.get("raw_stdout_sha256"),
                    "raw_original_stderr_sha256": original_case.get("raw_stderr_sha256"),
                    "raw_obfuscated_stdout_sha256": obfuscated_case.get("raw_stdout_sha256"),
                    "raw_obfuscated_stderr_sha256": obfuscated_case.get("raw_stderr_sha256"),
                    "original_trimmed_exact_to_oracle": original_case.get("trimmed_exact_match"),
                    "obfuscated_trimmed_exact_to_oracle": obfuscated_case.get("trimmed_exact_match"),
                    "original_obfuscated_trimmed_agreement": validation.get(
                        "original_obfuscated_trimmed_agreement"
                    ),
                    "validation_path": str(validation_relpath),
                    **files,
                }
            )

        for suite in SUITES:
            tests = row[suite]
            for dataset_test_index in range(len(tests.get("input") or [])):
                all_audit_rows.append(audit_by_key[(suite, dataset_test_index)])

        source_entries.append(
            {
                "source_position": source_position,
                "variant_id": variant_id,
                "candidate_id": candidate_id,
                "row_index": row_index,
                "solution_index": solution_index,
                "original_path": str(original_path.relative_to(WORK_ROOT)),
                "original_sha256": original_hash,
                "obfuscated_path": str(obfuscated_path.relative_to(WORK_ROOT)),
                "obfuscated_sha256": obfuscated_hash,
                "original_main_class": variant["original_main_class"],
                "obfuscated_main_class": variant["obfuscated_main_class"],
                "frozen_case_references": frozen_references,
                "raw_private_generated_pair_count": raw_pair_count,
                "tractable_nonfrozen_pair_count": len(candidates),
                "executed_supplemental_candidate_count": sum(
                    bool(audit_by_key[(c.suite, c.dataset_test_index)].get("executed"))
                    for c in candidates
                ),
                "selected_supplemental_case_count": len(selected_rows),
                "supplemental_cases": selected_rows,
            }
        )
        frozen_source_snapshot.extend(
            [
                {
                    "variant_id": variant_id,
                    "role": "original",
                    "path": str(original_path.relative_to(WORK_ROOT)),
                    "sha256_before": original_hash,
                },
                {
                    "variant_id": variant_id,
                    "role": "obfuscated",
                    "path": str(obfuscated_path.relative_to(WORK_ROOT)),
                    "sha256_before": obfuscated_hash,
                },
            ]
        )

    frozen_manifest_hashes_after = {
        "candidate_manifest": sha256_file(candidate_manifest),
        "eligible_variant_manifest": sha256_file(variant_manifest),
    }
    if frozen_manifest_hashes_after != frozen_manifest_hashes_before:
        raise RuntimeError("A frozen manifest changed while supplemental preparation was running")
    for source in frozen_source_snapshot:
        after = sha256_file(WORK_ROOT / source["path"])
        source["sha256_after"] = after
        source["unchanged"] = after == source["sha256_before"]
    if not all(row["unchanged"] for row in frozen_source_snapshot):
        raise RuntimeError("A frozen Java source changed while supplemental preparation was running")

    criteria = {
        "suites_considered": list(SUITES),
        "public_tests_policy": "not loaded, inspected, ranked, or selected",
        "exclude_frozen_suite_index_pairs": True,
        "strict_utf8_input_and_expected_output": True,
        "input_bytes_inclusive": [INPUT_MIN_BYTES, INPUT_MAX_BYTES],
        "expected_output_max_bytes": OUTPUT_MAX_BYTES,
        "expected_output_max_lines": OUTPUT_MAX_LINES,
        "output_line_definition": "len(str.splitlines()); terminal newline adds no line",
        "rank_key": [
            "suite(private_tests=0, generated_tests=1)",
            "expected_output_lines ascending",
            "expected_output_bytes ascending",
            "abs(input_bytes-80) ascending",
            "dataset_test_index ascending",
        ],
        "max_selected_per_source": MAX_SELECTED_PER_SOURCE,
        "runtime_comparator": "replace CRLF with LF, then outer strip; internal whitespace exact",
        "acceptance": (
            "both frozen sources compile and run without timeout; runtime exit 0 and empty stderr; "
            "both outputs trimmed-exact to oracle and to each other"
        ),
    }
    inference_variants: list[dict[str, Any]] = []
    for frozen_variant, source_entry in zip(variants, source_entries, strict=True):
        rendered = inference_variant(
            frozen_variant=frozen_variant,
            source_entry=source_entry,
            output_root=output_root,
        )
        if rendered is not None:
            inference_variants.append(rendered)
    inference_candidate_ids = {str(row["candidate_id"]) for row in inference_variants}
    inference_problem_keys = {
        str(sample_map[candidate_id]["problem_key"]) for candidate_id in inference_candidate_ids
    }
    manifest = {
        "schema_version": SCHEMA_VERSION,
        "protocol_date": PROTOCOL_DATE,
        "purpose": (
            "runner-compatible outcome-blind supplemental tests for the frozen 25-source "
            "long-code screen"
        ),
        "timing_disclosure": TIMING_DISCLOSURE,
        "outcome_blind_disclosure": OUTCOME_BLIND_DISCLOSURE,
        "denominator_disclosure": DENOMINATOR_DISCLOSURE,
        "frozen_source_denominator": 25,
        "supplemental_cases_change_source_denominator": False,
        "criteria": criteria,
        "variant_count": len(inference_variants),
        "inference_source_count": len(inference_variants),
        "inference_true_problem_count": len(inference_problem_keys),
        "inference_true_problem_keys": sorted(inference_problem_keys),
        "selected_supplemental_case_count": selected_total,
        "executed_candidate_count": executed_total,
        "validation_rejection_count": validation_rejection_total,
        "source_denominator_audit": "source_denominator_audit.json",
        "variants": inference_variants,
    }
    atomic_write_json(output_root / "supplemental_manifest.json", manifest)
    atomic_write_json(
        output_root / "source_denominator_audit.json",
        {
            "schema_version": SCHEMA_VERSION,
            "protocol_date": PROTOCOL_DATE,
            "timing_disclosure": TIMING_DISCLOSURE,
            "outcome_blind_disclosure": OUTCOME_BLIND_DISCLOSURE,
            "denominator_disclosure": DENOMINATOR_DISCLOSURE,
            "frozen_source_denominator": 25,
            "frozen_source_count": len(source_entries),
            "sources_with_supplemental_cases": len(inference_variants),
            "sources_without_tractable_supplemental_cases": len(source_entries)
            - len(inference_variants),
            "sources": source_entries,
        },
    )
    atomic_write_text(output_root / "selection_audit.jsonl", audit_jsonl(all_audit_rows))

    provenance = {
        "schema_version": SCHEMA_VERSION,
        "protocol_date": PROTOCOL_DATE,
        "timing_disclosure": TIMING_DISCLOSURE,
        "outcome_blind_disclosure": OUTCOME_BLIND_DISCLOSURE,
        "denominator_disclosure": DENOMINATOR_DISCLOSURE,
        "read_scope": [
            "frozen candidate manifest",
            "frozen eligible-variant manifest",
            "frozen original/obfuscated Java source files",
            "immutable CodeContests parquet private_tests/generated_tests/solutions columns",
            "fixed supplemental protocol",
            "JDK 17 tools",
        ],
        "model_result_files_read": 0,
        "model_inference_calls": 0,
        "public_test_values_read": 0,
        "inputs": {
            "candidate_manifest": str(candidate_manifest.relative_to(WORK_ROOT)),
            "candidate_manifest_sha256_before": frozen_manifest_hashes_before["candidate_manifest"],
            "candidate_manifest_sha256_after": frozen_manifest_hashes_after["candidate_manifest"],
            "eligible_variant_manifest": str(variant_manifest.relative_to(WORK_ROOT)),
            "eligible_variant_manifest_sha256_before": frozen_manifest_hashes_before[
                "eligible_variant_manifest"
            ],
            "eligible_variant_manifest_sha256_after": frozen_manifest_hashes_after[
                "eligible_variant_manifest"
            ],
            "dataset": str(dataset_path.relative_to(WORK_ROOT)),
            "dataset_sha256": parquet_hash,
            "protocol": str(protocol_path.relative_to(WORK_ROOT)),
            "protocol_sha256": sha256_file(protocol_path),
            "preparer": str(Path(__file__).resolve().relative_to(WORK_ROOT)),
            "preparer_sha256": sha256_file(Path(__file__).resolve()),
            "jdk_helper": "prepare_long_code_variants.py",
            "jdk_helper_sha256": sha256_file(WORK_ROOT / "prepare_long_code_variants.py"),
        },
        "dataset": {
            "id": "deepmind/code_contests",
            "split": "valid",
            "revision": "802411c3010cb00d1b05bad57ca77365a3c699d6",
            "file_sha256": parquet_hash,
            "columns_loaded": columns,
            "columns_explicitly_not_loaded": ["public_tests"],
            "pyarrow_version": pyarrow.__version__,
        },
        "jdk": jdk,
        "runtime_timeout_seconds": args.timeout_seconds,
        "compile_timeout_seconds": args.compile_timeout_seconds,
        "outputs": {
            "runner_compatible_manifest": "supplemental_manifest.json",
            "source_denominator_audit": "source_denominator_audit.json",
            "selection_audit": "selection_audit.jsonl",
        },
        "frozen_inputs_unchanged": bool(
            frozen_manifest_hashes_before == frozen_manifest_hashes_after
            and all(row["unchanged"] for row in frozen_source_snapshot)
        ),
        "frozen_source_hash_audit": frozen_source_snapshot,
    }
    atomic_write_json(output_root / "provenance.json", provenance)

    summary = {
        "schema_version": SCHEMA_VERSION,
        "source_count": len(source_entries),
        "source_denominator": 25,
        "inference_source_count": len(inference_variants),
        "inference_true_problem_count": len(inference_problem_keys),
        "sources_with_four_supplemental_cases": sum(
            row["selected_supplemental_case_count"] == 4 for row in source_entries
        ),
        "sources_with_no_tractable_supplemental_case": sum(
            row["tractable_nonfrozen_pair_count"] == 0 for row in source_entries
        ),
        "selected_supplemental_case_count": selected_total,
        "executed_candidate_count": executed_total,
        "validation_rejection_count": validation_rejection_total,
        "frozen_inputs_unchanged": provenance["frozen_inputs_unchanged"],
        "manifest": "supplemental_manifest.json",
        "source_denominator_audit": "source_denominator_audit.json",
        "provenance": "provenance.json",
        "selection_audit": "selection_audit.jsonl",
        "tests_root": "tests",
        "validation_root": "validation",
    }
    atomic_write_json(output_root / "summary.json", summary)
    readme = f"""# Supplemental long-code cases

{TIMING_DISCLOSURE}  {OUTCOME_BLIND_DISCLOSURE}

{DENOMINATOR_DISCLOSURE}

The immutable selection rules are in `../SUPPLEMENTAL_CASE_PROTOCOL.md`.  The
runner-compatible `variants` manifest is `supplemental_manifest.json`; the
unchanged 25-source denominator is documented in
`source_denominator_audit.json`; complete private/generated eligibility and
ranking decisions are in `selection_audit.jsonl`; JDK 17 evidence is in
`validation/`; and exact test and observed-output bytes are in `tests/`.

Summary: {selected_total} supplemental cases selected across {len(source_entries)}
frozen source variants.  {sum(row['selected_supplemental_case_count'] == 4 for row in source_entries)}
sources received four cases; {sum(row['tractable_nonfrozen_pair_count'] == 0 for row in source_entries)}
had no non-frozen pair satisfying the fixed byte/line criteria.

The inference manifest contains {len(inference_variants)} source variants and
{len(inference_problem_keys)} distinct CodeContests problems.  Every retained
variant preserves its frozen prepared-variant metadata, points back to the same
immutable source pair, and replaces its `cases` array with the supplemental
cases only.

No public-test values, model outcomes, or model inference were used by the
preparer.
"""
    atomic_write_text(output_root / "README.md", readme)
    if scratch_root.exists():
        shutil.rmtree(scratch_root)
    print(json.dumps(summary, indent=2, sort_keys=True))
    return 0


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Prepare deterministic, outcome-blind supplemental cases without model inference."
    )
    parser.add_argument("--candidate-manifest", type=Path, default=DEFAULT_CANDIDATE_MANIFEST)
    parser.add_argument("--variant-manifest", type=Path, default=DEFAULT_VARIANT_MANIFEST)
    parser.add_argument("--dataset", type=Path, default=DEFAULT_DATASET)
    parser.add_argument("--protocol", type=Path, default=DEFAULT_PROTOCOL)
    parser.add_argument("--output-root", type=Path, default=DEFAULT_OUTPUT_ROOT)
    parser.add_argument("--java-home", type=Path, default=DEFAULT_JAVA_HOME)
    parser.add_argument("--timeout-seconds", type=float, default=12.0)
    parser.add_argument("--compile-timeout-seconds", type=float, default=30.0)
    parser.add_argument("--overwrite", action="store_true")
    return parser


def main() -> None:
    raise SystemExit(prepare(build_parser().parse_args()))


if __name__ == "__main__":
    main()
