#!/usr/bin/env python3
"""Prepare the frozen, adaptive balanced Wave-3 extension.

This program deliberately reads no inference result directory.  It reconstructs
the deterministic model-free ranking used by balanced Waves 1 and 2, verifies
their accepted ranks 1--4, and retains the next six JDK-valid cases for each of
the same 19 canonical CodeContests rows.
"""

from __future__ import annotations

import argparse
import copy
import json
import shutil
import sys
from collections import Counter
from pathlib import Path
from typing import Any, Mapping, Sequence

import pyarrow
import pyarrow.parquet as pq

import prepare_balanced_contingency as base
from prepare_long_code_variants import (
    atomic_write_json,
    atomic_write_text,
    sha256_file,
    sha256_text,
    validate_jdk17,
)
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
DEFAULT_WAVE_1_MANIFEST = (
    WORK_ROOT
    / "balanced_contingency"
    / "tokenizer_preflight"
    / "wave_1"
    / "inference_eligible_variants.json"
)
DEFAULT_WAVE_2_MANIFEST = (
    WORK_ROOT
    / "balanced_contingency"
    / "tokenizer_preflight"
    / "wave_2"
    / "inference_eligible_variants.json"
)
DEFAULT_DATASET = WORK_ROOT / "codecontests-valid-802411c3.parquet"
DEFAULT_PROTOCOL_MD = WORK_ROOT / "BALANCED_EXTENSION_CONTINGENCY_PROTOCOL.md"
DEFAULT_PROTOCOL_JSON = WORK_ROOT / "balanced_extension_contingency_protocol.json"
DEFAULT_OUTPUT_ROOT = WORK_ROOT / "balanced_extension_contingency"
DEFAULT_JAVA_HOME = Path("/people/cs/x/xxr230000/jdks/jdk-17.0.11+9")

SCHEMA_VERSION = "long-code-balanced-extension-contingency-v1"
WAVE_ID = "balanced_wave_3"
EXPECTED_PROBLEMS = 19
EXPECTED_CASES_PER_PROBLEM = 6
EXPECTED_CASES = EXPECTED_PROBLEMS * EXPECTED_CASES_PER_PROBLEM
EXPECTED_PRIOR_ACCEPTED_PER_PROBLEM = 4
EXPECTED_ACCEPTED_RANKS = tuple(range(5, 11))
TIMING_DISCLOSURE = (
    "Specified after the formal initial-plus-supplemental strict canonical-problem count was 4 "
    "and during corrected Wave 1, after an aggregate interim results-index exact-count look at "
    "the then-completed subset. That look showed zero exact CodeSteer trials in the subset and "
    "included identifiers of samples with baseline exact matches. No raw model completion, "
    "reasoning trace, oracle content, or per-CodeSteer-success content was used to specify the "
    "contingency or its case rules. An earlier path-only startup attempt was excluded without "
    "inspecting its result contents or scores."
)
ADAPTIVE_STATUS_DISCLOSURE = (
    "This contingency is not preregistered and is not outcome-blind in timing. Its case "
    "eligibility, ranking, and selection are deterministic and outcome-independent: no Wave-1 "
    "or Wave-2 outcome is an input to those rules."
)
PREPARATION_READ_DISCLOSURE = (
    "Case eligibility, ranking, and selection use no completion, score, aggregate count, or "
    "sample identifier from the interim look. Preparation and freezing read no inference result "
    "files, perform no language-model inference, and create no result root. The aggregate "
    "interim look is retained only as an externally supplied timing fact."
)
DENOMINATOR_DISCLOSURE = (
    "The source denominator remains 25 frozen source/obfuscation variants; the same 23 "
    "tokenizer-eligible sources spanning 19 canonical problems are reused. Wave 3 adds only "
    "repeated concrete inputs."
)


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
        (WORK_ROOT / "balanced_contingency").resolve(),
    }
    if resolved in protected:
        raise ValueError(f"Refusing protected output root: {resolved}")
    return resolved


def _case_rows(payload: Mapping[str, Any], label: str) -> list[tuple[Mapping[str, Any], Mapping[str, Any]]]:
    rows: list[tuple[Mapping[str, Any], Mapping[str, Any]]] = []
    for variant in base.variant_rows(payload, label):
        cases = variant.get("cases")
        if not isinstance(cases, list):
            raise ValueError(f"{label}/{base.variant_id(variant)} lacks cases")
        for case in cases:
            if not isinstance(case, Mapping):
                raise ValueError(f"Malformed case in {label}/{base.variant_id(variant)}")
            rows.append((variant, case))
    return rows


def _canonical_case_key(variant: Mapping[str, Any], case: Mapping[str, Any]) -> tuple[int, str, int]:
    provenance = base.provenance_for_variant(variant)
    row_index = base.validate_dataset_provenance(
        provenance, label=f"prior/{base.variant_id(variant)}"
    )
    metadata = case.get("source_case_metadata")
    if not isinstance(metadata, Mapping):
        raise ValueError(f"Prior case lacks source_case_metadata: {base.variant_id(variant)}")
    key = (metadata.get("row_index", row_index), metadata.get("suite"), metadata.get("dataset_test_index"))
    if key[0] != row_index or key[1] not in base.SUITES or not isinstance(key[2], int):
        raise ValueError(f"Malformed prior canonical case key: {key}")
    if list(key) != case.get("canonical_case_key"):
        raise ValueError(f"Prior canonical case key disagreement: {key}")
    return int(key[0]), str(key[1]), int(key[2])


def validate_prior_balanced_waves(
    wave_1_payload: Mapping[str, Any],
    wave_2_payload: Mapping[str, Any],
) -> tuple[dict[int, dict[int, tuple[int, str, int]]], set[tuple[int, str, int]], set[str]]:
    expected = ((wave_1_payload, "balanced_wave_1", {1, 2}), (wave_2_payload, "balanced_wave_2", {3, 4}))
    accepted: dict[int, dict[int, tuple[int, str, int]]] = {}
    keys: set[tuple[int, str, int]] = set()
    source_ids_by_wave: list[set[str]] = []
    for payload, wave_id, expected_ranks in expected:
        if payload.get("schema_version") != base.SCHEMA_VERSION or payload.get("wave_id") != wave_id:
            raise ValueError(f"Frozen {wave_id} manifest schema/wave mismatch")
        if payload.get("state") != "exact_tokenizer_gate_passed":
            raise ValueError(f"Frozen {wave_id} did not pass its exact tokenizer gate")
        rows = _case_rows(payload, wave_id)
        if len(rows) != 38:
            raise ValueError(f"Frozen {wave_id} case count is not 38")
        source_ids = {base.variant_id(variant) for variant in base.variant_rows(payload, wave_id)}
        if len(source_ids) != EXPECTED_PROBLEMS:
            raise ValueError(f"Frozen {wave_id} source count is not 19")
        source_ids_by_wave.append(source_ids)
        rank_counts: Counter[int] = Counter()
        row_counts: Counter[int] = Counter()
        for variant, case in rows:
            key = _canonical_case_key(variant, case)
            rank = case.get("accepted_rank")
            metadata = case.get("source_case_metadata") or {}
            if rank not in expected_ranks or metadata.get("wave_id") != wave_id:
                raise ValueError(f"Frozen {wave_id} accepted-rank metadata mismatch: {key}")
            row_index = key[0]
            if int(rank) in accepted.setdefault(row_index, {}):
                raise ValueError(f"Duplicate prior accepted rank {rank} in row {row_index}")
            accepted[row_index][int(rank)] = key
            rank_counts[int(rank)] += 1
            row_counts[row_index] += 1
            if key in keys:
                raise ValueError(f"Frozen balanced waves overlap: {key}")
            keys.add(key)
        if set(rank_counts) != expected_ranks or set(rank_counts.values()) != {EXPECTED_PROBLEMS}:
            raise ValueError(f"Frozen {wave_id} rank counts are not exact")
        if len(row_counts) != EXPECTED_PROBLEMS or set(row_counts.values()) != {2}:
            raise ValueError(f"Frozen {wave_id} is not two cases per problem")
    if source_ids_by_wave[0] != source_ids_by_wave[1]:
        raise ValueError("Frozen Waves 1 and 2 do not use the same source variants")
    if len(accepted) != EXPECTED_PROBLEMS or any(set(ranks) != {1, 2, 3, 4} for ranks in accepted.values()):
        raise ValueError("Frozen accepted ranks 1--4 are incomplete")
    return accepted, keys, source_ids_by_wave[0]


def load_tokenizer_rejections(path: Path | None) -> set[tuple[int, str, int]]:
    if path is None:
        return set()
    payload = base.read_json(base.require_file(path, "tokenizer rejection manifest"))
    if payload.get("schema_version") != SCHEMA_VERSION or payload.get("wave_id") != WAVE_ID:
        raise ValueError("Tokenizer rejection manifest schema/wave mismatch")
    rows = payload.get("rejections")
    if not isinstance(rows, list):
        raise ValueError("Tokenizer rejection manifest lacks rejections")
    result: set[tuple[int, str, int]] = set()
    for row in rows:
        if not isinstance(row, Mapping):
            raise ValueError("Malformed tokenizer rejection")
        key = (row.get("row_index"), row.get("suite"), row.get("dataset_test_index"))
        if not isinstance(key[0], int) or key[1] not in base.SUITES or not isinstance(key[2], int):
            raise ValueError(f"Malformed tokenizer rejection key: {key}")
        result.add((int(key[0]), str(key[1]), int(key[2])))
    return result


def render_variant(
    *,
    frozen_variant: Mapping[str, Any],
    selected_cases: Sequence[Mapping[str, Any]],
    output_root: Path,
    prepared_manifest: Path,
) -> dict[str, Any]:
    rendered = copy.deepcopy(dict(frozen_variant))
    for key in base.PARENT_CASE_ALIASES:
        rendered.pop(key, None)
    original_path = base.resolve_manifest_path(
        frozen_variant.get("original_path"), prepared_manifest, "frozen original source"
    )
    obfuscated_path = base.resolve_manifest_path(
        frozen_variant.get("obfuscated_path"), prepared_manifest, "frozen obfuscated source"
    )
    rendered["original_path"] = base.relative_path(original_path, output_root)
    rendered["obfuscated_path"] = base.relative_path(obfuscated_path, output_root)
    if isinstance(rendered.get("original"), dict):
        rendered["original"]["path"] = rendered["original_path"]
    if isinstance(rendered.get("obfuscated"), dict):
        rendered["obfuscated"]["path"] = rendered["obfuscated_path"]
    cases: list[dict[str, Any]] = []
    for case in selected_cases:
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
                    "dataset_id": base.DATASET_ID,
                    "dataset_revision": base.DATASET_REVISION,
                    "split": base.DATASET_SPLIT,
                    "row_index": case["row_index"],
                    "suite": case["suite"],
                    "dataset_test_index": case["dataset_test_index"],
                    "selection_stage": "balanced_extension_adaptive_outcome_independent_ranking",
                    "wave_id": WAVE_ID,
                },
            }
        )
    if len(cases) != EXPECTED_CASES_PER_PROBLEM:
        raise ValueError(f"{base.variant_id(frozen_variant)} does not have six Wave-3 cases")
    if {int(case["accepted_rank"]) for case in cases} != set(EXPECTED_ACCEPTED_RANKS):
        raise ValueError(f"{base.variant_id(frozen_variant)} Wave-3 ranks are not 5--10")
    rendered["cases"] = cases
    rendered["balanced_extension_contingency_selection"] = {
        "schema_version": SCHEMA_VERSION,
        "protocol": "../BALANCED_EXTENSION_CONTINGENCY_PROTOCOL.md",
        "wave_id": WAVE_ID,
        "canonical_problem_identity": base.canonical_identity(
            int(cases[0]["source_case_metadata"]["row_index"])
        ),
        "selected_source_rule": "same first tokenizer-eligible source used by frozen balanced Waves 1 and 2",
        "source_denominator_unchanged": True,
        "continued_accepted_ranks": list(EXPECTED_ACCEPTED_RANKS),
    }
    return rendered


def manifest_payload(variants: Sequence[Mapping[str, Any]]) -> dict[str, Any]:
    return {
        "schema_version": SCHEMA_VERSION,
        "protocol_date": "2026-07-13",
        "purpose": "pre-tokenizer runner manifest for conditional balanced Wave 3",
        "state": "model-free JDK validated; exact tokenizer gate pending",
        "timing_disclosure": TIMING_DISCLOSURE,
        "adaptive_status_disclosure": ADAPTIVE_STATUS_DISCLOSURE,
        "preparation_read_disclosure": PREPARATION_READ_DISCLOSURE,
        "denominator_disclosure": DENOMINATOR_DISCLOSURE,
        "wave_id": WAVE_ID,
        "conditional_trigger": "run only after a complete valid post-Wave-2 audit has fewer than ten strict canonical problems",
        "frozen_source_denominator": 25,
        "tokenizer_eligible_source_denominator": 23,
        "canonical_problem_count": EXPECTED_PROBLEMS,
        "cases_per_problem": EXPECTED_CASES_PER_PROBLEM,
        "accepted_ranks_per_problem": list(EXPECTED_ACCEPTED_RANKS),
        "variant_count": len(variants),
        "case_count": sum(len(row.get("cases", [])) for row in variants),
        "selection_unit": "canonical dataset row + suite + dataset test index",
        "variants": list(variants),
    }


def verify_loaded_manifest(
    manifest_path: Path, expected_by_sample: Mapping[str, Mapping[str, Any]]
) -> dict[str, Any]:
    import run_long_code_experiment as runner

    samples, _ = runner.load_manifest(manifest_path)
    if len(samples) != EXPECTED_CASES or {sample.sample_id for sample in samples} != set(expected_by_sample):
        raise ValueError("Runner-expanded Wave-3 sample IDs/count differ from the frozen manifest")
    checks: list[dict[str, Any]] = []
    for sample in samples:
        expected = expected_by_sample[sample.sample_id]
        row = {
            "sample_id": sample.sample_id,
            "stdin_sha256_loaded": sha256_text(sample.stdin),
            "stdin_sha256_expected": expected["input_sha256"],
            "oracle_sha256_loaded": sha256_text(sample.expected_stdout or ""),
            "oracle_sha256_expected": expected["raw_expected_stdout_sha256"],
            "original_sha256_loaded": sha256_file(sample.original_path),
            "original_sha256_expected": expected["original_sha256"],
            "obfuscated_sha256_loaded": sha256_file(sample.obfuscated_path),
            "obfuscated_sha256_expected": expected["obfuscated_sha256"],
        }
        row["all_match"] = all(
            row[left] == row[right]
            for left, right in (
                ("stdin_sha256_loaded", "stdin_sha256_expected"),
                ("oracle_sha256_loaded", "oracle_sha256_expected"),
                ("original_sha256_loaded", "original_sha256_expected"),
                ("obfuscated_sha256_loaded", "obfuscated_sha256_expected"),
            )
        )
        checks.append(row)
    if not all(row["all_match"] for row in checks):
        raise RuntimeError("Runner-loaded Wave-3 child input/oracle/source hash mismatch")
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
    candidate_manifest = base.require_file(args.candidate_manifest, "candidate manifest")
    prepared_manifest = base.require_file(args.prepared_manifest, "prepared variant manifest")
    eligible_manifest = base.require_file(args.eligible_manifest, "tokenizer-eligible manifest")
    supplemental_manifest = base.require_file(args.supplemental_manifest, "supplemental manifest")
    wave_1_manifest = base.require_file(args.wave_1_manifest, "frozen Wave-1 manifest")
    wave_2_manifest = base.require_file(args.wave_2_manifest, "frozen Wave-2 manifest")
    dataset_path = base.require_file(args.dataset, "CodeContests parquet")
    protocol_md = base.require_file(args.protocol_md, "extension protocol markdown")
    protocol_json = base.require_file(args.protocol_json, "extension protocol JSON")
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
        "wave_1_manifest": wave_1_manifest,
        "wave_2_manifest": wave_2_manifest,
        "dataset": dataset_path,
        "protocol_md": protocol_md,
        "protocol_json": protocol_json,
        "preparer": Path(__file__).resolve(),
    }
    if args.tokenizer_rejections is not None:
        input_paths["tokenizer_rejections"] = base.require_file(
            args.tokenizer_rejections, "tokenizer rejections"
        )
    input_hashes_before = {key: sha256_file(path) for key, path in input_paths.items()}
    if input_hashes_before["dataset"] != base.DATASET_SHA256:
        raise ValueError("Immutable CodeContests parquet hash mismatch")

    candidate_payload = base.read_json(candidate_manifest)
    prepared_payload = base.read_json(prepared_manifest)
    eligible_payload = base.read_json(eligible_manifest)
    supplemental_payload = base.read_json(supplemental_manifest)
    wave_1_payload = base.read_json(wave_1_manifest)
    wave_2_payload = base.read_json(wave_2_manifest)
    protocol_payload = base.read_json(protocol_json)
    if protocol_payload.get("schema_version") != SCHEMA_VERSION:
        raise ValueError("Extension protocol schema mismatch")
    expected_protocol_status = {
        "adaptive": True,
        "preregistered": False,
        "outcome_blind_in_timing": False,
        "case_eligibility_ranking_selection_outcome_independent": True,
    }
    if protocol_payload.get("status") != expected_protocol_status:
        raise ValueError("Extension protocol adaptive-status flags mismatch")

    candidate_list = base.candidate_rows(candidate_payload)
    prepared_list = base.variant_rows(prepared_payload, "prepared manifest")
    eligible_list = base.variant_rows(eligible_payload, "tokenizer-eligible manifest")
    if len(candidate_list) != 25 or len(prepared_list) != 25:
        raise ValueError("Frozen source denominator is not 25")
    eligible_ids = {base.variant_id(row) for row in eligible_list}
    if len(eligible_ids) != 23:
        raise ValueError("Frozen tokenizer-eligible source denominator is not 23")
    candidate_map = {str(row.get("id")): row for row in candidate_list}
    if len(candidate_map) != 25:
        raise ValueError("Candidate IDs are missing or duplicated")

    initial_keys, initial_records = base.collect_screened_keys(
        eligible_payload, label="initial_tokenizer_eligible_manifest", expected_case_count=23
    )
    supplemental_keys, supplemental_records = base.collect_screened_keys(
        supplemental_payload, label="supplemental_manifest", expected_case_count=60
    )
    accepted_prior, balanced_keys, balanced_source_ids = validate_prior_balanced_waves(
        wave_1_payload, wave_2_payload
    )
    wave_1_keys, wave_1_records = base.collect_screened_keys(
        wave_1_payload, label="balanced_wave_1_manifest", expected_case_count=38
    )
    wave_2_keys, wave_2_records = base.collect_screened_keys(
        wave_2_payload, label="balanced_wave_2_manifest", expected_case_count=38
    )
    if balanced_keys != wave_1_keys | wave_2_keys:
        raise ValueError("Frozen balanced key reconstruction disagrees")
    prior_static_keys = initial_keys | supplemental_keys
    all_previous_keys = prior_static_keys | balanced_keys
    if tokenizer_rejections & all_previous_keys:
        raise ValueError("Extension tokenizer rejection overlaps a previously screened case")

    chosen_sources = base.choose_sources(prepared_list, eligible_ids)
    if {base.variant_id(row) for row in chosen_sources} != balanced_source_ids:
        raise ValueError("Extension source choice differs from frozen balanced Waves 1 and 2")

    # Public tests are intentionally absent.
    columns = ["private_tests", "generated_tests", "solutions"]
    dataset_rows = pq.read_table(dataset_path, columns=columns).to_pylist()
    javac, java, jdk = validate_jdk17(args.java_home, scratch_root)
    all_audits: list[dict[str, Any]] = []
    problem_entries: list[dict[str, Any]] = []
    frozen_sources: list[dict[str, Any]] = []
    executed_total = 0
    validation_rejection_total = 0

    for source_order, frozen_variant in enumerate(chosen_sources):
        identity = base.variant_id(frozen_variant)
        provenance = base.provenance_for_variant(frozen_variant)
        row_index = base.validate_dataset_provenance(provenance, label=f"chosen/{identity}")
        candidate_id = str(frozen_variant.get("candidate_id"))
        candidate = candidate_map.get(candidate_id)
        if candidate is None:
            raise ValueError(f"Unknown candidate {candidate_id}")
        candidate_provenance = candidate.get("provenance")
        if not isinstance(candidate_provenance, Mapping):
            raise ValueError(f"Candidate lacks provenance: {candidate_id}")
        if base.validate_dataset_provenance(candidate_provenance, label=candidate_id) != row_index:
            raise ValueError(f"Candidate/variant row mismatch: {candidate_id}")
        solution_index = candidate_provenance.get("solution_index")
        if not isinstance(solution_index, int):
            raise ValueError(f"Invalid solution index: {candidate_id}")

        original_path = base.resolve_manifest_path(
            frozen_variant.get("original_path"), prepared_manifest, "original source"
        )
        obfuscated_path = base.resolve_manifest_path(
            frozen_variant.get("obfuscated_path"), prepared_manifest, "obfuscated source"
        )
        original_source = original_path.read_text(encoding="utf-8")
        obfuscated_source = obfuscated_path.read_text(encoding="utf-8")
        original_hash = sha256_text(original_source)
        obfuscated_hash = sha256_text(obfuscated_source)
        if (
            original_hash != candidate.get("source_sha256")
            or original_hash != (frozen_variant.get("original") or {}).get("sha256")
            or obfuscated_hash != (frozen_variant.get("obfuscated") or {}).get("sha256")
        ):
            raise ValueError(f"Frozen source hash mismatch: {identity}")
        dataset_row = dataset_rows[row_index]
        solutions = dataset_row.get("solutions")
        texts = solutions.get("solution") if isinstance(solutions, Mapping) else None
        if not isinstance(texts, list) or not 0 <= solution_index < len(texts):
            raise ValueError(f"Dataset solution binding unavailable: {candidate_id}")
        if sha256_text(texts[solution_index]) != original_hash:
            raise ValueError(f"Parquet source differs from frozen source: {identity}")

        audits_by_key: dict[tuple[int, str, int], dict[str, Any]] = {}
        ranked: list[base.BalancedCandidate] = []
        for suite in base.SUITES:
            tests = dataset_row.get(suite)
            if not isinstance(tests, Mapping):
                raise ValueError(f"Missing {suite} in row {row_index}")
            inputs = tests.get("input") or []
            outputs = tests.get("output") or []
            if len(inputs) != len(outputs):
                raise ValueError(f"Mismatched {suite} arrays in row {row_index}")
            for test_index, (stdin, expected_stdout) in enumerate(zip(inputs, outputs)):
                item, audit = base.assess_pair(
                    row_index=row_index,
                    suite=suite,
                    dataset_test_index=test_index,
                    stdin=stdin,
                    expected_stdout=expected_stdout,
                    previously_screened=prior_static_keys,
                    tokenizer_rejections=tokenizer_rejections,
                )
                audit.update(
                    {
                        "schema_version": SCHEMA_VERSION,
                        "chosen_source_order": source_order,
                        "variant_id": identity,
                        "candidate_id": candidate_id,
                    }
                )
                audits_by_key[(row_index, suite, test_index)] = audit
                if item is not None:
                    ranked.append(item)
        ranked.sort(key=lambda item: item.rank_key)

        accepted_count = 0
        selected: list[dict[str, Any]] = []
        continuity_rows: list[dict[str, Any]] = []
        for tractable_rank, item in enumerate(ranked, start=1):
            audit = audits_by_key[item.canonical_key]
            audit["tractable_rank"] = tractable_rank
            if accepted_count >= 10:
                audit["selection_status"] = "not_executed_accepted_rank_10_reached"
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

            accepted_count += 1
            audit["accepted_rank"] = accepted_count
            if accepted_count <= EXPECTED_PRIOR_ACCEPTED_PER_PROBLEM:
                expected_key = accepted_prior[row_index][accepted_count]
                if item.canonical_key != expected_key:
                    raise RuntimeError(
                        f"Row {row_index} reconstructed rank {accepted_count} as {item.canonical_key}, "
                        f"not frozen {expected_key}"
                    )
                audit.update(
                    {
                        "selected": False,
                        "selection_status": "continuity_verified_frozen_balanced_rank",
                        "frozen_wave": "balanced_wave_1" if accepted_count <= 2 else "balanced_wave_2",
                    }
                )
                continuity_rows.append(
                    {
                        "accepted_rank": accepted_count,
                        "canonical_case_key": list(item.canonical_key),
                        "validation_path": str(validation_relpath),
                        "jdk_revalidated": True,
                    }
                )
                continue

            if item.canonical_key in all_previous_keys:
                raise RuntimeError(f"Wave-3 selection overlaps prior screen: {item.canonical_key}")
            audit.update(
                {
                    "selected": True,
                    "selection_status": "selected_wave_3",
                    "wave_id": WAVE_ID,
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
                    "canonical_problem_identity": base.canonical_identity(row_index),
                    "row_index": row_index,
                    "suite": item.suite,
                    "dataset_test_index": item.dataset_test_index,
                    "tractable_rank": tractable_rank,
                    "accepted_rank": accepted_count,
                    "wave_id": WAVE_ID,
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
        if accepted_count != 10 or len(selected) != EXPECTED_CASES_PER_PROBLEM:
            raise RuntimeError(
                f"Row {row_index} produced accepted_count={accepted_count}, Wave-3 cases={len(selected)}"
            )
        if {row["accepted_rank"] for row in selected} != set(EXPECTED_ACCEPTED_RANKS):
            raise RuntimeError(f"Row {row_index} Wave-3 accepted ranks are not 5--10")
        for suite in base.SUITES:
            tests = dataset_row[suite]
            for test_index in range(len(tests.get("input") or [])):
                all_audits.append(audits_by_key[(row_index, suite, test_index)])
        problem_entries.append(
            {
                "chosen_source_order": source_order,
                "canonical_problem_identity": base.canonical_identity(row_index),
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
                "continuity_verified_ranks_1_4": continuity_rows,
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
    if len(selected_keys) != EXPECTED_CASES or selected_keys & all_previous_keys:
        raise RuntimeError("Wave-3 keys are not 114 unique, prior-disjoint cases")
    rendered_variants: list[dict[str, Any]] = []
    expected_by_sample: dict[str, dict[str, Any]] = {}
    chosen_map = {base.variant_id(row): row for row in chosen_sources}
    for problem in problem_entries:
        identity = str(problem["variant_id"])
        rendered = render_variant(
            frozen_variant=chosen_map[identity],
            selected_cases=problem["selected_cases"],
            output_root=output_root,
            prepared_manifest=prepared_manifest,
        )
        rendered_variants.append(rendered)
        for case in rendered["cases"]:
            sample_id = f"{identity}__{case['case_id']}"
            expected_by_sample[sample_id] = {
                **case,
                "original_sha256": problem["original_sha256"],
                "obfuscated_sha256": problem["obfuscated_sha256"],
            }
    manifest_path = output_root / "wave_3_manifest_pre_tokenizer.json"
    payload = manifest_payload(rendered_variants)
    if payload["variant_count"] != EXPECTED_PROBLEMS or payload["case_count"] != EXPECTED_CASES:
        raise RuntimeError("Wave-3 manifest counts are invalid")
    atomic_write_json(manifest_path, payload)
    loader_audit = verify_loaded_manifest(manifest_path, expected_by_sample)
    atomic_write_json(output_root / "wave_3_loader_hash_audit.json", loader_audit)

    input_hashes_after = {key: sha256_file(path) for key, path in input_paths.items()}
    if input_hashes_after != input_hashes_before:
        raise RuntimeError("A frozen input changed during Wave-3 preparation")
    for source in frozen_sources:
        source["sha256_after"] = sha256_file(WORK_ROOT / source["path"])
        source["unchanged"] = source["sha256_before"] == source["sha256_after"]
    if not all(source["unchanged"] for source in frozen_sources):
        raise RuntimeError("A frozen source changed during Wave-3 preparation")

    atomic_write_text(output_root / "selection_audit.jsonl", audit_jsonl(all_audits))
    previous_records = initial_records + supplemental_records + wave_1_records + wave_2_records
    atomic_write_json(
        output_root / "previous_screened_case_audit.json",
        {
            "schema_version": SCHEMA_VERSION,
            "initial_case_record_count": len(initial_records),
            "supplemental_case_record_count": len(supplemental_records),
            "wave_1_case_record_count": len(wave_1_records),
            "wave_2_case_record_count": len(wave_2_records),
            "combined_unique_canonical_case_count": len(all_previous_keys),
            "wave_3_overlap_count": len(selected_keys & all_previous_keys),
            "records": previous_records,
        },
    )
    atomic_write_json(
        output_root / "source_denominator_audit.json",
        {
            "schema_version": SCHEMA_VERSION,
            "timing_disclosure": TIMING_DISCLOSURE,
            "adaptive_status_disclosure": ADAPTIVE_STATUS_DISCLOSURE,
            "preparation_read_disclosure": PREPARATION_READ_DISCLOSURE,
            "denominator_disclosure": DENOMINATOR_DISCLOSURE,
            "frozen_source_denominator": 25,
            "tokenizer_eligible_source_count": 23,
            "canonical_problem_count": EXPECTED_PROBLEMS,
            "chosen_source_count": len(problem_entries),
            "wave_3_case_count": len(selected_keys),
            "accepted_ranks_per_problem": list(EXPECTED_ACCEPTED_RANKS),
            "sources": problem_entries,
        },
    )
    atomic_write_json(
        output_root / "loader_hash_audit.json",
        {
            "schema_version": SCHEMA_VERSION,
            "parent_shadow_regression_checked": True,
            "all_loaded_hashes_match": True,
            "wave_3": loader_audit,
        },
    )
    provenance = {
        "schema_version": SCHEMA_VERSION,
        "timing_disclosure": TIMING_DISCLOSURE,
        "adaptive_status_disclosure": ADAPTIVE_STATUS_DISCLOSURE,
        "preparation_read_disclosure": PREPARATION_READ_DISCLOSURE,
        "denominator_disclosure": DENOMINATOR_DISCLOSURE,
        "formal_initial_supplemental_strict_canonical_problem_count": 4,
        "formal_count_source": "externally supplied timing fact; no audit/result file was read by this preparer",
        "adaptive_interim_look_external_fact": {
            "timing": "during corrected Wave 1, before the extension protocol and case rules were specified",
            "scope": "aggregate interim results-index exact counts for the then-completed subset",
            "observed_codesteer_exact_trial_count": 0,
            "included_baseline_exact_sample_identifiers": True,
            "raw_completions_used_to_specify_contingency_or_case_rules": False,
            "reasoning_traces_used_to_specify_contingency_or_case_rules": False,
            "oracle_content_used_to_specify_contingency_or_case_rules": False,
            "per_codesteer_success_content_used_to_specify_contingency_or_case_rules": False,
            "used_by_case_eligibility_ranking_or_selection": False,
            "source": "externally supplied disclosure; this preparer read no result file",
        },
        "excluded_startup_attempt": "path-only startup attempt excluded; result contents and scores were not inspected",
        "read_scope": [
            "frozen candidate, prepared-variant, initial, supplemental, Wave-1, and Wave-2 manifests",
            "frozen original and obfuscated Java source files",
            "immutable CodeContests private_tests/generated_tests/solutions columns",
            "balanced extension protocol files",
            "JDK 17 tools",
        ],
        "explicitly_forbidden_read_scope": [
            "all Wave-1 and Wave-2 inference result roots",
            "all run records, model completions, predicted outputs, and scores",
            "the excluded path-only startup attempt contents",
            "public_tests values",
        ],
        "model_result_files_read": 0,
        "model_inference_calls": 0,
        "model_weights_loaded": False,
        "public_test_values_read": 0,
        "dataset": {
            "id": base.DATASET_ID,
            "revision": base.DATASET_REVISION,
            "split": base.DATASET_SPLIT,
            "file_sha256": base.DATASET_SHA256,
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
        "jdk": jdk,
        "runtime_timeout_seconds": args.timeout_seconds,
        "compile_timeout_seconds": args.compile_timeout_seconds,
        "jdk_executed_candidate_count": executed_total,
        "jdk_validation_rejection_count": validation_rejection_total,
        "frozen_inputs_unchanged": True,
        "frozen_source_hash_audit": frozen_sources,
        "outputs": {
            "wave_3_pre_tokenizer_manifest": manifest_path.name,
            "selection_audit": "selection_audit.jsonl",
            "source_denominator_audit": "source_denominator_audit.json",
            "loader_hash_audit": "loader_hash_audit.json",
        },
    }
    atomic_write_json(output_root / "provenance.json", provenance)
    summary = {
        "schema_version": SCHEMA_VERSION,
        "state": "prepared_and_jdk_validated_tokenizer_gate_pending",
        "source_denominator": 25,
        "tokenizer_eligible_source_count": 23,
        "canonical_problem_count": EXPECTED_PROBLEMS,
        "selected_case_count": len(selected_keys),
        "cases_per_problem": EXPECTED_CASES_PER_PROBLEM,
        "accepted_ranks_per_problem": list(EXPECTED_ACCEPTED_RANKS),
        "prior_accepted_ranks_revalidated_per_problem": 4,
        "overlap_with_initial_supplemental_wave_1_wave_2": len(selected_keys & all_previous_keys),
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
        f"""# Frozen balanced extension contingency (Wave 3)\n\n{TIMING_DISCLOSURE}\n\n{ADAPTIVE_STATUS_DISCLOSURE}\n\n{PREPARATION_READ_DISCLOSURE}\n\n{DENOMINATOR_DISCLOSURE}\n\nThe pre-tokenizer manifest contains 114 JDK-validated cases: exactly accepted\nranks 5--10 for each of the same 19 canonical CodeContests problems. Every\ninitial, supplemental, Wave-1, and Wave-2 canonical case key is excluded.\nComplete ranking/JDK evidence is retained in this directory. Exact tokenizer\ngating and immutable freezing are still pending. No result root was created.\n""",
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
    parser.add_argument("--wave-1-manifest", type=Path, default=DEFAULT_WAVE_1_MANIFEST)
    parser.add_argument("--wave-2-manifest", type=Path, default=DEFAULT_WAVE_2_MANIFEST)
    parser.add_argument("--dataset", type=Path, default=DEFAULT_DATASET)
    parser.add_argument("--protocol-md", type=Path, default=DEFAULT_PROTOCOL_MD)
    parser.add_argument("--protocol-json", type=Path, default=DEFAULT_PROTOCOL_JSON)
    parser.add_argument("--output-root", type=Path, default=DEFAULT_OUTPUT_ROOT)
    parser.add_argument("--java-home", type=Path, default=DEFAULT_JAVA_HOME)
    parser.add_argument("--timeout-seconds", type=float, default=12.0)
    parser.add_argument("--compile-timeout-seconds", type=float, default=30.0)
    parser.add_argument("--tokenizer-rejections", type=Path, default=None)
    parser.add_argument("--overwrite", action="store_true")
    return parser


def main() -> None:
    raise SystemExit(prepare(build_parser().parse_args()))


if __name__ == "__main__":
    main()
