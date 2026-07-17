#!/usr/bin/env python3
"""Verify, plan, and freeze optional balanced Waves 4--5 without inference.

This finalizer reads only the static preparation and tokenizer artifacts in
``balanced_extension2_contingency`` plus versioned control files. It does not
read or enumerate any inference/result directory, perform model inference, or
create an inference/result root. The only prospective-root operations are
exact ``Path.exists()`` fail-closed checks for future Waves 4--5.
"""

from __future__ import annotations

import argparse
import json
import os
import shlex
import sys
from collections import Counter
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Mapping, Sequence

from prepare_long_code_variants import (
    atomic_write_json,
    atomic_write_text,
    sha256_file,
    sha256_text,
)

import prepare_balanced_contingency as base
import prepare_balanced_extension2_contingency as extension2


sys.dont_write_bytecode = True

WORK_ROOT = extension2.WORK_ROOT
DEFAULT_OUTPUT_ROOT = WORK_ROOT / "balanced_extension2_contingency"
DEFAULT_RUNNER = WORK_ROOT / "run_long_code_experiment.py"
DEFAULT_PREFLIGHT = WORK_ROOT / "preflight_long_code_tokenizer.py"
MODEL_ID = "Qwen/Qwen2.5-14B"
MODEL_SNAPSHOT = "97e1e76335b7017d8f67c08a19d103c0504298c9"
BASE_SEED = 20260713
TRIALS = 3
CONDITIONS = 4
GPU_COUNT = 4
EXPECTED_PROBLEMS = 19
RANK25_FAILURE_SCHEMA = "long-code-balanced-extension2-rank25-feasibility-failure-v1"
RANK25_LIMITING_ROW = 27
RANK25_LIMITING_VARIANT = "cc-valid-r027-s0184-1553-d-backspace__t5_easy_seed1"
RANK25_FAILURE_MESSAGE = (
    "FAIL CLOSED: row 27 supplied accepted_count=24, new cases=14; "
    "exact ranks 11--25 are required"
)
RANK20_FAILURE_SCHEMA = "long-code-balanced-extension2-rank20-feasibility-failure-v1"
RANK20_LIMITING_ROW = 54
RANK20_LIMITING_VARIANT = "cc-valid-r054-s0229-1557-c-moamen-and-xor__t5_easy_seed1"
RANK20_FAILURE_MESSAGE = (
    "FAIL CLOSED: row 54 supplied accepted_count=19, new cases=9; "
    "revised exact ranks 11--24 are required"
)

WAVE_SPECS: dict[int, dict[str, Any]] = {
    4: {
        "wave_id": "balanced_wave_4",
        "ranks": tuple(range(11, 16)),
        "cases_per_problem": 5,
        "case_count": 95,
        "shard_cases": [24, 24, 24, 23],
        "shard_records": [288, 288, 288, 276],
        "trigger_audit": "post-Wave-3",
        "prior_wave_must_be_complete": "Wave 3",
    },
    5: {
        "wave_id": "balanced_wave_5",
        "ranks": tuple(range(16, 20)),
        "cases_per_problem": 4,
        "case_count": 76,
        "shard_cases": [19, 19, 19, 19],
        "shard_records": [228, 228, 228, 228],
        "trigger_audit": "post-Wave-4",
        "prior_wave_must_be_complete": "Wave 4",
    },
}
EXPECTED_TOTAL_CASES = sum(int(spec["case_count"]) for spec in WAVE_SPECS.values())
EXPECTED_MAXIMUM_RUN_RECORDS = EXPECTED_TOTAL_CASES * TRIALS * CONDITIONS


def _variants(payload: Mapping[str, Any], label: str) -> list[Mapping[str, Any]]:
    rows = payload.get("variants")
    if not isinstance(rows, list):
        raise ValueError(f"{label} has no variants list")
    if not all(isinstance(row, Mapping) for row in rows):
        raise ValueError(f"{label} contains a malformed variant")
    return rows


def _variant_id(row: Mapping[str, Any]) -> str:
    return base.variant_id(row)


def _case_key(case: Mapping[str, Any]) -> tuple[int, str, int]:
    metadata = case.get("source_case_metadata")
    if not isinstance(metadata, Mapping):
        raise ValueError("Case lacks source_case_metadata")
    key = (metadata.get("row_index"), metadata.get("suite"), metadata.get("dataset_test_index"))
    if not isinstance(key[0], int) or key[1] not in base.SUITES or not isinstance(key[2], int):
        raise ValueError(f"Malformed canonical case key: {key}")
    if list(key) != case.get("canonical_case_key"):
        raise ValueError(f"Canonical case key disagreement: {key}")
    return int(key[0]), str(key[1]), int(key[2])


def _expanded_case_map(
    payload: Mapping[str, Any], *, wave_number: int
) -> dict[str, dict[str, Any]]:
    label = f"Wave-{wave_number} manifest"
    spec = WAVE_SPECS[wave_number]
    cases_per_problem = int(spec["cases_per_problem"])
    expected_case_count = int(spec["case_count"])
    result: dict[str, dict[str, Any]] = {}
    rows = _variants(payload, label)
    if len(rows) != EXPECTED_PROBLEMS:
        raise ValueError(f"{label} does not have exactly {EXPECTED_PROBLEMS} variants")
    for row in rows:
        identity = _variant_id(row)
        if any(key in row for key in base.PARENT_CASE_ALIASES):
            raise ValueError(f"Parent input/output alias survives in {identity}")
        original = row.get("original") if isinstance(row.get("original"), Mapping) else {}
        obfuscated = row.get("obfuscated") if isinstance(row.get("obfuscated"), Mapping) else {}
        original_sha = original.get("sha256")
        obfuscated_sha = obfuscated.get("sha256")
        if not isinstance(original_sha, str) or not isinstance(obfuscated_sha, str):
            raise ValueError(f"Missing frozen source hashes in {identity}")
        cases = row.get("cases")
        if not isinstance(cases, list) or len(cases) != cases_per_problem:
            raise ValueError(
                f"{identity} does not have exactly {cases_per_problem} Wave-{wave_number} cases"
            )
        for case in cases:
            if not isinstance(case, Mapping):
                raise ValueError(f"Malformed case in {identity}")
            case_id = case.get("case_id")
            if not isinstance(case_id, str) or not case_id:
                raise ValueError(f"Case lacks id in {identity}")
            sample_id = f"{identity}__{case_id}"
            if sample_id in result:
                raise ValueError(f"Duplicate sample id {sample_id}")
            result[sample_id] = {
                **dict(case),
                "original_sha256": original_sha,
                "obfuscated_sha256": obfuscated_sha,
            }
    if len(result) != expected_case_count:
        raise ValueError(f"{label} does not expand to exactly {expected_case_count} cases")
    return result


def _generated_file(output_root: Path, raw_path: Any, label: str) -> Path:
    if not isinstance(raw_path, str) or not raw_path:
        raise ValueError(f"Missing {label} path")
    relative = Path(raw_path)
    if relative.is_absolute():
        raise ValueError(f"{label} path is absolute: {raw_path}")
    resolved = (output_root / relative).resolve()
    try:
        resolved.relative_to(output_root.resolve())
    except ValueError as exc:
        raise ValueError(f"{label} path escapes the generated root: {raw_path}") from exc
    return base.require_file(resolved, label)


def _verify_static_jdk_case(output_root: Path, case: Mapping[str, Any]) -> None:
    key = _case_key(case)
    exact_flags = (
        "original_trimmed_exact_to_oracle",
        "obfuscated_trimmed_exact_to_oracle",
        "original_obfuscated_trimmed_agreement",
    )
    if not all(case.get(field) is True for field in exact_flags):
        raise ValueError(f"Selected case lacks exact JDK acceptance flags: {key}")
    file_hash_fields = (
        ("stdin_path", "input_sha256"),
        ("expected_output_path", "raw_expected_stdout_sha256"),
        ("original_stdout_path", "raw_original_stdout_sha256"),
        ("original_stderr_path", "raw_original_stderr_sha256"),
        ("obfuscated_stdout_path", "raw_obfuscated_stdout_sha256"),
        ("obfuscated_stderr_path", "raw_obfuscated_stderr_sha256"),
    )
    for path_field, hash_field in file_hash_fields:
        path = _generated_file(output_root, case.get(path_field), f"{key}/{path_field}")
        expected_hash = case.get(hash_field)
        if not isinstance(expected_hash, str) or sha256_file(path) != expected_hash:
            raise ValueError(f"Static JDK artifact hash mismatch: {key}/{path_field}")

    validation_path = _generated_file(
        output_root, case.get("validation_path"), f"{key}/validation_path"
    )
    validation = base.read_json(validation_path)
    if not isinstance(validation, Mapping) or validation.get("accepted") is not True:
        raise ValueError(f"JDK validation is not accepted: {key}")
    requirements = validation.get("requirements")
    if not isinstance(requirements, Mapping) or not requirements or not all(
        value is True for value in requirements.values()
    ):
        raise ValueError(f"JDK validation requirements are incomplete: {key}")
    if validation.get("original_obfuscated_trimmed_agreement") is not True:
        raise ValueError(f"JDK validation source outputs disagree: {key}")
    for side_name in ("original", "obfuscated"):
        side = validation.get(side_name)
        if not isinstance(side, Mapping) or side.get("accepted") is not True:
            raise ValueError(f"JDK {side_name} validation is not accepted: {key}")
        compile_result = side.get("compile")
        if (
            not isinstance(compile_result, Mapping)
            or compile_result.get("accepted") is not True
            or compile_result.get("timed_out") is not False
            or compile_result.get("exit_code") != 0
            or compile_result.get("stdout") != ""
            or compile_result.get("stderr") != ""
        ):
            raise ValueError(f"JDK {side_name} compile evidence is invalid: {key}")
        cases = side.get("cases")
        if not isinstance(cases, list) or len(cases) != 1 or not isinstance(cases[0], Mapping):
            raise ValueError(f"JDK {side_name} case evidence is malformed: {key}")
        run = cases[0]
        if (
            run.get("accepted") is not True
            or run.get("timed_out") is not False
            or run.get("exit_code") != 0
            or run.get("stderr") != ""
            or run.get("trimmed_exact_match") is not True
        ):
            raise ValueError(f"JDK {side_name} runtime evidence is invalid: {key}")


def _verify_loaded_manifest(
    manifest_path: Path,
    expected_by_sample: Mapping[str, Mapping[str, Any]],
    *,
    wave_number: int,
) -> dict[str, Any]:
    # Importing the runner here exercises its real loader. It does not launch a
    # model or touch an output root.
    import run_long_code_experiment as runner

    samples, _ = runner.load_manifest(manifest_path)
    expected_case_count = int(WAVE_SPECS[wave_number]["case_count"])
    expected_ids = set(expected_by_sample)
    loaded_ids = {sample.sample_id for sample in samples}
    if len(samples) != expected_case_count or loaded_ids != expected_ids:
        raise ValueError(
            f"Runner-expanded Wave-{wave_number} sample IDs/count differ from the manifest"
        )
    checks: list[dict[str, Any]] = []
    for sample in samples:
        expected = expected_by_sample[sample.sample_id]
        row = {
            "sample_id": sample.sample_id,
            "stdin_sha256_loaded": sha256_text(sample.stdin),
            "stdin_sha256_expected": expected.get("input_sha256"),
            "oracle_sha256_loaded": sha256_text(sample.expected_stdout or ""),
            "oracle_sha256_expected": expected.get("raw_expected_stdout_sha256"),
            "original_sha256_loaded": sha256_file(sample.original_path),
            "original_sha256_expected": expected.get("original_sha256"),
            "obfuscated_sha256_loaded": sha256_file(sample.obfuscated_path),
            "obfuscated_sha256_expected": expected.get("obfuscated_sha256"),
        }
        pairs = (
            ("stdin_sha256_loaded", "stdin_sha256_expected"),
            ("oracle_sha256_loaded", "oracle_sha256_expected"),
            ("original_sha256_loaded", "original_sha256_expected"),
            ("obfuscated_sha256_loaded", "obfuscated_sha256_expected"),
        )
        row["all_match"] = all(
            isinstance(row[right], str) and row[left] == row[right] for left, right in pairs
        )
        checks.append(row)
    if not all(row["all_match"] for row in checks):
        raise RuntimeError(f"Runner-loaded Wave-{wave_number} child hashes do not match")
    return {
        "schema_version": "long-code-balanced-extension2-loader-audit-v1",
        "wave_id": WAVE_SPECS[wave_number]["wave_id"],
        "manifest": str(manifest_path.relative_to(WORK_ROOT)),
        "manifest_sha256": sha256_file(manifest_path),
        "expanded_case_count": len(samples),
        "parent_shadow_regression_checked": True,
        "all_loaded_hashes_match": True,
        "checks": checks,
    }


def verify_tokenizer_wave(output_root: Path, wave_number: int) -> dict[str, Any]:
    spec = WAVE_SPECS[wave_number]
    label = f"Wave-{wave_number}"
    expected_case_count = int(spec["case_count"])
    expected_cases_per_problem = int(spec["cases_per_problem"])
    pre_manifest = base.require_file(
        output_root / f"wave_{wave_number}_manifest_pre_tokenizer.json",
        f"{label} pre-tokenizer manifest",
    )
    preflight_dir = output_root / "tokenizer_preflight" / f"wave_{wave_number}"
    if not preflight_dir.is_dir():
        raise FileNotFoundError(f"{label} tokenizer directory: {preflight_dir}")
    report_path = base.require_file(preflight_dir / "full_report.json", f"{label} tokenizer report")
    filtered_path = base.require_file(
        preflight_dir / "inference_eligible_variants.json", f"{label} filtered manifest"
    )
    exclusions_path = base.require_file(
        preflight_dir / "exclusions.jsonl", f"{label} tokenizer exclusions"
    )
    report = base.read_json(report_path)
    filtered = base.read_json(filtered_path)
    pre_payload = base.read_json(pre_manifest)

    expected_counts = {
        "exploded_denominator_records": expected_case_count,
        "inference_eligible_records": expected_case_count,
        "excluded_records": 0,
        "preflight_error_records": 0,
    }
    counts = report.get("counts") if isinstance(report, Mapping) else None
    if not isinstance(counts, Mapping):
        raise ValueError(f"{label} tokenizer report lacks counts")
    for key, expected in expected_counts.items():
        if counts.get(key) != expected:
            raise ValueError(f"{label} tokenizer {key}={counts.get(key)} expected={expected}")
    if exclusions_path.read_text(encoding="utf-8") != "":
        raise ValueError(f"{label} tokenizer exclusions file is not empty")

    source = report.get("source_manifest")
    if not isinstance(source, Mapping) or source.get("sha256") != sha256_file(pre_manifest):
        raise ValueError(f"Tokenizer report is not bound to the {label} source manifest")
    tokenizer = report.get("tokenizer")
    if not isinstance(tokenizer, Mapping):
        raise ValueError(f"{label} tokenizer provenance is missing")
    if tokenizer.get("model_id") != MODEL_ID or tokenizer.get("snapshot_commit") != MODEL_SNAPSHOT:
        raise ValueError(f"{label} tokenizer model/snapshot mismatch")
    if tokenizer.get("model_weights_loaded") is not False or not tokenizer.get("files"):
        raise ValueError(f"{label} provenance does not prove tokenizer-only loading")

    records = report.get("records")
    if not isinstance(records, list) or len(records) != expected_case_count:
        raise ValueError(f"{label} tokenizer record count mismatch")
    for record in records:
        if not isinstance(record, Mapping):
            raise ValueError(f"{label} contains a malformed tokenizer record")
        if record.get("decision", {}).get("inference_eligible") is not True:
            raise ValueError(f"{label} contains a non-passing tokenizer record")
        if record.get("slicing_prior", {}).get("algorithm_fallback_detected") is not False:
            raise ValueError(f"{label} contains a positional-fallback record")
        if record.get("slice_hybrid", {}).get("case_signal_active") is not True:
            raise ValueError(f"{label} contains an inactive CASES record")
        prompt = record.get("prompt", {})
        if prompt.get("token_preflight", {}).get("fits_context") is not True:
            raise ValueError(f"{label} contains a context-overflow record")
        markers = prompt.get("markers", {})
        marker_keys = ("cases_begin_present", "cases_end_present", "c001_spec_present")
        if not all(markers.get(key) is True for key in marker_keys):
            raise ValueError(f"{label} prompt marker evidence is incomplete")
        if prompt.get("codesteer_instruction_equals_obfuscated_plain") is not True:
            raise ValueError(f"{label} CodeSteer/plain prompt contract differs")

    if not isinstance(filtered, Mapping) or not isinstance(pre_payload, Mapping):
        raise ValueError(f"{label} manifest payload is malformed")
    pre_map = _expanded_case_map(pre_payload, wave_number=wave_number)
    filtered_map = _expanded_case_map(filtered, wave_number=wave_number)
    if set(pre_map) != set(filtered_map):
        raise ValueError(f"Filtered {label} sample ids differ from the preflight denominator")
    if filtered.get("schema_version") != extension2.SCHEMA_VERSION:
        raise ValueError(f"Filtered {label} manifest schema mismatch")
    if filtered.get("case_count") != expected_case_count:
        raise ValueError(f"Filtered {label} manifest case_count mismatch")
    if filtered.get("state") != "exact_tokenizer_gate_passed":
        raise ValueError(f"Filtered {label} manifest carries stale tokenizer state")
    if filtered.get("wave_id") != spec["wave_id"]:
        raise ValueError(f"Filtered {label} manifest carries the wrong wave id")
    required_disclosures = {
        "timing_disclosure": extension2.TIMING_DISCLOSURE,
        "adaptive_status_disclosure": extension2.ADAPTIVE_STATUS_DISCLOSURE,
        "preparation_read_disclosure": extension2.PREPARATION_READ_DISCLOSURE,
        "denominator_disclosure": extension2.DENOMINATOR_DISCLOSURE,
    }
    for field, expected in required_disclosures.items():
        if filtered.get(field) != expected or pre_payload.get(field) != expected:
            raise ValueError(f"{label} manifest lost or changed {field}")
    required_manifest_fields = {
        "frozen_source_denominator": 25,
        "tokenizer_eligible_source_denominator": 23,
        "canonical_problem_count": EXPECTED_PROBLEMS,
        "cases_per_problem": expected_cases_per_problem,
        "variant_count": EXPECTED_PROBLEMS,
        "accepted_ranks_per_problem": list(spec["ranks"]),
    }
    for field, expected in required_manifest_fields.items():
        if filtered.get(field) != expected or pre_payload.get(field) != expected:
            raise ValueError(f"{label} manifest {field} is not exact")

    keys: set[tuple[int, str, int]] = set()
    row_counts: Counter[int] = Counter()
    rank_counts: Counter[int] = Counter()
    ranks_by_row: dict[int, set[int]] = {}
    for case in filtered_map.values():
        key = _case_key(case)
        if key in keys:
            raise ValueError(f"Duplicate {label} canonical case key: {key}")
        keys.add(key)
        row_counts[key[0]] += 1
        rank = case.get("accepted_rank")
        if not isinstance(rank, int):
            raise ValueError(f"{label} case has no accepted rank: {key}")
        rank_counts[rank] += 1
        ranks_by_row.setdefault(key[0], set()).add(rank)
        metadata = case["source_case_metadata"]
        if metadata.get("wave_id") != spec["wave_id"]:
            raise ValueError(f"{label} case carries the wrong wave id: {key}")
    if len(keys) != expected_case_count or len(row_counts) != EXPECTED_PROBLEMS:
        raise ValueError(f"{label} canonical case/problem count mismatch")
    if set(row_counts.values()) != {expected_cases_per_problem}:
        raise ValueError(
            f"{label} is not exactly balanced at {expected_cases_per_problem} cases per problem"
        )
    expected_ranks = set(spec["ranks"])
    if set(rank_counts) != expected_ranks or set(rank_counts.values()) != {EXPECTED_PROBLEMS}:
        raise ValueError(f"{label} accepted-rank counts are not exact")
    if any(ranks != expected_ranks for ranks in ranks_by_row.values()):
        raise ValueError(f"A {label} problem does not carry the exact accepted ranks")
    for case in pre_map.values():
        _verify_static_jdk_case(output_root, case)

    loader_audit = _verify_loaded_manifest(
        filtered_path, filtered_map, wave_number=wave_number
    )
    source_map = {
        _variant_id(row): {
            "original_sha256": row["original"]["sha256"],
            "obfuscated_sha256": row["obfuscated"]["sha256"],
        }
        for row in _variants(filtered, label)
    }
    return {
        "wave_number": wave_number,
        "wave_id": spec["wave_id"],
        "pre_tokenizer_manifest": str(pre_manifest.relative_to(WORK_ROOT)),
        "pre_tokenizer_manifest_sha256": sha256_file(pre_manifest),
        "tokenizer_report": str(report_path.relative_to(WORK_ROOT)),
        "tokenizer_report_sha256": sha256_file(report_path),
        "filtered_manifest": str(filtered_path.relative_to(WORK_ROOT)),
        "filtered_manifest_sha256": sha256_file(filtered_path),
        "tokenizer_files": tokenizer["files"],
        "case_count": len(filtered_map),
        "canonical_problem_count": len(row_counts),
        "accepted_ranks_per_problem": list(spec["ranks"]),
        "canonical_row_indices": sorted(row_counts),
        "source_hashes_by_variant": source_map,
        "canonical_case_keys": [list(key) for key in sorted(keys)],
        "sample_ids": sorted(filtered_map),
        "loader_hash_audit": loader_audit,
        "static_jdk_evidence_case_count": len(pre_map),
    }


def _assert_prospective_roots_absent() -> None:
    """Check only the exact future paths; never enumerate an inference root."""
    inference_root = WORK_ROOT / "balanced_extension2_contingency_inference"
    if inference_root.exists():
        raise FileExistsError(f"Prospective inference root already exists: {inference_root}")
    for wave_number in WAVE_SPECS:
        wave_root = WORK_ROOT / "balanced_extension2_contingency_inference" / f"wave_{wave_number}"
        if wave_root.exists():
            raise FileExistsError(f"Prospective inference wave root already exists: {wave_root}")
        for shard_index in range(GPU_COUNT):
            shard_root = wave_root / f"shard_{shard_index}"
            if shard_root.exists():
                raise FileExistsError(f"Prospective inference shard root already exists: {shard_root}")


def launch_plan(
    *,
    wave_number: int,
    manifest_path: Path,
    sample_ids: Sequence[str],
    runner_path: Path,
) -> dict[str, Any]:
    spec = WAVE_SPECS[wave_number]
    expected_case_count = int(spec["case_count"])
    expected_shard_cases = list(spec["shard_cases"])
    expected_shard_records = list(spec["shard_records"])
    launch_working_directory = WORK_ROOT
    manifest_arg = os.path.relpath(manifest_path, launch_working_directory)
    runner_arg = os.path.relpath(runner_path, launch_working_directory)
    prospective_root = WORK_ROOT / "balanced_extension2_contingency_inference" / f"wave_{wave_number}"
    if prospective_root.exists():
        raise FileExistsError(f"Prospective inference wave root already exists: {prospective_root}")

    assignments: list[list[str]] = [[] for _ in range(GPU_COUNT)]
    for index, sample_id in enumerate(sorted(sample_ids)):
        assignments[index % GPU_COUNT].append(sample_id)
    if [len(values) for values in assignments] != expected_shard_cases:
        raise RuntimeError(
            f"Wave-{wave_number} shard sizes are not exact: {expected_shard_cases}"
        )

    shards: list[dict[str, Any]] = []
    for gpu_id, assigned in enumerate(assignments):
        output_root = prospective_root / f"shard_{gpu_id}"
        if output_root.exists():
            raise FileExistsError(f"Prospective inference shard root exists: {output_root}")
        output_arg = os.path.relpath(output_root, launch_working_directory)
        expected_output_arg = (
            f"balanced_extension2_contingency_inference/wave_{wave_number}/shard_{gpu_id}"
        )
        if output_arg != expected_output_arg:
            raise RuntimeError(f"Prospective output path is not exact: {output_arg}")
        argv = [
            "python3",
            runner_arg,
            "--manifest",
            manifest_arg,
            "--output-root",
            output_arg,
            "--trials",
            str(TRIALS),
            "--base-seed",
            str(BASE_SEED),
            "--gpu-ids",
            str(gpu_id),
            "--sample-ids",
            ",".join(assigned),
        ]
        shards.append(
            {
                "shard_index": gpu_id,
                "gpu_id": str(gpu_id),
                "tmux_session": f"longcode_bal_ext2_w{wave_number}_g{gpu_id}",
                "output_root": output_arg,
                "sample_count": len(assigned),
                "sample_ids": assigned,
                "expected_run_records": len(assigned) * TRIALS * CONDITIONS,
                "argv": argv,
                "command": shlex.join(argv),
            }
        )
    flattened = [sample_id for shard in shards for sample_id in shard["sample_ids"]]
    if sorted(flattened) != sorted(sample_ids) or len(flattened) != len(set(flattened)):
        raise RuntimeError(f"Wave-{wave_number} launch assignments are not an exact partition")
    if [row["expected_run_records"] for row in shards] != expected_shard_records:
        raise RuntimeError(f"Wave-{wave_number} shard record counts are not exact")
    if len(flattened) != expected_case_count:
        raise RuntimeError(
            f"Wave-{wave_number} launch plan does not cover exactly {expected_case_count} samples"
        )
    for path_arg in [runner_arg, manifest_arg, *(row["output_root"] for row in shards)]:
        if Path(path_arg).is_absolute() or path_arg.startswith("long-code-sample-work/"):
            raise RuntimeError(f"Launch path is not HERE-relative: {path_arg}")

    trigger = (
        f"Launch only after {spec['prior_wave_must_be_complete']} is complete and a complete "
        f"valid {spec['trigger_audit']} audit reports fewer than 10 distinct strict canonical "
        "CodeContests problems; do not launch if the threshold has been reached."
    )
    return {
        "schema_version": "long-code-balanced-extension2-launch-plan-v1",
        "state": "frozen_not_launched",
        "wave_id": spec["wave_id"],
        "wave_number": wave_number,
        "conditional_trigger": trigger,
        "prior_wave_must_be_complete": spec["prior_wave_must_be_complete"],
        "trigger_audit": spec["trigger_audit"],
        "strict_canonical_problem_threshold": 10,
        "stop_later_waves_if_threshold_reached": True,
        "interim_looks_within_wave_allowed": False,
        "adaptive_outcome_aware_from_wave_2": True,
        "adaptive_not_preregistered": True,
        "outcome_blind_in_timing": False,
        "wave_3_outputs_or_results_inspected": False,
        "case_ranking_outcome_independent": True,
        "working_directory": str(launch_working_directory),
        "working_directory_label": "long-code-sample-work",
        "path_resolution_rule": (
            "runner, manifest, and output-root arguments are HERE-relative to working_directory; "
            "the runner resolves output-root beneath this WORK_ROOT exactly once"
        ),
        "runner": runner_arg,
        "runner_sha256": sha256_file(runner_path),
        "manifest": manifest_arg,
        "manifest_sha256": sha256_file(manifest_path),
        "model": MODEL_ID,
        "model_type": "base",
        "trials_per_case": TRIALS,
        "conditions_per_trial": CONDITIONS,
        "do_sample": True,
        "temperature": 1.05,
        "top_p": 0.95,
        "top_k": 7,
        "max_new_tokens": 512,
        "base_seed": BASE_SEED,
        "sample_count": len(sample_ids),
        "accepted_ranks_per_problem": list(spec["ranks"]),
        "expected_run_records": len(sample_ids) * TRIALS * CONDITIONS,
        "shard_count": GPU_COUNT,
        "samples_per_shard": [len(values) for values in assignments],
        "expected_run_records_per_shard": [
            len(values) * TRIALS * CONDITIONS for values in assignments
        ],
        "result_roots_created": False,
        "shards": shards,
    }


def _inventory_files(output_root: Path) -> list[dict[str, Any]]:
    excluded = {"freeze_manifest.json", "FREEZE.sha256"}
    rows: list[dict[str, Any]] = []
    for path in sorted(output_root.rglob("*")):
        if path.is_symlink():
            raise ValueError(f"Generated artifact inventory contains a symlink: {path}")
        if not path.is_file() or path.name in excluded:
            continue
        rows.append(
            {
                "path": str(path.relative_to(output_root)),
                "bytes": path.stat().st_size,
                "sha256": sha256_file(path),
            }
        )
    paths = [row["path"] for row in rows]
    if len(paths) != len(set(paths)):
        raise RuntimeError("Generated artifact inventory has duplicate paths")
    return rows


def _verify_previous_disjointness(
    output_root: Path, wave_audits: Mapping[int, Mapping[str, Any]]
) -> int:
    previous = base.read_json(
        base.require_file(output_root / "previous_screened_case_audit.json", "previous-screen audit")
    )
    if not isinstance(previous, Mapping):
        raise ValueError("Previous-screen audit is malformed")
    required_record_counts = {
        "initial_case_record_count": 23,
        "supplemental_case_record_count": 60,
        "wave_1_case_record_count": 38,
        "wave_2_case_record_count": 38,
        "wave_3_case_record_count": 114,
    }
    for key, expected in required_record_counts.items():
        if previous.get(key) != expected:
            raise ValueError(f"Previous-screen audit {key} mismatch")
    records = previous.get("records")
    if not isinstance(records, list) or len(records) != sum(required_record_counts.values()):
        raise ValueError("Previous-screen audit record denominator is not exact")
    previous_keys: set[tuple[int, str, int]] = set()
    for record in records:
        if not isinstance(record, Mapping):
            raise ValueError("Previous-screen audit contains a malformed record")
        raw_key = record.get("canonical_case_key")
        if (
            not isinstance(raw_key, list)
            or len(raw_key) != 3
            or not isinstance(raw_key[0], int)
            or raw_key[1] not in base.SUITES
            or not isinstance(raw_key[2], int)
        ):
            raise ValueError(f"Malformed prior canonical case key: {raw_key}")
        previous_keys.add((raw_key[0], raw_key[1], raw_key[2]))
    if previous.get("combined_unique_canonical_case_count") != len(previous_keys):
        raise ValueError("Previous-screen unique canonical case count is not exact")
    if previous.get("cross_new_wave_overlap_count") != 0:
        raise RuntimeError("Preparation cross-new-wave overlap count is not zero")

    all_new: set[tuple[int, str, int]] = set()
    for wave_number, audit in wave_audits.items():
        keys = {tuple(key) for key in audit["canonical_case_keys"]}
        if keys & previous_keys:
            raise RuntimeError(f"Tokenizer-filtered Wave {wave_number} overlaps a prior case")
        if keys & all_new:
            raise RuntimeError(f"Tokenizer-filtered Wave {wave_number} overlaps another new wave")
        all_new.update(keys)
        overlap_key = f"wave_{wave_number}_overlap_count"
        if previous.get(overlap_key) != 0:
            raise RuntimeError(f"Preparation {overlap_key} is not exactly zero")
    if len(all_new) != EXPECTED_TOTAL_CASES:
        raise RuntimeError(
            f"Waves 4--5 are not {EXPECTED_TOTAL_CASES} mutually unique canonical cases"
        )
    return len(previous_keys)


def _verify_source_audit(output_root: Path) -> Mapping[str, Any]:
    source_audit = base.read_json(
        base.require_file(output_root / "source_denominator_audit.json", "source denominator audit")
    )
    if not isinstance(source_audit, Mapping):
        raise ValueError("Source denominator audit is malformed")
    if source_audit.get("schema_version") != extension2.SCHEMA_VERSION:
        raise ValueError("Source denominator audit schema mismatch")
    required_disclosures = {
        "timing_disclosure": extension2.TIMING_DISCLOSURE,
        "adaptive_status_disclosure": extension2.ADAPTIVE_STATUS_DISCLOSURE,
        "preparation_read_disclosure": extension2.PREPARATION_READ_DISCLOSURE,
        "denominator_disclosure": extension2.DENOMINATOR_DISCLOSURE,
    }
    for field, expected in required_disclosures.items():
        if source_audit.get(field) != expected:
            raise ValueError(f"Source denominator audit {field} mismatch")
    required = {
        "frozen_source_denominator": 25,
        "tokenizer_eligible_source_count": 23,
        "canonical_problem_count": EXPECTED_PROBLEMS,
        "chosen_source_count": EXPECTED_PROBLEMS,
        "wave_4_case_count": int(WAVE_SPECS[4]["case_count"]),
        "wave_5_case_count": int(WAVE_SPECS[5]["case_count"]),
        "rank25_feasibility_failure_preserved": True,
        "rank20_feasibility_failure_preserved": True,
    }
    for key, expected in required.items():
        if source_audit.get(key) != expected:
            raise ValueError(f"Source denominator audit {key} mismatch")
    expected_rank_map = {
        f"wave_{wave_number}": list(spec["ranks"]) for wave_number, spec in WAVE_SPECS.items()
    }
    if source_audit.get("accepted_ranks_per_problem_by_wave") != expected_rank_map:
        raise ValueError("Source denominator audit accepted-rank map is not exact")
    if source_audit.get("prior_accepted_ranks_revalidated_per_problem") != 10:
        raise ValueError("Source denominator audit does not prove ranks 1--10 were revalidated")
    return source_audit


def _verify_rank25_feasibility_failure(output_root: Path) -> dict[str, Any]:
    audit_path = base.require_file(
        output_root / "rank25_feasibility_failure_audit.json",
        "rank-25 feasibility failure audit",
    )
    audit = base.read_json(audit_path)
    if not isinstance(audit, Mapping):
        raise ValueError("Rank-25 feasibility failure audit is malformed")
    expected_top_level = {
        "schema_version",
        "original_proposal",
        "failure",
        "prospective_revision",
        "evidence_root",
        "external_preserved_archive",
        "evidence_file_count",
        "evidence_inventory_sha256",
        "evidence_files",
        "model_result_files_read",
        "wave_3_result_files_read",
        "model_inference_calls",
    }
    if set(audit) != expected_top_level:
        raise ValueError("Rank-25 feasibility failure audit field set is not exact")
    if audit.get("schema_version") != RANK25_FAILURE_SCHEMA:
        raise ValueError("Rank-25 feasibility failure audit schema mismatch")
    expected_original = {
        "wave_6_accepted_ranks_per_problem": [21, 22, 23, 24, 25],
        "cases_per_problem": 5,
        "case_count": 95,
    }
    if audit.get("original_proposal") != expected_original:
        raise ValueError("Rank-25 feasibility audit does not preserve the original proposal")
    expected_failure = {
        "row_index": RANK25_LIMITING_ROW,
        "variant_id": RANK25_LIMITING_VARIANT,
        "statically_eligible_candidate_count": 202,
        "jdk_executed_candidate_count": 202,
        "accepted_rank_count": 24,
        "prior_frozen_accepted_rank_count": 10,
        "new_accepted_rank_count": 14,
        "missing_accepted_rank": 25,
        "exact_19_by_5_possible": False,
        "preparer_exit_message": RANK25_FAILURE_MESSAGE,
    }
    if audit.get("failure") != expected_failure:
        raise ValueError("Rank-25 feasibility failure facts are not exact")
    expected_revision = {
        "wave_6_accepted_ranks_per_problem": [21, 22, 23, 24],
        "cases_per_problem": 4,
        "case_count": 76,
        "largest_uniform_block_across_same_19_problems": True,
        "specified_before_any_wave_3_output_or_result_inspection": True,
    }
    if audit.get("prospective_revision") != expected_revision:
        raise ValueError("Prospective Wave-6 revision is not exact")
    if audit.get("evidence_root") != "rank25_feasibility_failure":
        raise ValueError("Rank-25 feasibility evidence root is not exact")
    if audit.get("external_preserved_archive") != "balanced_extension2_rank25_feasibility_failure":
        raise ValueError("Rank-25 external-preservation label is not exact")
    for field in ("model_result_files_read", "wave_3_result_files_read", "model_inference_calls"):
        if audit.get(field) != 0:
            raise ValueError(f"Rank-25 feasibility audit {field} is not zero")

    evidence_root = output_root / "rank25_feasibility_failure"
    if not evidence_root.is_dir() or evidence_root.is_symlink():
        raise FileNotFoundError(f"Rank-25 feasibility evidence directory is invalid: {evidence_root}")
    actual_files: list[dict[str, Any]] = []
    for path in sorted(evidence_root.rglob("*")):
        if path.is_symlink():
            raise ValueError(f"Rank-25 feasibility evidence contains a symlink: {path}")
        if not path.is_file():
            continue
        relative = str(path.relative_to(evidence_root))
        if not (relative.startswith("validation/") or relative.startswith("tests/")):
            raise ValueError(f"Unexpected rank-25 feasibility evidence path: {relative}")
        actual_files.append(
            {"path": relative, "bytes": path.stat().st_size, "sha256": sha256_file(path)}
        )
    if len(actual_files) != 641:
        raise ValueError(
            f"Rank-25 feasibility evidence has {len(actual_files)} files, expected exactly 641"
        )
    recorded_files = audit.get("evidence_files")
    if recorded_files != actual_files or audit.get("evidence_file_count") != len(actual_files):
        raise ValueError("Rank-25 feasibility evidence inventory does not match the copied tree")
    inventory_digest = sha256_text(
        json.dumps(actual_files, sort_keys=True, ensure_ascii=False, separators=(",", ":"))
    )
    if audit.get("evidence_inventory_sha256") != inventory_digest:
        raise ValueError("Rank-25 feasibility evidence inventory digest mismatch")

    row_validation_root = evidence_root / "validation" / RANK25_LIMITING_VARIANT
    if not row_validation_root.is_dir() or row_validation_root.is_symlink():
        raise FileNotFoundError("Preserved row-27 validation directory is missing")
    validation_files = sorted(row_validation_root.rglob("*.json"))
    if len(validation_files) != 202 or not all(path.is_file() for path in validation_files):
        raise ValueError("Preserved row-27 validation denominator is not exactly 202")
    accepted_count = 0
    for path in validation_files:
        if path.is_symlink():
            raise ValueError(f"Preserved row-27 validation is a symlink: {path}")
        payload = base.read_json(path)
        if not isinstance(payload, Mapping) or not isinstance(payload.get("accepted"), bool):
            raise ValueError(f"Malformed preserved row-27 validation: {path}")
        accepted_count += int(payload["accepted"])
    if accepted_count != 24:
        raise ValueError(f"Preserved row-27 JDK-valid count is {accepted_count}, expected 24")
    return {
        "audit": str(audit_path.relative_to(WORK_ROOT)),
        "audit_sha256": sha256_file(audit_path),
        "evidence_root": str(evidence_root.relative_to(WORK_ROOT)),
        "evidence_file_count": len(actual_files),
        "evidence_inventory_sha256": inventory_digest,
        "limiting_row_index": RANK25_LIMITING_ROW,
        "statically_eligible_candidate_count": 202,
        "jdk_executed_candidate_count": len(validation_files),
        "jdk_valid_accepted_rank_count": accepted_count,
        "original_rank_25_proposal_failed_closed": True,
        "first_revision_wave_6_was_largest_uniform_block_after_rank25_failure": True,
    }


def _verify_rank20_feasibility_failure(output_root: Path) -> dict[str, Any]:
    audit_path = base.require_file(
        output_root / "rank20_feasibility_failure_audit.json",
        "rank-20 feasibility failure audit",
    )
    audit = base.read_json(audit_path)
    if not isinstance(audit, Mapping):
        raise ValueError("Rank-20 feasibility failure audit is malformed")
    expected_top_level = {
        "schema_version",
        "failed_design",
        "failure",
        "prospective_final_design",
        "evidence_root",
        "external_preserved_archive",
        "evidence_file_count",
        "evidence_inventory_sha256",
        "evidence_files",
        "model_result_files_read",
        "wave_3_result_files_read",
        "model_inference_calls",
    }
    if set(audit) != expected_top_level:
        raise ValueError("Rank-20 feasibility failure audit field set is not exact")
    if audit.get("schema_version") != RANK20_FAILURE_SCHEMA:
        raise ValueError("Rank-20 feasibility failure audit schema mismatch")
    expected_failed_design = {
        "wave_4_accepted_ranks_per_problem": [11, 12, 13, 14, 15],
        "wave_5_accepted_ranks_per_problem": [16, 17, 18, 19, 20],
        "wave_6_accepted_ranks_per_problem": [21, 22, 23, 24],
        "case_count_by_wave": {
            "balanced_wave_4": 95,
            "balanced_wave_5": 95,
            "balanced_wave_6": 76,
        },
    }
    if audit.get("failed_design") != expected_failed_design:
        raise ValueError("Rank-20 audit does not preserve the failed three-wave design")
    expected_failure = {
        "row_index": RANK20_LIMITING_ROW,
        "variant_id": RANK20_LIMITING_VARIANT,
        "statically_eligible_candidate_count": 255,
        "jdk_executed_candidate_count": 255,
        "accepted_rank_count": 19,
        "prior_frozen_accepted_rank_count": 10,
        "new_accepted_rank_count": 9,
        "missing_accepted_rank": 20,
        "exact_wave_5_19_by_5_possible": False,
        "any_uniform_wave_6_possible": False,
        "preparer_exit_message": RANK20_FAILURE_MESSAGE,
    }
    if audit.get("failure") != expected_failure:
        raise ValueError("Rank-20 feasibility failure facts are not exact")
    expected_final_design = {
        "wave_4_accepted_ranks_per_problem": [11, 12, 13, 14, 15],
        "wave_4_cases_per_problem": 5,
        "wave_4_case_count": 95,
        "wave_5_accepted_ranks_per_problem": [16, 17, 18, 19],
        "wave_5_cases_per_problem": 4,
        "wave_5_case_count": 76,
        "wave_count": 2,
        "wave_6_removed": True,
        "largest_uniform_two_wave_design_across_same_19_problems": True,
        "specified_before_any_wave_3_output_or_result_inspection": True,
    }
    if audit.get("prospective_final_design") != expected_final_design:
        raise ValueError("Prospective final two-wave design is not exact")
    if audit.get("evidence_root") != "rank20_feasibility_failure":
        raise ValueError("Rank-20 feasibility evidence root is not exact")
    if audit.get("external_preserved_archive") != "balanced_extension2_rank20_feasibility_failure":
        raise ValueError("Rank-20 external-preservation label is not exact")
    for field in ("model_result_files_read", "wave_3_result_files_read", "model_inference_calls"):
        if audit.get(field) != 0:
            raise ValueError(f"Rank-20 feasibility audit {field} is not zero")

    evidence_root = output_root / "rank20_feasibility_failure"
    if not evidence_root.is_dir() or evidence_root.is_symlink():
        raise FileNotFoundError(f"Rank-20 feasibility evidence directory is invalid: {evidence_root}")
    actual_files: list[dict[str, Any]] = []
    for path in sorted(evidence_root.rglob("*")):
        if path.is_symlink():
            raise ValueError(f"Rank-20 feasibility evidence contains a symlink: {path}")
        if not path.is_file():
            continue
        relative = str(path.relative_to(evidence_root))
        if not (relative.startswith("validation/") or relative.startswith("tests/")):
            raise ValueError(f"Unexpected rank-20 feasibility evidence path: {relative}")
        actual_files.append(
            {"path": relative, "bytes": path.stat().st_size, "sha256": sha256_file(path)}
        )
    if len(actual_files) != 1071:
        raise ValueError(
            f"Rank-20 feasibility evidence has {len(actual_files)} files, expected exactly 1071"
        )
    recorded_files = audit.get("evidence_files")
    if recorded_files != actual_files or audit.get("evidence_file_count") != len(actual_files):
        raise ValueError("Rank-20 feasibility evidence inventory does not match the copied tree")
    inventory_digest = sha256_text(
        json.dumps(actual_files, sort_keys=True, ensure_ascii=False, separators=(",", ":"))
    )
    if audit.get("evidence_inventory_sha256") != inventory_digest:
        raise ValueError("Rank-20 feasibility evidence inventory digest mismatch")

    row_validation_root = evidence_root / "validation" / RANK20_LIMITING_VARIANT
    if not row_validation_root.is_dir() or row_validation_root.is_symlink():
        raise FileNotFoundError("Preserved row-54 validation directory is missing")
    validation_files = sorted(row_validation_root.rglob("*.json"))
    if len(validation_files) != 255 or not all(path.is_file() for path in validation_files):
        raise ValueError("Preserved row-54 validation denominator is not exactly 255")
    accepted_count = 0
    for path in validation_files:
        if path.is_symlink():
            raise ValueError(f"Preserved row-54 validation is a symlink: {path}")
        payload = base.read_json(path)
        if not isinstance(payload, Mapping) or not isinstance(payload.get("accepted"), bool):
            raise ValueError(f"Malformed preserved row-54 validation: {path}")
        accepted_count += int(payload["accepted"])
    if accepted_count != 19:
        raise ValueError(f"Preserved row-54 JDK-valid count is {accepted_count}, expected 19")
    return {
        "audit": str(audit_path.relative_to(WORK_ROOT)),
        "audit_sha256": sha256_file(audit_path),
        "evidence_root": str(evidence_root.relative_to(WORK_ROOT)),
        "evidence_file_count": len(actual_files),
        "evidence_inventory_sha256": inventory_digest,
        "limiting_row_index": RANK20_LIMITING_ROW,
        "statically_eligible_candidate_count": 255,
        "jdk_executed_candidate_count": len(validation_files),
        "jdk_valid_accepted_rank_count": accepted_count,
        "rank_20_and_later_uniform_extension_failed_closed": True,
        "final_design_is_largest_uniform_two_wave_design": True,
        "wave_6_removed": True,
    }


def _verify_preparation_evidence(output_root: Path) -> dict[str, Any]:
    provenance = base.read_json(
        base.require_file(output_root / "provenance.json", "preparation provenance")
    )
    summary = base.read_json(base.require_file(output_root / "summary.json", "preparation summary"))
    loader = base.read_json(
        base.require_file(output_root / "loader_hash_audit.json", "preparation loader audit")
    )
    for payload, label in (
        (provenance, "provenance"),
        (summary, "summary"),
        (loader, "loader audit"),
    ):
        if not isinstance(payload, Mapping) or payload.get("schema_version") != extension2.SCHEMA_VERSION:
            raise ValueError(f"Preparation {label} schema mismatch")

    required_provenance = {
        "timing_disclosure": extension2.TIMING_DISCLOSURE,
        "adaptive_status_disclosure": extension2.ADAPTIVE_STATUS_DISCLOSURE,
        "preparation_read_disclosure": extension2.PREPARATION_READ_DISCLOSURE,
        "denominator_disclosure": extension2.DENOMINATOR_DISCLOSURE,
        "specified_during_live_wave_3": True,
        "prospectively_revised_during_live_wave_3": True,
        "prospective_revision_count": 2,
        "revision_completed_before_any_wave_3_output_or_result_inspection": True,
        "rank25_feasibility_failure_preserved": True,
        "rank20_feasibility_failure_preserved": True,
        "final_design_wave_count": 2,
        "wave_6_removed": True,
        "revision_uses_model_outcomes": False,
        "completed_wave_2_strict_canonical_problem_count": 4,
        "wave_3_outputs_results_or_result_files_inspected": False,
        "case_ranking_outcome_independent": True,
        "model_result_directories_listed": 0,
        "model_result_files_read": 0,
        "wave_3_result_files_read": 0,
        "model_inference_calls": 0,
        "model_weights_loaded": False,
        "public_test_values_read": 0,
        "frozen_inputs_unchanged": True,
    }
    for field, expected in required_provenance.items():
        if provenance.get(field) != expected:
            raise ValueError(f"Preparation provenance {field} mismatch")
    jdk = provenance.get("jdk")
    if not isinstance(jdk, Mapping):
        raise ValueError("Preparation provenance lacks JDK evidence")
    expected_java_home = str(extension2.DEFAULT_JAVA_HOME.resolve())
    if jdk.get("java_home") != expected_java_home:
        raise ValueError("Preparation used an unregistered JAVA_HOME")
    for tool_name in ("javac", "java"):
        tool = jdk.get(tool_name)
        if (
            not isinstance(tool, Mapping)
            or tool.get("returncode") != 0
            or tool.get("major") != 17
            or not isinstance(tool.get("version"), str)
            or not tool.get("version")
        ):
            raise ValueError(f"Preparation JDK {tool_name} evidence is invalid")
    executed = provenance.get("jdk_executed_candidate_count")
    rejected = provenance.get("jdk_validation_rejection_count")
    if not isinstance(executed, int) or executed < EXPECTED_PROBLEMS * 19:
        raise ValueError("Preparation did not execute enough JDK candidate validations")
    if not isinstance(rejected, int) or rejected < 0 or rejected > executed:
        raise ValueError("Preparation JDK rejection count is invalid")
    source_hash_audit = provenance.get("frozen_source_hash_audit")
    if not isinstance(source_hash_audit, list) or len(source_hash_audit) != EXPECTED_PROBLEMS * 2:
        raise ValueError("Frozen source hash audit denominator is not exact")
    if not all(
        isinstance(row, Mapping)
        and row.get("unchanged") is True
        and row.get("sha256_before") == row.get("sha256_after")
        for row in source_hash_audit
    ):
        raise ValueError("A frozen source lacks unchanged hash evidence")

    required_summary = {
        "state": "prepared_and_jdk_validated_tokenizer_gates_pending",
        "adaptive": True,
        "outcome_aware_from_completed_wave_2_aggregate": True,
        "preregistered": False,
        "outcome_blind_in_timing": False,
        "prospectively_revised_during_live_wave_3": True,
        "prospective_revision_count": 2,
        "revision_completed_before_any_wave_3_output_or_result_inspection": True,
        "rank25_feasibility_failure_preserved": True,
        "rank20_feasibility_failure_preserved": True,
        "final_design_wave_count": 2,
        "wave_6_removed": True,
        "revision_uses_model_outcomes": False,
        "wave_3_outputs_or_results_inspected": False,
        "case_ranking_outcome_independent": True,
        "source_denominator": 25,
        "tokenizer_eligible_source_count": 23,
        "canonical_problem_count": EXPECTED_PROBLEMS,
        "cases_per_problem_by_wave": {
            spec["wave_id"]: int(spec["cases_per_problem"])
            for spec in WAVE_SPECS.values()
        },
        "case_count_by_wave": {
            spec["wave_id"]: int(spec["case_count"]) for spec in WAVE_SPECS.values()
        },
        "total_selected_case_count": EXPECTED_TOTAL_CASES,
        "prior_accepted_ranks_revalidated_per_problem": 10,
        "overlap_with_initial_supplemental_wave_1_wave_2_wave_3": 0,
        "cross_new_wave_overlap": 0,
        "model_result_files_read": 0,
        "model_inference_calls": 0,
        "public_test_values_read": 0,
        "parent_shadow_regression_checked": True,
        "all_loaded_hashes_match": True,
        "result_roots_created": False,
    }
    for field, expected in required_summary.items():
        if summary.get(field) != expected:
            raise ValueError(f"Preparation summary {field} mismatch")
    if summary.get("jdk_executed_candidate_count") != executed:
        raise ValueError("Preparation summary/provenance JDK execution counts disagree")
    if summary.get("jdk_validation_rejection_count") != rejected:
        raise ValueError("Preparation summary/provenance JDK rejection counts disagree")
    if loader.get("parent_shadow_regression_checked") is not True:
        raise ValueError("Preparation loader audit missed the parent-shadow regression")
    if loader.get("all_loaded_hashes_match") is not True:
        raise ValueError("Preparation loader audit contains a child-hash mismatch")
    waves = loader.get("waves")
    if not isinstance(waves, Mapping) or set(waves) != {
        spec["wave_id"] for spec in WAVE_SPECS.values()
    }:
        raise ValueError("Preparation loader audit wave set is not exact")
    return {
        "java_home": expected_java_home,
        "javac_version": jdk["javac"]["version"],
        "java_version": jdk["java"]["version"],
        "jdk_executed_candidate_count": executed,
        "jdk_validation_rejection_count": rejected,
        "frozen_source_hash_record_count": len(source_hash_audit),
    }


def _control_files(runner: Path, preflight_script: Path) -> list[Path]:
    return [
        WORK_ROOT / "BALANCED_EXTENSION2_CONTINGENCY_PROTOCOL.md",
        WORK_ROOT / "balanced_extension2_contingency_protocol.json",
        WORK_ROOT / "prepare_balanced_extension2_contingency.py",
        Path(__file__).resolve(),
        WORK_ROOT / "test_prepare_balanced_extension2_contingency.py",
        WORK_ROOT / "BALANCED_EXTENSION_CONTINGENCY_PROTOCOL.md",
        WORK_ROOT / "balanced_extension_contingency_protocol.json",
        WORK_ROOT / "prepare_balanced_extension_contingency.py",
        WORK_ROOT / "finalize_balanced_extension_contingency.py",
        WORK_ROOT / "test_prepare_balanced_extension_contingency.py",
        WORK_ROOT / "BALANCED_CONTINGENCY_PROTOCOL.md",
        WORK_ROOT / "balanced_contingency_protocol.json",
        WORK_ROOT / "prepare_balanced_contingency.py",
        WORK_ROOT / "finalize_balanced_contingency.py",
        WORK_ROOT / "test_prepare_balanced_contingency.py",
        WORK_ROOT / "prepare_long_code_variants.py",
        WORK_ROOT / "prepare_supplemental_cases.py",
        runner,
        preflight_script,
        WORK_ROOT / "test_preflight_long_code_tokenizer.py",
    ]


def finalize(args: argparse.Namespace) -> int:
    output_root = extension2.require_output_root(args.output_root)
    if output_root != DEFAULT_OUTPUT_ROOT.resolve():
        raise ValueError(f"Final freeze root must be exactly {DEFAULT_OUTPUT_ROOT.resolve()}")
    if not output_root.is_dir():
        raise FileNotFoundError(output_root)
    freeze_path = output_root / "freeze_manifest.json"
    internal_anchor = output_root / "FREEZE.sha256"
    external_anchor = WORK_ROOT / "balanced_extension2_contingency.FREEZE.sha256"
    if freeze_path.exists() or internal_anchor.exists() or external_anchor.exists():
        raise FileExistsError("Second-extension freeze exists; refusing an implicit refreeze")
    runner = base.require_file(args.runner, "experiment runner").resolve()
    preflight_script = base.require_file(args.preflight_script, "tokenizer preflight script").resolve()
    if runner != DEFAULT_RUNNER.resolve() or preflight_script != DEFAULT_PREFLIGHT.resolve():
        raise ValueError("Runner and tokenizer preflight controls must be the exact registered files")
    _assert_prospective_roots_absent()

    wave_audits = {
        wave_number: verify_tokenizer_wave(output_root, wave_number)
        for wave_number in WAVE_SPECS
    }
    first_audit = wave_audits[min(WAVE_SPECS)]
    for wave_number, audit in wave_audits.items():
        if audit["canonical_row_indices"] != first_audit["canonical_row_indices"]:
            raise RuntimeError(f"Wave {wave_number} does not retain the same 19 canonical rows")
        if audit["source_hashes_by_variant"] != first_audit["source_hashes_by_variant"]:
            raise RuntimeError(f"Wave {wave_number} does not retain the same frozen sources")
        if audit["tokenizer_files"] != first_audit["tokenizer_files"]:
            raise RuntimeError(f"Wave {wave_number} tokenizer-file provenance differs")
    previous_unique_count = _verify_previous_disjointness(output_root, wave_audits)
    _verify_source_audit(output_root)
    rank25_failure_evidence = _verify_rank25_feasibility_failure(output_root)
    rank20_failure_evidence = _verify_rank20_feasibility_failure(output_root)
    preparation_evidence = _verify_preparation_evidence(output_root)

    plans: dict[int, dict[str, Any]] = {}
    for wave_number, audit in wave_audits.items():
        manifest_path = WORK_ROOT / audit["filtered_manifest"]
        plan = launch_plan(
            wave_number=wave_number,
            manifest_path=manifest_path,
            sample_ids=audit["sample_ids"],
            runner_path=runner,
        )
        plans[wave_number] = plan
        atomic_write_json(output_root / f"launch_plan_wave_{wave_number}.json", plan)

    final_summary = {
        "schema_version": extension2.SCHEMA_VERSION,
        "state": "fully_frozen_tokenizer_gated_not_launched",
        "timing_disclosure": extension2.TIMING_DISCLOSURE,
        "adaptive_status_disclosure": extension2.ADAPTIVE_STATUS_DISCLOSURE,
        "preparation_read_disclosure": extension2.PREPARATION_READ_DISCLOSURE,
        "specified_during_live_wave_3": True,
        "prospectively_revised_during_live_wave_3": True,
        "prospective_revision_count": 2,
        "revision_completed_before_any_wave_3_output_or_result_inspection": True,
        "completed_post_wave_2_unique_strict_canonical_problem_count": 4,
        "adaptive_outcome_aware_from_wave_2": True,
        "adaptive_not_preregistered": True,
        "outcome_blind_in_timing": False,
        "wave_3_outputs_or_results_inspected": False,
        "case_eligibility_ranking_selection_outcome_independent": True,
        "revision_uses_model_outcomes": False,
        "final_design_wave_count": 2,
        "wave_6_removed": True,
        "dataset": {
            "id": base.DATASET_ID,
            "revision": base.DATASET_REVISION,
            "split": base.DATASET_SPLIT,
            "file_sha256": base.DATASET_SHA256,
        },
        "source_denominator": 25,
        "tokenizer_eligible_source_count": 23,
        "canonical_problem_count": EXPECTED_PROBLEMS,
        "case_count_by_wave": {
            str(number): int(spec["case_count"]) for number, spec in WAVE_SPECS.items()
        },
        "cases_per_problem_by_wave": {
            str(number): int(spec["cases_per_problem"])
            for number, spec in WAVE_SPECS.items()
        },
        "total_frozen_new_cases": EXPECTED_TOTAL_CASES,
        "rank25_feasibility_failure": rank25_failure_evidence,
        "rank20_feasibility_failure": rank20_failure_evidence,
        "prior_unique_canonical_case_key_count": previous_unique_count,
        "overlap_with_initial_supplemental_waves_1_2_3": 0,
        "overlap_across_waves_4_5": 0,
        "all_jdk_validated": True,
        "jdk_preparation_evidence": preparation_evidence,
        "all_tokenizer_eligible": True,
        "all_loader_child_hashes_match": True,
        "model_weights_loaded": False,
        "model_inference_calls": 0,
        "model_result_files_read_by_preparer_or_finalizer": 0,
        "wave_3_result_files_read_by_preparer_or_finalizer": 0,
        "result_roots_created": False,
        "sequential_stop_rule": (
            "Wave 4 requires complete valid post-Wave-3 <10; Wave 5 requires completed Wave 4 "
            "and complete valid post-Wave-4 <10; stop all later waves once 10 is reached. "
            "There is no Wave 6."
        ),
        "waves": {str(number): audit for number, audit in wave_audits.items()},
        "launch_plans": {
            str(number): {
                "state": plan["state"],
                "sample_count": plan["sample_count"],
                "expected_run_records": plan["expected_run_records"],
                "samples_per_shard": plan["samples_per_shard"],
                "expected_run_records_per_shard": plan["expected_run_records_per_shard"],
            }
            for number, plan in plans.items()
        },
    }
    atomic_write_json(output_root / "final_summary.json", final_summary)
    atomic_write_text(
        output_root / "README.md",
        f"""# Frozen final second adaptive balanced extension (Waves 4--5)\n\n{extension2.TIMING_DISCLOSURE}\n\n{extension2.ADAPTIVE_STATUS_DISCLOSURE}\n\n{extension2.PREPARATION_READ_DISCLOSURE}\n\n{extension2.DENOMINATOR_DISCLOSURE}\n\nTwo larger prospective designs failed closed using only frozen-rule static/JDK\nevidence. Row 27 has 202 statically eligible candidates but only 24 JDK-valid\naccepted ranks, blocking rank 25. Row 54 has 255 statically eligible candidates\nbut only 19 JDK-valid accepted ranks, blocking rank 20 and all later ranks. The\n641-file rank-25 and 1,071-file rank-20 evidence trees and their exact audits\nare preserved. Both revisions preceded any Wave-3 output or result inspection.\n\nThe final exact-tokenizer-gated design is the largest uniform two-wave extension\nacross the same 19 problems: 95 cases in Wave 4 (ranks 11--15) and 76 in Wave 5\n(ranks 16--19), for 171 mutually disjoint new keys. Wave 4 has HERE-relative\nshards of 24, 24, 24, and 23 cases (288, 288, 288, and 276 records; 1,140\ntotal). Wave 5 has four 19-case shards (228 records each; 912 total). The\nmaximum is 2,052 records.\n\nBoth launch plans remain `frozen_not_launched`. Wave 4 requires a complete valid\npost-Wave-3 audit below 10 unique strict canonical problems. Wave 5 additionally\nrequires completed Wave 4 and a complete valid post-Wave-4 audit below 10.\nReaching 10 stops every later wave. There is no Wave-6 manifest, launch plan, or\nprospective output path. No prospective Wave-4 or Wave-5 inference root exists\nor was created by this package.\n""",
    )

    control_files = _control_files(runner, preflight_script)
    for path in control_files:
        base.require_file(path, f"freeze control file {path.name}")
    relative_controls = [str(path.resolve().relative_to(WORK_ROOT)) for path in control_files]
    if len(relative_controls) != len(set(relative_controls)):
        raise RuntimeError("Freeze control file list contains a duplicate")
    control_hashes_before = {path: sha256_file(path) for path in control_files}
    _assert_prospective_roots_absent()

    generated_files = _inventory_files(output_root)
    required_generated_paths = {
        "README.md",
        "final_summary.json",
        "launch_plan_wave_4.json",
        "launch_plan_wave_5.json",
        "wave_4_manifest_pre_tokenizer.json",
        "wave_5_manifest_pre_tokenizer.json",
        "tokenizer_preflight/wave_4/full_report.json",
        "tokenizer_preflight/wave_4/inference_eligible_variants.json",
        "tokenizer_preflight/wave_4/exclusions.jsonl",
        "tokenizer_preflight/wave_5/full_report.json",
        "tokenizer_preflight/wave_5/inference_eligible_variants.json",
        "tokenizer_preflight/wave_5/exclusions.jsonl",
        "previous_screened_case_audit.json",
        "source_denominator_audit.json",
        "selection_audit.jsonl",
        "loader_hash_audit.json",
        "provenance.json",
        "summary.json",
        "rank25_feasibility_failure_audit.json",
        "rank20_feasibility_failure_audit.json",
    }
    inventoried_paths = {row["path"] for row in generated_files}
    missing_generated = sorted(required_generated_paths - inventoried_paths)
    if missing_generated:
        raise FileNotFoundError(f"Required generated freeze artifacts missing: {missing_generated}")
    prohibited_wave_6_paths = {
        "launch_plan_wave_6.json",
        "wave_6_manifest_pre_tokenizer.json",
    }
    if inventoried_paths & prohibited_wave_6_paths or any(
        path.startswith("wave_6_")
        or path.startswith("tokenizer_preflight/wave_6/")
        or "/wave_6/" in path
        for path in inventoried_paths
    ):
        raise ValueError("Final two-wave package contains a prohibited Wave-6 artifact")

    freeze_manifest = {
        "schema_version": "long-code-balanced-extension2-freeze-v1",
        "frozen_at_utc": datetime.now(timezone.utc).isoformat(),
        "state": "frozen_not_launched",
        "self_hash_note": (
            "freeze_manifest.json cannot contain its own hash; FREEZE.sha256 and the external "
            "balanced_extension2_contingency.FREEZE.sha256 are SHA-256 anchors intentionally "
            "outside this manifest's generated-file inventory."
        ),
        "generated_artifact_root": str(output_root),
        "generated_files": generated_files,
        "control_files": [
            {
                "path": str(path.resolve().relative_to(WORK_ROOT)),
                "bytes": path.stat().st_size,
                "sha256": control_hashes_before[path],
            }
            for path in control_files
        ],
        "invariants": {
            "specified_during_live_wave_3": True,
            "prospectively_revised_during_live_wave_3": True,
            "prospective_revision_count": 2,
            "revision_completed_before_any_wave_3_output_or_result_inspection": True,
            "completed_post_wave_2_unique_strict_canonical_problem_count": 4,
            "adaptive_outcome_aware_from_wave_2": True,
            "adaptive_not_preregistered": True,
            "outcome_blind_in_timing": False,
            "wave_3_outputs_or_results_inspected": False,
            "case_ranking_outcome_independent": True,
            "revision_uses_model_outcomes": False,
            "waves": [4, 5],
            "final_design_wave_count": 2,
            "wave_6_removed": True,
            "case_count_by_wave": {
                str(number): int(spec["case_count"]) for number, spec in WAVE_SPECS.items()
            },
            "canonical_problems": EXPECTED_PROBLEMS,
            "cases_per_problem_by_wave": {
                str(number): int(spec["cases_per_problem"])
                for number, spec in WAVE_SPECS.items()
            },
            "total_frozen_new_cases": EXPECTED_TOTAL_CASES,
            "accepted_ranks_per_problem_by_wave": {
                str(number): list(spec["ranks"]) for number, spec in WAVE_SPECS.items()
            },
            "overlap_with_initial_supplemental_waves_1_2_3": 0,
            "overlap_across_waves_4_5": 0,
            "tokenizer_exclusions_by_wave": {"4": 0, "5": 0},
            "rank25_original_proposal_failed_closed": True,
            "rank25_limiting_row_index": RANK25_LIMITING_ROW,
            "rank25_statically_eligible_candidate_count": 202,
            "rank25_jdk_valid_accepted_rank_count": 24,
            "rank25_feasibility_evidence_file_count": 641,
            "rank20_revised_design_failed_closed": True,
            "rank20_limiting_row_index": RANK20_LIMITING_ROW,
            "rank20_statically_eligible_candidate_count": 255,
            "rank20_jdk_valid_accepted_rank_count": 19,
            "rank20_feasibility_evidence_file_count": 1071,
            "final_design_is_largest_uniform_two_wave_design": True,
            "model_weights_loaded": False,
            "model_inference_calls": 0,
            "model_result_files_read_by_preparer_or_finalizer": 0,
            "result_roots_created": False,
            "shard_case_counts_by_wave": {
                str(number): list(spec["shard_cases"])
                for number, spec in WAVE_SPECS.items()
            },
            "shard_expected_run_records_by_wave": {
                str(number): list(spec["shard_records"])
                for number, spec in WAVE_SPECS.items()
            },
            "expected_run_records_by_wave": {
                str(number): int(spec["case_count"]) * TRIALS * CONDITIONS
                for number, spec in WAVE_SPECS.items()
            },
            "maximum_expected_run_records_all_two_waves": EXPECTED_MAXIMUM_RUN_RECORDS,
            "sequential_trigger_threshold": 10,
            "stop_later_waves_if_threshold_reached": True,
        },
    }
    atomic_write_json(freeze_path, freeze_manifest)
    if {path: sha256_file(path) for path in control_files} != control_hashes_before:
        raise RuntimeError("A freeze control file changed during finalization")
    _assert_prospective_roots_absent()
    freeze_sha = sha256_file(freeze_path)
    atomic_write_text(internal_anchor, f"{freeze_sha}  freeze_manifest.json\n")
    atomic_write_text(
        external_anchor,
        f"{freeze_sha}  balanced_extension2_contingency/freeze_manifest.json\n",
    )
    if internal_anchor.read_text(encoding="utf-8") != f"{freeze_sha}  freeze_manifest.json\n":
        raise RuntimeError("Internal freeze anchor verification failed")
    expected_external = f"{freeze_sha}  balanced_extension2_contingency/freeze_manifest.json\n"
    if external_anchor.read_text(encoding="utf-8") != expected_external:
        raise RuntimeError("External freeze anchor verification failed")
    result = {
        "state": "frozen_not_launched",
        "freeze_manifest": str(freeze_path),
        "freeze_manifest_sha256": freeze_sha,
        "internal_anchor": str(internal_anchor),
        "external_anchor": str(external_anchor),
        "generated_file_count": len(freeze_manifest["generated_files"]),
        "control_file_count": len(freeze_manifest["control_files"]),
        "wave_manifest_sha256": {
            str(number): audit["filtered_manifest_sha256"]
            for number, audit in wave_audits.items()
        },
        "sample_count_by_wave": {
            str(number): int(spec["case_count"]) for number, spec in WAVE_SPECS.items()
        },
        "maximum_expected_run_records": EXPECTED_MAXIMUM_RUN_RECORDS,
    }
    print(json.dumps(result, indent=2, sort_keys=True))
    return 0


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output-root", type=Path, default=DEFAULT_OUTPUT_ROOT)
    parser.add_argument("--runner", type=Path, default=DEFAULT_RUNNER)
    parser.add_argument("--preflight-script", type=Path, default=DEFAULT_PREFLIGHT)
    return parser


def main() -> None:
    raise SystemExit(finalize(build_parser().parse_args()))


if __name__ == "__main__":
    main()
