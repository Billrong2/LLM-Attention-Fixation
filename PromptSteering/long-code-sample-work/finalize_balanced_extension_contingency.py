#!/usr/bin/env python3
"""Verify, plan, and cryptographically freeze the adaptive Wave-3 extension.

This finalizer reads only the static preparation/tokenizer artifacts. It never
reads an inference result file, launches inference, or creates a result root.
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

from prepare_long_code_variants import atomic_write_json, atomic_write_text, sha256_file

import prepare_balanced_contingency as base
import prepare_balanced_extension_contingency as extension


sys.dont_write_bytecode = True

WORK_ROOT = extension.WORK_ROOT
DEFAULT_OUTPUT_ROOT = WORK_ROOT / "balanced_extension_contingency"
DEFAULT_RUNNER = WORK_ROOT / "run_long_code_experiment.py"
DEFAULT_PREFLIGHT = WORK_ROOT / "preflight_long_code_tokenizer.py"
MODEL_ID = "Qwen/Qwen2.5-14B"
MODEL_SNAPSHOT = "97e1e76335b7017d8f67c08a19d103c0504298c9"
BASE_SEED = 20260713
TRIALS = 3
CONDITIONS = 4
GPU_COUNT = 4
EXPECTED_SHARD_CASES = [29, 29, 28, 28]
EXPECTED_SHARD_RECORDS = [348, 348, 336, 336]


def _variants(payload: Mapping[str, Any], label: str) -> list[Mapping[str, Any]]:
    rows = payload.get("variants")
    if not isinstance(rows, list):
        raise ValueError(f"{label} has no variants list")
    return rows


def _variant_id(row: Mapping[str, Any]) -> str:
    return base.variant_id(row)


def _expanded_case_map(payload: Mapping[str, Any]) -> dict[str, dict[str, Any]]:
    result: dict[str, dict[str, Any]] = {}
    for row in _variants(payload, "Wave-3 manifest"):
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
        if not isinstance(cases, list) or len(cases) != extension.EXPECTED_CASES_PER_PROBLEM:
            raise ValueError(f"{identity} does not have exactly six cases")
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
    return result


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


def verify_tokenizer_wave(output_root: Path) -> dict[str, Any]:
    pre_manifest = base.require_file(
        output_root / "wave_3_manifest_pre_tokenizer.json", "Wave-3 pre-tokenizer manifest"
    )
    preflight_dir = output_root / "tokenizer_preflight"
    report_path = base.require_file(preflight_dir / "full_report.json", "Wave-3 tokenizer report")
    filtered_path = base.require_file(
        preflight_dir / "inference_eligible_variants.json", "Wave-3 filtered manifest"
    )
    exclusions_path = base.require_file(
        preflight_dir / "exclusions.jsonl", "Wave-3 tokenizer exclusions"
    )
    report = base.read_json(report_path)
    filtered = base.read_json(filtered_path)
    pre_payload = base.read_json(pre_manifest)

    expected_counts = {
        "exploded_denominator_records": extension.EXPECTED_CASES,
        "inference_eligible_records": extension.EXPECTED_CASES,
        "excluded_records": 0,
        "preflight_error_records": 0,
    }
    counts = report.get("counts") if isinstance(report, Mapping) else None
    if not isinstance(counts, Mapping):
        raise ValueError("Wave-3 tokenizer report lacks counts")
    for key, expected in expected_counts.items():
        if counts.get(key) != expected:
            raise ValueError(f"Wave-3 tokenizer {key}={counts.get(key)} expected={expected}")
    if exclusions_path.read_text(encoding="utf-8") != "":
        raise ValueError("Wave-3 tokenizer exclusions file is not empty")

    source = report.get("source_manifest")
    if not isinstance(source, Mapping) or source.get("sha256") != sha256_file(pre_manifest):
        raise ValueError("Tokenizer report is not bound to the Wave-3 source manifest")
    tokenizer = report.get("tokenizer")
    if not isinstance(tokenizer, Mapping):
        raise ValueError("Wave-3 tokenizer provenance is missing")
    if tokenizer.get("model_id") != MODEL_ID or tokenizer.get("snapshot_commit") != MODEL_SNAPSHOT:
        raise ValueError("Wave-3 tokenizer model/snapshot mismatch")
    if tokenizer.get("model_weights_loaded") is not False or not tokenizer.get("files"):
        raise ValueError("Wave-3 tokenizer provenance does not prove tokenizer-only loading")

    records = report.get("records")
    if not isinstance(records, list) or len(records) != extension.EXPECTED_CASES:
        raise ValueError("Wave-3 tokenizer record count mismatch")
    for record in records:
        if record.get("decision", {}).get("inference_eligible") is not True:
            raise ValueError("Wave-3 contains a non-passing tokenizer record")
        if record.get("slicing_prior", {}).get("algorithm_fallback_detected") is not False:
            raise ValueError("Wave-3 contains a positional-fallback record")
        if record.get("slice_hybrid", {}).get("case_signal_active") is not True:
            raise ValueError("Wave-3 contains an inactive CASES record")
        token_preflight = record.get("prompt", {}).get("token_preflight", {})
        if token_preflight.get("fits_context") is not True:
            raise ValueError("Wave-3 contains a context-overflow record")
        markers = record.get("prompt", {}).get("markers", {})
        marker_keys = ("cases_begin_present", "cases_end_present", "c001_spec_present")
        if not all(markers.get(key) is True for key in marker_keys):
            raise ValueError("Wave-3 prompt marker evidence is incomplete")
        if record.get("prompt", {}).get("codesteer_instruction_equals_obfuscated_plain") is not True:
            raise ValueError("Wave-3 CodeSteer/plain prompt contract differs")

    pre_map = _expanded_case_map(pre_payload)
    filtered_map = _expanded_case_map(filtered)
    if set(pre_map) != set(filtered_map) or len(filtered_map) != extension.EXPECTED_CASES:
        raise ValueError("Filtered Wave-3 sample ids differ from the preflight denominator")
    if filtered.get("case_count") != extension.EXPECTED_CASES:
        raise ValueError("Filtered Wave-3 manifest case_count mismatch")
    if filtered.get("state") != "exact_tokenizer_gate_passed":
        raise ValueError("Filtered Wave-3 manifest carries stale tokenizer state")
    if filtered.get("wave_id") != extension.WAVE_ID:
        raise ValueError("Filtered Wave-3 manifest carries the wrong wave id")
    if filtered.get("adaptive_status_disclosure") != extension.ADAPTIVE_STATUS_DISCLOSURE:
        raise ValueError("Filtered Wave-3 manifest lost the adaptive-status disclosure")

    keys: set[tuple[int, str, int]] = set()
    row_counts: Counter[int] = Counter()
    rank_counts: Counter[int] = Counter()
    ranks_by_row: dict[int, set[int]] = {}
    for case in filtered_map.values():
        key = _case_key(case)
        if key in keys:
            raise ValueError(f"Duplicate Wave-3 canonical case key: {key}")
        keys.add(key)
        row_counts[key[0]] += 1
        rank = case.get("accepted_rank")
        if not isinstance(rank, int):
            raise ValueError(f"Wave-3 case has no accepted rank: {key}")
        rank_counts[rank] += 1
        ranks_by_row.setdefault(key[0], set()).add(rank)
        metadata = case["source_case_metadata"]
        if metadata.get("wave_id") != extension.WAVE_ID:
            raise ValueError(f"Wave-3 case carries the wrong wave id: {key}")
    if len(keys) != extension.EXPECTED_CASES or len(row_counts) != extension.EXPECTED_PROBLEMS:
        raise ValueError("Wave-3 canonical case/problem count mismatch")
    if set(row_counts.values()) != {extension.EXPECTED_CASES_PER_PROBLEM}:
        raise ValueError("Wave-3 is not exactly balanced at six cases per problem")
    expected_ranks = set(extension.EXPECTED_ACCEPTED_RANKS)
    if set(rank_counts) != expected_ranks or set(rank_counts.values()) != {extension.EXPECTED_PROBLEMS}:
        raise ValueError("Wave-3 accepted-rank counts are not exact")
    if any(ranks != expected_ranks for ranks in ranks_by_row.values()):
        raise ValueError("A Wave-3 problem does not carry accepted ranks 5--10")

    loader_audit = extension.verify_loaded_manifest(filtered_path, filtered_map)
    return {
        "wave_id": extension.WAVE_ID,
        "pre_tokenizer_manifest": str(pre_manifest.relative_to(WORK_ROOT)),
        "pre_tokenizer_manifest_sha256": sha256_file(pre_manifest),
        "tokenizer_report": str(report_path.relative_to(WORK_ROOT)),
        "tokenizer_report_sha256": sha256_file(report_path),
        "filtered_manifest": str(filtered_path.relative_to(WORK_ROOT)),
        "filtered_manifest_sha256": sha256_file(filtered_path),
        "tokenizer_files": tokenizer["files"],
        "case_count": len(filtered_map),
        "canonical_problem_count": len(row_counts),
        "accepted_ranks_per_problem": list(extension.EXPECTED_ACCEPTED_RANKS),
        "canonical_case_keys": [list(key) for key in sorted(keys)],
        "sample_ids": sorted(filtered_map),
        "loader_hash_audit": loader_audit,
    }


def launch_plan(
    *, manifest_path: Path, sample_ids: Sequence[str], runner_path: Path
) -> dict[str, Any]:
    launch_working_directory = WORK_ROOT
    manifest_arg = os.path.relpath(manifest_path, launch_working_directory)
    runner_arg = os.path.relpath(runner_path, launch_working_directory)
    prospective_root = WORK_ROOT / "balanced_extension_contingency_inference" / "wave_3"
    if prospective_root.exists():
        raise FileExistsError(f"Prospective inference root already exists: {prospective_root}")
    assignments: list[list[str]] = [[] for _ in range(GPU_COUNT)]
    for index, sample_id in enumerate(sorted(sample_ids)):
        assignments[index % GPU_COUNT].append(sample_id)
    if [len(values) for values in assignments] != EXPECTED_SHARD_CASES:
        raise RuntimeError("Wave-3 shard sizes are not [29, 29, 28, 28]")

    shards: list[dict[str, Any]] = []
    for gpu_id, assigned in enumerate(assignments):
        output_root = prospective_root / f"shard_{gpu_id}"
        output_arg = os.path.relpath(output_root, launch_working_directory)
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
                "tmux_session": f"longcode_bal_ext_w3_g{gpu_id}",
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
        raise RuntimeError("Wave-3 launch assignments are not an exact partition")
    if [row["expected_run_records"] for row in shards] != EXPECTED_SHARD_RECORDS:
        raise RuntimeError("Wave-3 shard record counts are not exact")
    for path_arg in [runner_arg, manifest_arg, *(row["output_root"] for row in shards)]:
        if Path(path_arg).is_absolute() or path_arg.startswith("long-code-sample-work/"):
            raise RuntimeError(f"Launch path is not HERE-relative: {path_arg}")

    return {
        "schema_version": "long-code-balanced-extension-launch-plan-v1",
        "state": "frozen_not_launched",
        "wave_id": extension.WAVE_ID,
        "conditional_trigger": (
            "Run only after a complete valid post-Wave-2 audit has fewer than ten strict "
            "canonical CodeContests problems."
        ),
        "adaptive_not_preregistered": True,
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
        if not path.is_file() or path.name in excluded:
            continue
        rows.append(
            {
                "path": str(path.relative_to(output_root)),
                "bytes": path.stat().st_size,
                "sha256": sha256_file(path),
            }
        )
    return rows


def finalize(args: argparse.Namespace) -> int:
    output_root = extension.require_output_root(args.output_root)
    if not output_root.is_dir():
        raise FileNotFoundError(output_root)
    freeze_path = output_root / "freeze_manifest.json"
    internal_anchor = output_root / "FREEZE.sha256"
    external_anchor = WORK_ROOT / "balanced_extension_contingency.FREEZE.sha256"
    if freeze_path.exists() or internal_anchor.exists() or external_anchor.exists():
        raise FileExistsError("Extension freeze already exists; refusing an implicit refreeze")
    runner = base.require_file(args.runner, "experiment runner")
    preflight_script = base.require_file(args.preflight_script, "tokenizer preflight script")

    wave_audit = verify_tokenizer_wave(output_root)
    wave_keys = {tuple(key) for key in wave_audit["canonical_case_keys"]}
    previous = base.read_json(
        base.require_file(output_root / "previous_screened_case_audit.json", "previous-screen audit")
    )
    previous_keys = {
        tuple(record["canonical_case_key"])
        for record in previous.get("records", [])
        if isinstance(record, Mapping)
    }
    if wave_keys & previous_keys:
        raise RuntimeError("Tokenizer-filtered Wave 3 overlaps a prior screened case")
    if previous.get("wave_3_overlap_count") != 0:
        raise RuntimeError("Preparation overlap audit is not zero")

    source_audit = base.read_json(
        base.require_file(output_root / "source_denominator_audit.json", "source denominator audit")
    )
    required_denominators = {
        "frozen_source_denominator": 25,
        "tokenizer_eligible_source_count": 23,
        "canonical_problem_count": extension.EXPECTED_PROBLEMS,
        "chosen_source_count": extension.EXPECTED_PROBLEMS,
        "wave_3_case_count": extension.EXPECTED_CASES,
        "accepted_ranks_per_problem": list(extension.EXPECTED_ACCEPTED_RANKS),
    }
    for key, expected in required_denominators.items():
        if source_audit.get(key) != expected:
            raise ValueError(f"Source denominator audit {key} mismatch")

    manifest_path = WORK_ROOT / wave_audit["filtered_manifest"]
    plan = launch_plan(
        manifest_path=manifest_path,
        sample_ids=wave_audit["sample_ids"],
        runner_path=runner,
    )
    plan_path = output_root / "launch_plan_wave_3.json"
    atomic_write_json(plan_path, plan)

    final_summary = {
        "schema_version": extension.SCHEMA_VERSION,
        "state": "fully_frozen_tokenizer_gated_not_launched",
        "timing_disclosure": extension.TIMING_DISCLOSURE,
        "adaptive_status_disclosure": extension.ADAPTIVE_STATUS_DISCLOSURE,
        "preparation_read_disclosure": extension.PREPARATION_READ_DISCLOSURE,
        "adaptive_not_preregistered": True,
        "outcome_blind_in_timing": False,
        "case_eligibility_ranking_selection_outcome_independent": True,
        "dataset": {
            "id": base.DATASET_ID,
            "revision": base.DATASET_REVISION,
            "split": base.DATASET_SPLIT,
            "file_sha256": base.DATASET_SHA256,
        },
        "source_denominator": 25,
        "tokenizer_eligible_source_count": 23,
        "canonical_problem_count": extension.EXPECTED_PROBLEMS,
        "wave_3_case_count": extension.EXPECTED_CASES,
        "cases_per_problem": extension.EXPECTED_CASES_PER_PROBLEM,
        "accepted_ranks_per_problem": list(extension.EXPECTED_ACCEPTED_RANKS),
        "overlap_with_initial_supplemental_wave_1_wave_2": 0,
        "all_jdk_validated": True,
        "all_tokenizer_eligible": True,
        "all_loader_child_hashes_match": True,
        "model_weights_loaded": False,
        "model_inference_calls": 0,
        "model_result_files_read_by_preparer_or_finalizer": 0,
        "result_roots_created": False,
        "launch_plan_state": plan["state"],
        "wave": wave_audit,
    }
    atomic_write_json(output_root / "final_summary.json", final_summary)
    atomic_write_text(
        output_root / "README.md",
        f"""# Frozen balanced extension contingency (Wave 3)\n\n{extension.TIMING_DISCLOSURE}\n\n{extension.ADAPTIVE_STATUS_DISCLOSURE}\n\n{extension.PREPARATION_READ_DISCLOSURE}\n\n{extension.DENOMINATOR_DISCLOSURE}\n\nThe exact-tokenizer-gated manifest contains 114 JDK-validated cases: accepted\nranks 5--10 for each of the same 19 canonical CodeContests problems. It is\ndisjoint from every initial, supplemental, Wave-1, and Wave-2 canonical case\nkey. `tokenizer_preflight/inference_eligible_variants.json` is the final\nrunner-compatible manifest.\n\n`launch_plan_wave_3.json` is conditional and remains `frozen_not_launched`.\nIts four HERE-relative shards contain 29, 29, 28, and 28 cases, or 348, 348,\n336, and 336 expected records (1,368 total). Wave 3 may run only after a\ncomplete valid post-Wave-2 audit reports fewer than ten strict canonical\nproblems. No result root exists or was created by this package.\n""",
    )

    control_files = [
        WORK_ROOT / "BALANCED_EXTENSION_CONTINGENCY_PROTOCOL.md",
        WORK_ROOT / "balanced_extension_contingency_protocol.json",
        WORK_ROOT / "prepare_balanced_extension_contingency.py",
        Path(__file__).resolve(),
        WORK_ROOT / "test_prepare_balanced_extension_contingency.py",
        WORK_ROOT / "prepare_balanced_contingency.py",
        WORK_ROOT / "test_prepare_balanced_contingency.py",
        WORK_ROOT / "prepare_long_code_variants.py",
        WORK_ROOT / "prepare_supplemental_cases.py",
        runner,
        preflight_script,
        WORK_ROOT / "test_preflight_long_code_tokenizer.py",
    ]
    for path in control_files:
        base.require_file(path, f"freeze control file {path.name}")
    control_hashes_before = {path: sha256_file(path) for path in control_files}
    prospective_root = WORK_ROOT / "balanced_extension_contingency_inference" / "wave_3"
    if prospective_root.exists():
        raise FileExistsError(f"Prospective inference root appeared: {prospective_root}")

    freeze_manifest = {
        "schema_version": "long-code-balanced-extension-freeze-v1",
        "frozen_at_utc": datetime.now(timezone.utc).isoformat(),
        "state": "frozen_not_launched",
        "self_hash_note": (
            "freeze_manifest.json cannot contain its own hash; FREEZE.sha256 and the external "
            "balanced_extension_contingency.FREEZE.sha256 are SHA-256 anchors intentionally "
            "outside this manifest's generated-file inventory."
        ),
        "generated_artifact_root": str(output_root),
        "generated_files": _inventory_files(output_root),
        "control_files": [
            {
                "path": str(path.relative_to(WORK_ROOT)),
                "bytes": path.stat().st_size,
                "sha256": control_hashes_before[path],
            }
            for path in control_files
        ],
        "invariants": {
            "adaptive_not_preregistered": True,
            "outcome_blind_in_timing": False,
            "case_ranking_outcome_independent": True,
            "wave_3_cases": extension.EXPECTED_CASES,
            "canonical_problems": extension.EXPECTED_PROBLEMS,
            "cases_per_problem": extension.EXPECTED_CASES_PER_PROBLEM,
            "accepted_ranks_per_problem": list(extension.EXPECTED_ACCEPTED_RANKS),
            "overlap_with_initial_supplemental_wave_1_wave_2": 0,
            "tokenizer_exclusions": 0,
            "model_weights_loaded": False,
            "model_inference_calls": 0,
            "model_result_files_read_by_preparer_or_finalizer": 0,
            "result_roots_created": False,
            "shard_case_counts": EXPECTED_SHARD_CASES,
            "shard_expected_run_records": EXPECTED_SHARD_RECORDS,
            "expected_run_records": extension.EXPECTED_CASES * TRIALS * CONDITIONS,
        },
    }
    atomic_write_json(freeze_path, freeze_manifest)
    if {path: sha256_file(path) for path in control_files} != control_hashes_before:
        raise RuntimeError("A freeze control file changed during finalization")
    freeze_sha = sha256_file(freeze_path)
    atomic_write_text(internal_anchor, f"{freeze_sha}  freeze_manifest.json\n")
    atomic_write_text(
        external_anchor,
        f"{freeze_sha}  balanced_extension_contingency/freeze_manifest.json\n",
    )
    result = {
        "state": "frozen_not_launched",
        "freeze_manifest": str(freeze_path),
        "freeze_manifest_sha256": freeze_sha,
        "internal_anchor": str(internal_anchor),
        "external_anchor": str(external_anchor),
        "generated_file_count": len(freeze_manifest["generated_files"]),
        "control_file_count": len(freeze_manifest["control_files"]),
        "wave_3_manifest_sha256": wave_audit["filtered_manifest_sha256"],
        "sample_count": extension.EXPECTED_CASES,
        "expected_run_records": extension.EXPECTED_CASES * TRIALS * CONDITIONS,
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
