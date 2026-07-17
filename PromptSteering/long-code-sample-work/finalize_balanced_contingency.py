#!/usr/bin/env python3
"""Verify tokenizer-gated contingency waves, create launch plans, and freeze hashes.

This finalizer is read-only with respect to model results and never launches
inference. It accepts only two complete 38/38 tokenizer-only preflight outputs.
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
from prepare_balanced_contingency import (
    DATASET_ID,
    DATASET_REVISION,
    DATASET_SHA256,
    DATASET_SPLIT,
    EXPECTED_PROBLEMS,
    EXPECTED_SOURCE_DENOMINATOR,
    EXPECTED_TOKENIZER_ELIGIBLE_SOURCES,
    EXPECTED_WAVE_CASES,
    PARENT_CASE_ALIASES,
    SCHEMA_VERSION,
    WORK_ROOT,
    canonical_identity,
    read_json,
    require_file,
    require_output_root,
    verify_loaded_manifest,
)


sys.dont_write_bytecode = True

DEFAULT_OUTPUT_ROOT = WORK_ROOT / "balanced_contingency"
DEFAULT_RUNNER = WORK_ROOT / "run_long_code_experiment.py"
DEFAULT_PREFLIGHT = WORK_ROOT / "preflight_long_code_tokenizer.py"
MODEL_ID = "Qwen/Qwen2.5-14B"
MODEL_SNAPSHOT = "97e1e76335b7017d8f67c08a19d103c0504298c9"
BASE_SEED = 20260713
TRIALS = 3
CONDITIONS = 4
GPU_COUNT = 4


def _variants(payload: Mapping[str, Any], label: str) -> list[Mapping[str, Any]]:
    rows = payload.get("variants")
    if not isinstance(rows, list):
        raise ValueError(f"{label} has no variants list")
    return rows


def _variant_id(row: Mapping[str, Any]) -> str:
    value = row.get("id") or row.get("variant_id")
    if not isinstance(value, str) or not value:
        raise ValueError("Variant lacks id")
    return value


def _expanded_case_map(payload: Mapping[str, Any]) -> dict[str, dict[str, Any]]:
    result: dict[str, dict[str, Any]] = {}
    for row in _variants(payload, "wave manifest"):
        identity = _variant_id(row)
        if any(key in row for key in PARENT_CASE_ALIASES):
            raise ValueError(f"Parent input/output alias survives in {identity}")
        original = row.get("original") if isinstance(row.get("original"), Mapping) else {}
        obfuscated = row.get("obfuscated") if isinstance(row.get("obfuscated"), Mapping) else {}
        original_sha = original.get("sha256")
        obfuscated_sha = obfuscated.get("sha256")
        if not isinstance(original_sha, str) or not isinstance(obfuscated_sha, str):
            raise ValueError(f"Missing frozen source hashes in {identity}")
        cases = row.get("cases")
        if not isinstance(cases, list) or len(cases) != 2:
            raise ValueError(f"{identity} does not have exactly two cases")
        for case in cases:
            if not isinstance(case, Mapping):
                raise ValueError(f"Malformed case in {identity}")
            case_id = case.get("case_id")
            if not isinstance(case_id, str):
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
    if not isinstance(key[0], int) or key[1] not in {"private_tests", "generated_tests"} or not isinstance(key[2], int):
        raise ValueError(f"Malformed canonical case key: {key}")
    if list(key) != case.get("canonical_case_key"):
        raise ValueError(f"Canonical case key disagreement: {key}")
    return int(key[0]), str(key[1]), int(key[2])


def verify_tokenizer_wave(
    *,
    output_root: Path,
    wave_number: int,
) -> dict[str, Any]:
    wave_id = f"balanced_wave_{wave_number}"
    pre_manifest = require_file(
        output_root / f"wave_{wave_number}_manifest_pre_tokenizer.json",
        f"{wave_id} pre-tokenizer manifest",
    )
    preflight_dir = output_root / "tokenizer_preflight" / f"wave_{wave_number}"
    report_path = require_file(preflight_dir / "full_report.json", f"{wave_id} tokenizer report")
    filtered_path = require_file(
        preflight_dir / "inference_eligible_variants.json",
        f"{wave_id} filtered manifest",
    )
    exclusions_path = require_file(preflight_dir / "exclusions.jsonl", f"{wave_id} exclusions")
    report = read_json(report_path)
    filtered = read_json(filtered_path)
    pre_payload = read_json(pre_manifest)

    counts = report.get("counts") if isinstance(report, Mapping) else None
    expected_counts = {
        "exploded_denominator_records": EXPECTED_WAVE_CASES,
        "inference_eligible_records": EXPECTED_WAVE_CASES,
        "excluded_records": 0,
        "preflight_error_records": 0,
    }
    if not isinstance(counts, Mapping):
        raise ValueError(f"{wave_id} tokenizer report lacks counts")
    for key, value in expected_counts.items():
        if counts.get(key) != value:
            raise ValueError(f"{wave_id} tokenizer {key}={counts.get(key)} expected={value}")
    if exclusions_path.read_text(encoding="utf-8") != "":
        raise ValueError(f"{wave_id} exclusions file is not empty")

    source = report.get("source_manifest")
    if not isinstance(source, Mapping) or source.get("sha256") != sha256_file(pre_manifest):
        raise ValueError(f"{wave_id} tokenizer report is not bound to its source manifest")
    tokenizer = report.get("tokenizer")
    if not isinstance(tokenizer, Mapping):
        raise ValueError(f"{wave_id} tokenizer provenance missing")
    if tokenizer.get("model_id") != MODEL_ID or tokenizer.get("snapshot_commit") != MODEL_SNAPSHOT:
        raise ValueError(f"{wave_id} tokenizer model/snapshot mismatch")
    if tokenizer.get("model_weights_loaded") is not False:
        raise ValueError(f"{wave_id} tokenizer report does not prove weights stayed unloaded")
    if not tokenizer.get("files"):
        raise ValueError(f"{wave_id} tokenizer file hashes are missing")

    records = report.get("records")
    if not isinstance(records, list) or len(records) != EXPECTED_WAVE_CASES:
        raise ValueError(f"{wave_id} tokenizer record count mismatch")
    for record in records:
        if record.get("decision", {}).get("inference_eligible") is not True:
            raise ValueError(f"{wave_id} contains a non-passing tokenizer record")
        if record.get("slicing_prior", {}).get("algorithm_fallback_detected") is not False:
            raise ValueError(f"{wave_id} contains a positional-fallback record")
        if record.get("slice_hybrid", {}).get("case_signal_active") is not True:
            raise ValueError(f"{wave_id} contains an inactive CASES record")
        token_preflight = record.get("prompt", {}).get("token_preflight", {})
        if token_preflight.get("fits_context") is not True:
            raise ValueError(f"{wave_id} contains a context-overflow record")
        markers = record.get("prompt", {}).get("markers", {})
        if not all(markers.get(key) is True for key in (
            "cases_begin_present", "cases_end_present", "c001_spec_present"
        )):
            raise ValueError(f"{wave_id} prompt marker evidence is incomplete")
        if record.get("prompt", {}).get("codesteer_instruction_equals_obfuscated_plain") is not True:
            raise ValueError(f"{wave_id} CodeSteer/plain prompt contract differs")

    pre_map = _expanded_case_map(pre_payload)
    filtered_map = _expanded_case_map(filtered)
    if set(pre_map) != set(filtered_map) or len(filtered_map) != EXPECTED_WAVE_CASES:
        raise ValueError(f"{wave_id} filtered sample ids differ from the frozen preflight denominator")
    if filtered.get("case_count") != EXPECTED_WAVE_CASES:
        raise ValueError(
            f"{wave_id} filtered case_count={filtered.get('case_count')} expected=38"
        )
    if filtered.get("state") != "exact_tokenizer_gate_passed":
        raise ValueError(f"{wave_id} filtered manifest carries stale tokenizer state")

    keys = {_case_key(case) for case in filtered_map.values()}
    rows = Counter(key[0] for key in keys)
    if len(keys) != EXPECTED_WAVE_CASES or len(rows) != EXPECTED_PROBLEMS:
        raise ValueError(f"{wave_id} canonical case/problem count mismatch")
    if set(rows.values()) != {2}:
        raise ValueError(f"{wave_id} is not exactly balanced at two cases per problem")
    for row_index in rows:
        expected_identity = canonical_identity(row_index)
        for case in filtered_map.values():
            if _case_key(case)[0] == row_index:
                metadata = case["source_case_metadata"]
                if metadata.get("wave_id") != wave_id:
                    raise ValueError(f"{wave_id} case carries the wrong wave id")
                if expected_identity != canonical_identity(metadata["row_index"]):
                    raise ValueError(f"{wave_id} canonical identity mismatch")

    loader_audit = verify_loaded_manifest(filtered_path, filtered_map)
    return {
        "wave_id": wave_id,
        "pre_tokenizer_manifest": str(pre_manifest.relative_to(WORK_ROOT)),
        "pre_tokenizer_manifest_sha256": sha256_file(pre_manifest),
        "tokenizer_report": str(report_path.relative_to(WORK_ROOT)),
        "tokenizer_report_sha256": sha256_file(report_path),
        "filtered_manifest": str(filtered_path.relative_to(WORK_ROOT)),
        "filtered_manifest_sha256": sha256_file(filtered_path),
        "tokenizer_files": tokenizer["files"],
        "case_count": len(filtered_map),
        "canonical_problem_count": len(rows),
        "canonical_case_keys": [list(key) for key in sorted(keys)],
        "sample_ids": sorted(filtered_map),
        "loader_hash_audit": loader_audit,
    }


def launch_plan(
    *,
    wave_number: int,
    manifest_path: Path,
    sample_ids: Sequence[str],
    runner_path: Path,
) -> dict[str, Any]:
    wave_id = f"balanced_wave_{wave_number}"
    # The runner rebases every relative --output-root beneath WORK_ROOT.  Keep
    # every launch argument relative to that same directory; prefixing these
    # paths with ``long-code-sample-work`` from its parent would silently
    # create a duplicated nested output tree.
    launch_working_directory = WORK_ROOT
    manifest_arg = os.path.relpath(manifest_path, launch_working_directory)
    runner_arg = os.path.relpath(runner_path, launch_working_directory)
    prospective_root = WORK_ROOT / "balanced_contingency_inference" / f"wave_{wave_number}"
    if prospective_root.exists():
        raise FileExistsError(f"Prospective inference root already exists: {prospective_root}")
    assignments = [[] for _ in range(GPU_COUNT)]
    for index, sample_id in enumerate(sorted(sample_ids)):
        assignments[index % GPU_COUNT].append(sample_id)
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
                "tmux_session": f"longcode_bal_w{wave_number}_g{gpu_id}",
                "output_root": output_arg,
                "sample_count": len(assigned),
                "sample_ids": assigned,
                "expected_run_records": len(assigned) * TRIALS * CONDITIONS,
                "argv": argv,
                "command": shlex.join(argv),
            }
        )
    if sorted(sample_id for shard in shards for sample_id in shard["sample_ids"]) != sorted(sample_ids):
        raise RuntimeError(f"{wave_id} launch assignments are not an exact partition")
    return {
        "schema_version": "long-code-balanced-launch-plan-v1",
        "state": "frozen_not_launched",
        "wave_id": wave_id,
        "conditional_trigger": (
            "Run only after a complete valid combined audit has fewer than ten strict "
            "canonical problems; Wave 2 additionally requires the complete post-Wave-1 count below ten."
        ),
        "working_directory": str(launch_working_directory),
        "path_resolution_rule": (
            "runner, manifest, and output-root arguments are relative to working_directory; "
            "the runner resolves output-root beneath this same WORK_ROOT exactly once"
        ),
        "runner": runner_arg,
        "runner_sha256": sha256_file(runner_path),
        "manifest": manifest_arg,
        "manifest_sha256": sha256_file(manifest_path),
        "model": MODEL_ID,
        "trials_per_case": TRIALS,
        "conditions_per_trial": CONDITIONS,
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
    output_root = require_output_root(args.output_root)
    if not output_root.is_dir():
        raise FileNotFoundError(output_root)
    runner = require_file(args.runner, "experiment runner")
    preflight_script = require_file(args.preflight_script, "tokenizer preflight script")
    wave_audits = [
        verify_tokenizer_wave(output_root=output_root, wave_number=wave_number)
        for wave_number in (1, 2)
    ]
    wave_1_keys = {tuple(key) for key in wave_audits[0]["canonical_case_keys"]}
    wave_2_keys = {tuple(key) for key in wave_audits[1]["canonical_case_keys"]}
    if wave_1_keys & wave_2_keys:
        raise RuntimeError("Tokenizer-filtered Wave 1 and Wave 2 overlap")

    previous = read_json(require_file(
        output_root / "previous_screened_case_audit.json", "previous-screen audit"
    ))
    previous_keys = {
        tuple(record["canonical_case_key"])
        for record in previous.get("records", [])
        if isinstance(record, Mapping)
    }
    if (wave_1_keys | wave_2_keys) & previous_keys:
        raise RuntimeError("Tokenizer-filtered waves overlap an earlier screen")

    plans: list[dict[str, Any]] = []
    for wave_number, audit in enumerate(wave_audits, start=1):
        manifest_path = WORK_ROOT / audit["filtered_manifest"]
        plan = launch_plan(
            wave_number=wave_number,
            manifest_path=manifest_path,
            sample_ids=audit["sample_ids"],
            runner_path=runner,
        )
        plan_path = output_root / f"launch_plan_wave_{wave_number}.json"
        atomic_write_json(plan_path, plan)
        plans.append(plan)

    source_audit = read_json(require_file(
        output_root / "source_denominator_audit.json", "source denominator audit"
    ))
    required_denominators = {
        "frozen_source_denominator": EXPECTED_SOURCE_DENOMINATOR,
        "tokenizer_eligible_source_count": EXPECTED_TOKENIZER_ELIGIBLE_SOURCES,
        "canonical_problem_count": EXPECTED_PROBLEMS,
        "chosen_source_count": EXPECTED_PROBLEMS,
        "wave_1_case_count": EXPECTED_WAVE_CASES,
        "wave_2_case_count": EXPECTED_WAVE_CASES,
    }
    for key, value in required_denominators.items():
        if source_audit.get(key) != value:
            raise ValueError(f"Source denominator audit {key} mismatch")

    final_summary = {
        "schema_version": SCHEMA_VERSION,
        "state": "fully_frozen_tokenizer_gated_not_launched",
        "timing_disclosure": (
            "Case identities, concrete inputs, and both tokenizer-filtered manifests were "
            "frozen before corrected supplemental outcomes were opened. After a path-only "
            "launch-plan defect created an excluded 21-record startup attempt, launch paths "
            "and this administrative inventory were corrected and refrozen without changing "
            "either case manifest. Preparation/finalization reads no model result file."
        ),
        "selection_frozen_before_outcomes": True,
        "administrative_refreeze_after_outcomes": True,
        "path_correction_provenance": "balanced_contingency/path_correction_provenance.json",
        "dataset": {
            "id": DATASET_ID,
            "revision": DATASET_REVISION,
            "split": DATASET_SPLIT,
            "file_sha256": DATASET_SHA256,
        },
        "source_denominator": EXPECTED_SOURCE_DENOMINATOR,
        "tokenizer_eligible_source_count": EXPECTED_TOKENIZER_ELIGIBLE_SOURCES,
        "canonical_problem_count": EXPECTED_PROBLEMS,
        "wave_case_counts": [EXPECTED_WAVE_CASES, EXPECTED_WAVE_CASES],
        "waves_disjoint": True,
        "overlap_with_previous_screens": 0,
        "all_jdk_validated": True,
        "all_tokenizer_eligible": True,
        "all_loader_child_hashes_match": True,
        "model_weights_loaded": False,
        "model_inference_calls": 0,
        "model_result_files_read": 0,
        "result_roots_created": False,
        "launch_plans_state": [plan["state"] for plan in plans],
        "waves": wave_audits,
    }
    atomic_write_json(output_root / "final_summary.json", final_summary)
    atomic_write_text(
        output_root / "README.md",
        """# Frozen balanced contingency cases

The case identities, concrete inputs, and two outcome-blind,
exact-tokenizer-gated manifests were frozen before corrected supplemental model outcomes were
opened. They contain two disjoint waves of 38 JDK-validated cases each:
exactly two cases for every one of 19 canonical CodeContests problems. The
source denominator remains 25 frozen variants, of which 23 are
inference-eligible.

After a path-only launch-plan defect produced an excluded 21-record startup
attempt in a duplicated nested directory, the sessions were stopped and the
attempt was preserved outside this tree at
`../balanced_wave1_path_rebase_attempt/`. The working directory and launch
arguments were then corrected and this administrative inventory was refrozen.
Neither tokenizer-filtered case manifest changed; their before/after hashes
and the excluded-attempt record are in `path_correction_provenance.json`. No
completion, score, or trace was used to change case selection or ranking.

`tokenizer_preflight/wave_1/inference_eligible_variants.json` and
`tokenizer_preflight/wave_2/inference_eligible_variants.json` are the final
runner-compatible manifests. `launch_plan_wave_1.json` and
`launch_plan_wave_2.json` are conditional plans in state
`frozen_not_launched`; their corrected prospective result roots do not exist
at refreeze time.

The complete static selection audit, JDK evidence, exact child stdin/oracle
loader checks, source/problem denominators, tokenizer evidence, launch
partitions, and cryptographic inventory are retained in this directory. No
model weights, model completions, scores, result roots, or public-test values
were read during case preparation or tokenizer gating.
""",
    )

    control_files = [
        WORK_ROOT / "BALANCED_CONTINGENCY_PROTOCOL.md",
        WORK_ROOT / "balanced_contingency_protocol.json",
        WORK_ROOT / "prepare_balanced_contingency.py",
        Path(__file__).resolve(),
        WORK_ROOT / "test_prepare_balanced_contingency.py",
        WORK_ROOT / "prepare_long_code_variants.py",
        WORK_ROOT / "prepare_supplemental_cases.py",
        runner,
        preflight_script,
        WORK_ROOT / "test_preflight_long_code_tokenizer.py",
    ]
    for path in control_files:
        require_file(path, f"freeze control file {path.name}")
    freeze_manifest = {
        "schema_version": "long-code-balanced-freeze-v1",
        "frozen_at_utc": datetime.now(timezone.utc).isoformat(),
        "state": "frozen_not_launched",
        "self_hash_note": (
            "freeze_manifest.json cannot contain its own hash; FREEZE.sha256 is the external "
            "SHA-256 anchor for this manifest and is intentionally outside its inventory."
        ),
        "generated_artifact_root": str(output_root),
        "generated_files": _inventory_files(output_root),
        "control_files": [
            {
                "path": str(path.relative_to(WORK_ROOT)),
                "bytes": path.stat().st_size,
                "sha256": sha256_file(path),
            }
            for path in control_files
        ],
        "invariants": {
            "wave_1_cases": EXPECTED_WAVE_CASES,
            "wave_2_cases": EXPECTED_WAVE_CASES,
            "canonical_problems_per_wave": EXPECTED_PROBLEMS,
            "cases_per_problem_per_wave": 2,
            "waves_disjoint": True,
            "overlap_with_previous_screens": 0,
            "tokenizer_exclusions": 0,
            "model_weights_loaded": False,
            "model_inference_calls": 0,
            "result_roots_created": False,
        },
    }
    freeze_path = output_root / "freeze_manifest.json"
    atomic_write_json(freeze_path, freeze_manifest)
    freeze_sha = sha256_file(freeze_path)
    atomic_write_text(output_root / "FREEZE.sha256", f"{freeze_sha}  freeze_manifest.json\n")
    result = {
        "state": "frozen_not_launched",
        "freeze_manifest": str(freeze_path),
        "freeze_manifest_sha256": freeze_sha,
        "generated_file_count": len(freeze_manifest["generated_files"]),
        "control_file_count": len(freeze_manifest["control_files"]),
        "wave_1_manifest_sha256": wave_audits[0]["filtered_manifest_sha256"],
        "wave_2_manifest_sha256": wave_audits[1]["filtered_manifest_sha256"],
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
