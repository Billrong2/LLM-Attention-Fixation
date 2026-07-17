from __future__ import annotations

import hashlib
import json
import sys
import tempfile
import unittest
from pathlib import Path
from types import SimpleNamespace
from unittest import mock


HERE = Path(__file__).resolve().parent
if str(HERE) not in sys.path:
    sys.path.insert(0, str(HERE))

import audit_long_code_results as audit
import package_long_code_case_study as package
import run_long_code_experiment as protocol
import test_audit_long_code_results as audit_fixtures


_CORE_LINES = audit_fixtures.SOURCE.splitlines()
LONG_SOURCE = "\n".join(
    _CORE_LINES + [f"// deterministic padding line {index:03d}" for index in range(1, 301 - len(_CORE_LINES))]
) + "\n"
assert len(LONG_SOURCE.splitlines()) == 300


def _sha256_text(text: str) -> str:
    return hashlib.sha256(text.encode("utf-8")).hexdigest()


def _vector_summary(length: int, label: str, *, nonzero_count: int = 10) -> dict:
    return {
        "dtype_for_sha256": "little-endian-float64",
        "length": length,
        "nonzero_count": min(nonzero_count, length),
        "sum": 1.0,
        "min": 0.0,
        "max": 0.1,
        "sha256": _sha256_text(label),
    }


def _write_json(path: Path, payload: object) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n", encoding="utf-8")


def _runtime_dependency_hashes() -> dict[str, str]:
    paths = {
        "models.py": package.PROJECT_ROOT / "models.py",
        "PromptSteering/element_prompting.py": package.PROJECT_ROOT / "PromptSteering" / "element_prompting.py",
        "PromptSteering/prompt.py": package.PROJECT_ROOT / "PromptSteering" / "prompt.py",
        "steering/config.py": package.PROJECT_ROOT / "steering" / "config.py",
        "steering/runtime.py": package.PROJECT_ROOT / "steering" / "runtime.py",
        "steering/priors.py": package.PROJECT_ROOT / "steering" / "priors.py",
        "steering/levels.py": package.PROJECT_ROOT / "steering" / "levels.py",
        "steering/backends/qwen2_backend.py": package.PROJECT_ROOT / "steering" / "backends" / "qwen2_backend.py",
        "PromptSteering/long-code-sample-work/run_long_code_experiment.py": HERE / "run_long_code_experiment.py",
    }
    return {name: hashlib.sha256(path.read_bytes()).hexdigest() for name, path in paths.items()}


def _tokenizer_role(
    schema: str, *, wave_id: str | None = None, eligible_ids: set[str] | None = None
) -> dict:
    source = {"schema_version": schema}
    filtered = {"schema_version": schema}
    if wave_id is not None:
        source["wave_id"] = wave_id
        filtered["wave_id"] = wave_id
    return {
        "source_manifest": source,
        "manifest": filtered,
        "eligible_ids": set(eligible_ids or set()),
    }


def _build_balanced_evidence(root: Path, wave_number: int) -> dict:
    wave_id = f"balanced_wave_{wave_number}"
    balanced_root = HERE / "balanced_contingency"
    preflight_root = balanced_root / "tokenizer_preflight" / f"wave_{wave_number}"
    source_path = balanced_root / f"wave_{wave_number}_manifest_pre_tokenizer.json"
    report_path = preflight_root / "full_report.json"
    exclusions_path = preflight_root / "exclusions.jsonl"
    manifest_path = preflight_root / "inference_eligible_variants.json"
    plan = json.loads(
        (balanced_root / f"launch_plan_wave_{wave_number}.json").read_text(
            encoding="utf-8"
        )
    )
    source = json.loads(source_path.read_text(encoding="utf-8"))
    filtered = json.loads(manifest_path.read_text(encoding="utf-8"))
    eligible_ids = package._expanded_manifest_ids(filtered)
    bound_roots: set[Path] = set()
    root_sample_ids: dict[Path, set[str]] = {}
    for shard in plan["shards"]:
        shard_index = int(shard["shard_index"])
        result_root = root / wave_id / f"shard_{shard_index}"
        sample_ids = [str(value) for value in shard["sample_ids"]]
        config = {
            "protocol_version": protocol.PROTOCOL_VERSION,
            "manifest_sha256": package._sha256_file(manifest_path),
            "model_name": protocol.DEFAULT_MODEL_NAME,
            "model_snapshot_commit": protocol.MODEL_SNAPSHOT_COMMIT,
            "trials": 3,
            "base_seed": 20260713,
            "conditions": list(package.ALL_CONDITIONS),
            "generation": dict(protocol.GENERATION_DEFAULTS),
            "sample_ids": sample_ids,
        }
        _write_json(result_root / "experiment_config.json", config)
        _write_json(
            result_root / "environment.json",
            {
                "experiment_config_sha256": package._sha256_file(
                    result_root / "experiment_config.json"
                ),
                "runner_sha256": plan["runner_sha256"],
                "runtime_code_provenance": {
                    "dependency_sha256": {
                        package.BALANCED_RUNNER_DEPENDENCY: plan["runner_sha256"]
                    }
                },
            },
        )
        bound_roots.add(result_root)
        root_sample_ids[result_root] = set(sample_ids)
    return {
        "name": wave_id,
        "source_manifest": source,
        "manifest": filtered,
        "report": json.loads(report_path.read_text(encoding="utf-8")),
        "source_manifest_path": source_path,
        "source_manifest_sha256": package._sha256_file(source_path),
        "report_path": report_path,
        "exclusions_path": exclusions_path,
        "manifest_path": manifest_path,
        "filtered_manifest_sha256": package._sha256_file(manifest_path),
        "denominator_ids": set(eligible_ids),
        "eligible_ids": set(eligible_ids),
        "excluded_ids": set(),
        "bound_roots": bound_roots,
        "root_sample_ids": root_sample_ids,
    }


def _build_balanced_extension_evidence(
    result_work_root: Path, *, path_rebased: bool = False
) -> dict:
    extension_root = HERE / "balanced_extension_contingency"
    preflight_root = extension_root / "tokenizer_preflight"
    source_path = extension_root / "wave_3_manifest_pre_tokenizer.json"
    report_path = preflight_root / "full_report.json"
    exclusions_path = preflight_root / "exclusions.jsonl"
    manifest_path = preflight_root / "inference_eligible_variants.json"
    plan = json.loads(
        (extension_root / "launch_plan_wave_3.json").read_text(encoding="utf-8")
    )
    source = json.loads(source_path.read_text(encoding="utf-8"))
    filtered = json.loads(manifest_path.read_text(encoding="utf-8"))
    eligible_ids = package._expanded_manifest_ids(filtered)
    bound_roots: set[Path] = set()
    root_sample_ids: dict[Path, set[str]] = {}
    root_metadata: dict[Path, dict] = {}
    for shard in plan["shards"]:
        shard_index = int(shard["shard_index"])
        if path_rebased:
            result_root = result_work_root / "rebased" / f"shard_{shard_index}"
        else:
            result_root = result_work_root / str(shard["output_root"])
        sample_ids = [str(value) for value in shard["sample_ids"]]
        config = {
            "protocol_version": protocol.PROTOCOL_VERSION,
            "manifest_sha256": package._sha256_file(manifest_path),
            "model_name": protocol.DEFAULT_MODEL_NAME,
            "model_snapshot_commit": protocol.MODEL_SNAPSHOT_COMMIT,
            "trials": 3,
            "base_seed": 20260713,
            "conditions": list(package.ALL_CONDITIONS),
            "generation": dict(protocol.GENERATION_DEFAULTS),
            "sample_ids": sample_ids,
        }
        config_sha256 = hashlib.sha256(
            (json.dumps(config, indent=2, sort_keys=True) + "\n").encode("utf-8")
        ).hexdigest()
        environment = {
            "experiment_config_sha256": config_sha256,
            "runner_sha256": plan["runner_sha256"],
            "runtime_code_provenance": {
                "dependency_sha256": {
                    package.BALANCED_RUNNER_DEPENDENCY: plan["runner_sha256"]
                }
            },
        }
        bound_roots.add(result_root)
        root_sample_ids[result_root] = set(sample_ids)
        root_metadata[result_root.resolve()] = {
            "config": config,
            "environment": environment,
            "config_sha256": config_sha256,
        }
    return {
        "name": "balanced_wave_3",
        "source_manifest": source,
        "manifest": filtered,
        "report": json.loads(report_path.read_text(encoding="utf-8")),
        "source_manifest_path": source_path,
        "source_manifest_sha256": package._sha256_file(source_path),
        "report_path": report_path,
        "exclusions_path": exclusions_path,
        "manifest_path": manifest_path,
        "filtered_manifest_sha256": package._sha256_file(manifest_path),
        "denominator_ids": set(eligible_ids),
        "eligible_ids": set(eligible_ids),
        "excluded_ids": set(),
        "bound_roots": bound_roots,
        "root_sample_ids": root_sample_ids,
        "root_metadata": root_metadata,
    }


def _build_balanced_extension2_evidence(
    result_work_root: Path,
    wave_number: int,
    *,
    path_rebased: bool = False,
) -> dict:
    extension_root = HERE / "balanced_extension2_contingency"
    preflight_root = extension_root / "tokenizer_preflight" / f"wave_{wave_number}"
    source_path = extension_root / f"wave_{wave_number}_manifest_pre_tokenizer.json"
    report_path = preflight_root / "full_report.json"
    exclusions_path = preflight_root / "exclusions.jsonl"
    manifest_path = preflight_root / "inference_eligible_variants.json"
    plan = json.loads(
        (extension_root / f"launch_plan_wave_{wave_number}.json").read_text(
            encoding="utf-8"
        )
    )
    source = json.loads(source_path.read_text(encoding="utf-8"))
    filtered = json.loads(manifest_path.read_text(encoding="utf-8"))
    eligible_ids = package._expanded_manifest_ids(filtered)
    bound_roots: set[Path] = set()
    root_sample_ids: dict[Path, set[str]] = {}
    root_metadata: dict[Path, dict] = {}
    for shard in plan["shards"]:
        shard_index = int(shard["shard_index"])
        if path_rebased:
            result_root = result_work_root / "rebased" / f"wave_{wave_number}" / f"shard_{shard_index}"
        else:
            result_root = result_work_root / str(shard["output_root"])
        sample_ids = [str(value) for value in shard["sample_ids"]]
        config = {
            "protocol_version": protocol.PROTOCOL_VERSION,
            "manifest_sha256": package._sha256_file(manifest_path),
            "model_name": protocol.DEFAULT_MODEL_NAME,
            "model_snapshot_commit": protocol.MODEL_SNAPSHOT_COMMIT,
            "trials": 3,
            "base_seed": 20260713,
            "conditions": list(package.ALL_CONDITIONS),
            "generation": dict(protocol.GENERATION_DEFAULTS),
            "sample_ids": sample_ids,
        }
        config_sha256 = hashlib.sha256(
            (json.dumps(config, indent=2, sort_keys=True) + "\n").encode("utf-8")
        ).hexdigest()
        environment = {
            "experiment_config_sha256": config_sha256,
            "runner_sha256": plan["runner_sha256"],
            "runtime_code_provenance": {
                "dependency_sha256": {
                    package.BALANCED_RUNNER_DEPENDENCY: plan["runner_sha256"]
                }
            },
        }
        bound_roots.add(result_root)
        root_sample_ids[result_root] = set(sample_ids)
        root_metadata[package._lexical_absolute_path(result_root)] = {
            "config": config,
            "environment": environment,
            "config_sha256": config_sha256,
        }
    return {
        "name": f"balanced_wave_{wave_number}",
        "source_manifest": source,
        "manifest": filtered,
        "report": json.loads(report_path.read_text(encoding="utf-8")),
        "source_manifest_path": source_path,
        "source_manifest_sha256": package._sha256_file(source_path),
        "report_path": report_path,
        "exclusions_path": exclusions_path,
        "manifest_path": manifest_path,
        "filtered_manifest_sha256": package._sha256_file(manifest_path),
        "denominator_ids": set(eligible_ids),
        "eligible_ids": set(eligible_ids),
        "excluded_ids": set(),
        "bound_roots": bound_roots,
        "root_sample_ids": root_sample_ids,
        "root_metadata": root_metadata,
    }


def _paired_candidate(
    sample_id: str,
    *,
    canonical_index: int,
    paired_trial: int = 1,
    baseline_exact_other_trial: bool = True,
    paired_eligible: bool = True,
) -> dict:
    identity = f"dataset:row-{canonical_index:06d}"
    runs = []
    exact_counts = {condition: 0 for condition in package.ALL_CONDITIONS}
    selected_codesteer: dict | None = None
    baseline_success_trial = 2 if paired_trial != 2 else 3
    for trial in package.EXPECTED_TRIALS:
        for condition in package.ALL_CONDITIONS:
            exact = bool(
                paired_eligible
                and trial == paired_trial
                and condition == package.CODESTEER_CONDITION
            )
            if (
                baseline_exact_other_trial
                and trial == baseline_success_trial
                and condition == package.BASELINE_CONDITIONS[0]
            ):
                exact = True
            fingerprint = _sha256_text(f"{sample_id}:{trial}:{condition}")
            run = {
                "trial": trial,
                "condition": condition,
                "paired_seed": 1000 + trial,
                "valid": True,
                "trimmed_exact_match": exact,
                "parse_status": "marker_json" if exact else "marker_json",
                "fingerprint": fingerprint,
                "trace_quality": {"score": 1.0 if exact else 0.0},
            }
            runs.append(run)
            exact_counts[condition] += int(exact)
            if exact and condition == package.CODESTEER_CONDITION:
                selected_codesteer = dict(run)
    if selected_codesteer is None:
        selected_codesteer = {
            "trial": paired_trial,
            "fingerprint": _sha256_text(f"{sample_id}:none"),
            "trace_quality": {"score": 0.0},
        }
    return {
        "sample_id": sample_id,
        "problem_key": f"problem-{canonical_index}",
        "canonical_problem_identity": identity,
        "canonical_problem_identity_fields": {
            "dataset_id": package.CODECONTESTS_DATASET_ID,
            "dataset_revision": package.CODECONTESTS_REVISION,
            "dataset_file_sha256": package.CODECONTESTS_FILE_SHA256,
            "split": package.CODECONTESTS_SPLIT,
            "row_index": canonical_index,
            "cf_contest_id": canonical_index,
            "cf_index": "A",
        },
        "complete_and_valid": True,
        "strict_eligible": False,
        "expected_trials": list(package.EXPECTED_TRIALS),
        "exact_counts": exact_counts,
        "best_successful_codesteer_trial": selected_codesteer,
        "runs": runs,
    }


def _paired_review_payload(
    candidates: list[dict],
    *,
    audit_json: Path,
    audit_candidates_csv: Path,
    audit_runs_csv: Path,
) -> dict:
    entries = []
    problem_counts: dict[str, int] = {}
    for order, candidate in enumerate(candidates, 1):
        run_map, eligible_trials = package._paired_trial_eligible_trials(candidate)
        trial = eligible_trials[0]
        run = run_map[(trial, package.CODESTEER_CONDITION)]
        identity = str(candidate["canonical_problem_identity"])
        problem_counts[identity] = problem_counts.get(identity, 0) + 1
        entries.append(
            {
                "selection_order": order,
                "sample_id": candidate["sample_id"],
                "canonical_problem_identity": identity,
                "selected_codesteer_trial": trial,
                "paired_baseline_trial": trial,
                "paired_seed": run["paired_seed"],
                "selected_codesteer_fingerprint": run["fingerprint"],
                "publishable": True,
                "review_note": "Exact paired contrast with grounded reasoning.",
                "reasoning_quality": "coherent",
                "grounding_scores": {"source": 2, "input": 2, "state": 2},
                "baseline_failure_notes": {
                    condition: "Valid but non-exact at the paired trial."
                    for condition in package.BASELINE_CONDITIONS
                },
            }
        )
    canonical_counts = dict(sorted(problem_counts.items()))
    return {
        "schema_version": package.PAIRED_MANUAL_REVIEW_SCHEMA_VERSION,
        "publishable": True,
        "post_hoc_outcome_and_oracle_aware": True,
        "separate_from_outcome_blind_case_generation": True,
        "selection_mode": "same_seed_paired_trial_contrast",
        "selection_unit": "distinct_sample_id",
        "required_distinct_sample_id_count": 10,
        "baseline_zero_of_three_required": False,
        "canonical_problem_repeats_allowed": True,
        "display_pass_at_k": False,
        "aggregate_performance_claim_supported": False,
        "ten_problem_generalization_claim_supported": False,
        "audit_inputs": {
            "json_sha256": package._sha256_file(audit_json),
            "candidates_csv_sha256": package._sha256_file(audit_candidates_csv),
            "runs_csv_sha256": package._sha256_file(audit_runs_csv),
        },
        "reported_distinct_canonical_problem_count": len(canonical_counts),
        "reported_canonical_problem_repeat_entry_count": 10 - len(canonical_counts),
        "reported_sample_count_by_canonical_problem": canonical_counts,
        "entries": entries,
    }


def _rewrite_run_as_real_artifact(
    result_root: Path,
    *,
    sample_id: str,
    trial: int,
    condition: protocol.ConditionInput,
    manifest_hash: str,
    source_code: str,
    exact: bool,
    reasoning: str,
) -> None:
    audit_fixtures._write_run(
        result_root,
        sample_id=sample_id,
        trial=trial,
        condition=condition.name,
        exact=exact,
        reasoning=reasoning,
        source_code=source_code,
    )
    run_dir = result_root / "runs" / sample_id / f"trial_{trial:03d}" / condition.name
    prompt = f"{condition.instruction}\n\n```java\n{condition.source_code}\n```"
    (run_dir / "submitted_prompt.txt").write_text(prompt, encoding="utf-8")
    (run_dir / "model_prompt_decoded.txt").write_text(prompt, encoding="utf-8")
    completion = (run_dir / "raw_completion.txt").read_text(encoding="utf-8")
    predicted, parse_meta = protocol.parse_final_output(completion)
    (run_dir / "predicted_stdout.txt").write_text(predicted or "", encoding="utf-8")
    score = json.loads((run_dir / "score.json").read_text(encoding="utf-8"))
    score.update(
        {
            **parse_meta,
            "predicted_stdout": predicted,
            "predicted_stdout_canonical": protocol.normalize_stdout(predicted) if predicted is not None else None,
            "oracle_stdout_canonical": protocol.normalize_stdout(audit_fixtures.ORACLE),
        }
    )
    _write_json(run_dir / "score.json", score)

    run_config = json.loads((run_dir / "run_config.json").read_text(encoding="utf-8"))
    run_config.update(
        {
            "manifest_sha256": manifest_hash,
            "prompt_sha256": _sha256_text(prompt),
            "prompt_metadata": condition.prompt_metadata,
            "source_path": str(run_dir / "source.java"),
            "target_method": condition.target_method,
        }
    )
    fingerprint_payload = audit._fingerprint_payload(run_config)
    fingerprint = protocol._run_fingerprint(fingerprint_payload)
    run_config["fingerprint"] = fingerprint
    _write_json(run_dir / "run_config.json", run_config)

    record = json.loads((run_dir / "record.json").read_text(encoding="utf-8"))
    record["fingerprint"] = fingerprint
    record["score"] = score
    record.setdefault("artifacts", {}).update(
        {
            "model_prompt_decoded": "model_prompt_decoded.txt",
            "predicted_stdout": "predicted_stdout.txt",
            "status": "status.json",
        }
    )
    _write_json(run_dir / "record.json", record)
    _write_json(run_dir / "status.json", record)
    _write_json(
        run_dir / "model_output.json",
        {
            "prompt_text": prompt,
            "generated_completion": completion,
            "generated_text": prompt + completion,
            "score": score,
            "experiment": {
                "sample_id": sample_id,
                "trial": trial,
                "condition": condition.name,
                "paired_seed": run_config["paired_seed"],
                "fingerprint": fingerprint,
            },
            "steering_debug": json.loads((run_dir / "steering_debug.json").read_text()),
        },
    )


def _build_fixture(
    root: Path,
    *,
    candidate_count: int = 10,
    unique_problems: int = 10,
    physical_loc_delta: int = 0,
    dataset_revision: str = package.CODECONTESTS_REVISION,
    path_based_cases: bool = False,
) -> dict:
    result_root = root / "results"
    sample_ids = [f"candidate-{index:02d}__case-001" for index in range(1, candidate_count + 1)]
    source_hash = protocol._sha256_bytes(LONG_SOURCE.encode("utf-8"))
    stdin = "3\n"
    candidate_pool_root = root / "candidate_pool"
    prepared_root = root / "prepared"
    provenance_root = root / "provenance"
    provenance_root.mkdir()
    (provenance_root / "README.md").write_text("Test provenance.\n", encoding="utf-8")
    variants = []
    snapshots = {}
    dataset_rows = {}
    for index, sample_id in enumerate(sample_ids, 1):
        problem_index = ((index - 1) % unique_problems) + 1
        contest_id = 9000 + problem_index
        problem_key = f"codeforces-{contest_id}-A"
        candidate_id = sample_id.rsplit("__", 1)[0]
        candidate_dir = candidate_pool_root / "candidates" / candidate_id
        candidate_source = candidate_dir / "original.java"
        candidate_source.parent.mkdir(parents=True, exist_ok=True)
        candidate_source.write_text(LONG_SOURCE, encoding="utf-8")
        prepared_candidate = prepared_root / "candidates" / candidate_id
        prepared_original = prepared_candidate / "original" / "Demo.java"
        prepared_obfuscated = prepared_candidate / "variants" / "T5_bogus_control_flow" / "easy" / "seed_1" / "Demo.java"
        prepared_original.parent.mkdir(parents=True, exist_ok=True)
        prepared_obfuscated.parent.mkdir(parents=True, exist_ok=True)
        prepared_original.write_text(LONG_SOURCE, encoding="utf-8")
        prepared_obfuscated.write_text(LONG_SOURCE, encoding="utf-8")
        provenance = {
            "dataset_id": package.CODECONTESTS_DATASET_ID,
            "dataset_revision": dataset_revision,
            "dataset_file": "codecontests-valid-802411c3.parquet",
            "dataset_file_sha256": package.CODECONTESTS_FILE_SHA256,
            "dataset_url": "https://example.invalid/immutable.parquet",
            "split": package.CODECONTESTS_SPLIT,
            "row_index": problem_index,
            "solution_index": index,
            "solution_label": package.CODECONTESTS_SOLUTION_LABEL,
            "solution_container": package.CODECONTESTS_SOLUTION_CONTAINER,
            "source_code": package.CODECONTESTS_SOURCE_CODE,
            "language": package.CODECONTESTS_LANGUAGE,
            "language_code": package.CODECONTESTS_LANGUAGE_CODE,
            "cf_contest_id": contest_id,
            "cf_index": "A",
        }
        row = dataset_rows.setdefault(
            problem_index,
            {
                "name": f"{contest_id}_A. Test problem {problem_index}",
                "cf_contest_id": contest_id,
                "cf_index": "A",
                "solutions": {"language": [], "solution": []},
            },
        )
        while len(row["solutions"]["language"]) <= index:
            row["solutions"]["language"].append(0)
            row["solutions"]["solution"].append("")
        row["solutions"]["language"][index] = package.CODECONTESTS_LANGUAGE_CODE
        row["solutions"]["solution"][index] = LONG_SOURCE
        candidate_metadata = {
            "id": candidate_id,
            "problem_key": problem_key,
            "problem_name": f"{contest_id}_A. Test problem {problem_index}",
            "physical_loc": len(LONG_SOURCE.splitlines()) + physical_loc_delta,
            "nonblank_loc": sum(bool(line.strip()) for line in LONG_SOURCE.splitlines()),
            "source_bytes": len(LONG_SOURCE.encode("utf-8")),
            "source_sha256": source_hash,
            "original_path": f"candidates/{candidate_id}/original.java",
            "target_method": "solve",
            "provenance": provenance,
        }
        _write_json(candidate_dir / "metadata.json", candidate_metadata)
        case = {
            "case_id": "case-001",
            "stdin": stdin,
            "input": stdin,
            "input_sha256": _sha256_text(stdin),
            "expected_stdout": audit_fixtures.ORACLE,
            "expected_output": audit_fixtures.ORACLE,
            "expected_stdout_trimmed": protocol.normalize_stdout(audit_fixtures.ORACLE),
            "raw_expected_stdout_sha256": _sha256_text(audit_fixtures.ORACLE),
            "argv": [],
        }
        if path_based_cases:
            case_root = prepared_root / "tests" / candidate_id / "case-001"
            case_root.mkdir(parents=True, exist_ok=True)
            (case_root / "stdin.txt").write_text(stdin, encoding="utf-8")
            (case_root / "oracle_stdout.txt").write_text(
                audit_fixtures.ORACLE, encoding="utf-8"
            )
            case = {
                "case_id": "case-001",
                "stdin_path": f"tests/{candidate_id}/case-001/stdin.txt",
                "expected_output_path": (
                    f"tests/{candidate_id}/case-001/oracle_stdout.txt"
                ),
                "input_sha256": _sha256_text(stdin),
                "input_bytes": len(stdin.encode("utf-8")),
                "raw_expected_stdout_sha256": _sha256_text(audit_fixtures.ORACLE),
                "expected_output_bytes": len(audit_fixtures.ORACLE.encode("utf-8")),
                "expected_output_lines": len(audit_fixtures.ORACLE.splitlines()),
                "argv": [],
            }
        variant = {
            "id": candidate_id,
            "candidate_id": candidate_id,
            "candidate_metadata": candidate_metadata,
            "original_path": str(prepared_original),
            "obfuscated_path": str(prepared_obfuscated),
            "original_target_method": "solve",
            "obfuscated_target_method": "solve",
            "target_method": "solve",
            "original_main_class": "Demo",
            "obfuscated_main_class": "Demo",
            "cases": [case],
            "eligible": True,
        }
        variants.append(variant)
        sample_snapshot = {
            "sample_id": sample_id,
            "argv": [],
            "original_sha256": source_hash,
            "obfuscated_sha256": source_hash,
            "original_source_path": str(prepared_original),
            "obfuscated_source_path": str(prepared_obfuscated),
            "original_target_method": "solve",
            "obfuscated_target_method": "solve",
            "metadata": {
                **variant,
                "concrete_case": case,
            },
        }
        snapshots[sample_id] = sample_snapshot

    (prepared_root / "provenance").mkdir(parents=True)
    _write_json(prepared_root / "provenance" / "preparation_provenance.json", {"test": True})
    source_manifest = {
        "schema_version": "long-code-obfuscated-variants-v1",
        "selection_stage": "static_and_execution_eligibility_only_no_model_outcomes",
        "variant_count": len(variants),
        "variants": variants,
    }
    _write_json(prepared_root / "eligible_variants.json", source_manifest)
    source_manifest_hash = hashlib.sha256((prepared_root / "eligible_variants.json").read_bytes()).hexdigest()
    for name in package.PREPARED_EVIDENCE_FILES:
        path = prepared_root / name
        if not path.exists():
            path.write_text("{}\n" if name.endswith(".json") else "", encoding="utf-8")
    _write_json(candidate_pool_root / "candidate_manifest.json", {"samples": list(snapshots.values())})
    (candidate_pool_root / "candidate_index.tsv").write_text("sample_id\n" + "\n".join(sample_ids) + "\n")

    tokenizer_root = root / "tokenizer"
    tokenizer_variants = json.loads(json.dumps(variants))
    if path_based_cases:
        for variant in tokenizer_variants:
            for case in variant["cases"]:
                case["stdin_path"] = f"../prepared/{case['stdin_path']}"
                case["expected_output_path"] = (
                    f"../prepared/{case['expected_output_path']}"
                )
    tokenizer_manifest = {
        "schema_version": "long-code-obfuscated-variants-v1",
        "variant_count": len(variants),
        "tokenizer_preflight": {
            "schema_version": "long-code-tokenizer-preflight-v1",
            "input_top_level_count": len(variants),
            "retained_top_level_count": len(variants),
            "retained_exploded_sample_count": len(variants),
            "full_report": "full_report.json",
            "exclusions": "exclusions.jsonl",
            "source_manifest_sha256": source_manifest_hash,
        },
        "variants": tokenizer_variants,
    }
    _write_json(tokenizer_root / "manifest.json", tokenizer_manifest)
    manifest_hash = hashlib.sha256((tokenizer_root / "manifest.json").read_bytes()).hexdigest()

    audit_fixtures._write_experiment_config(result_root, sample_ids)
    config_path = result_root / "experiment_config.json"
    config = json.loads(config_path.read_text(encoding="utf-8"))
    config.update(
        {
            "manifest_sha256": manifest_hash,
            "manifest_path": str(tokenizer_root / "manifest.json"),
            "manifest_metadata": {
                "tokenizer_preflight": {"source_manifest_sha256": source_manifest_hash}
            },
            "model_snapshot_commit": protocol.MODEL_SNAPSHOT_COMMIT,
        }
    )
    _write_json(config_path, config)
    environment_path = result_root / "environment.json"
    environment = json.loads(environment_path.read_text(encoding="utf-8"))
    dependency_hashes = _runtime_dependency_hashes()
    environment.update(
        {
            "experiment_config_sha256": hashlib.sha256(config_path.read_bytes()).hexdigest(),
            "model_snapshot_commit_registered": protocol.MODEL_SNAPSHOT_COMMIT,
            "model_snapshot_commit_cached_ref": protocol.MODEL_SNAPSHOT_COMMIT,
            "model_snapshot_commit_verified": True,
            "runner_sha256": dependency_hashes[
                "PromptSteering/long-code-sample-work/run_long_code_experiment.py"
            ],
            "runtime_code_provenance": {
                "dependency_sha256": dependency_hashes,
                "git_revision": "1" * 40,
                "git_dirty": True,
            },
        }
    )
    _write_json(environment_path, environment)

    samples, _ = protocol.load_manifest(tokenizer_root / "manifest.json")
    sample_map = {sample.sample_id: sample for sample in samples}
    token_records = []
    for index, sample_id in enumerate(sample_ids, 1):
        sample = sample_map[sample_id]
        conditions, _ = protocol.prepare_conditions(sample)
        condition_map = {condition.name: condition for condition in conditions}
        sample_dir = result_root / "samples" / sample_id
        _write_json(sample_dir / "sample.json", snapshots[sample_id])
        (sample_dir / "stdin.txt").write_text(stdin, encoding="utf-8")
        (sample_dir / "oracle_stdout.txt").write_text(audit_fixtures.ORACLE, encoding="utf-8")
        (sample_dir / "original.java").write_text(LONG_SOURCE, encoding="utf-8")
        (sample_dir / "obfuscated.java").write_text(LONG_SOURCE, encoding="utf-8")
        _write_json(sample_dir / "static_preflight.json", {"eligible": True})
        _write_json(
            sample_dir / "preflight.json",
            {
                "eligible_for_inference": True,
                "rejection_reasons": [],
                "codesteer_prior": {
                    "algorithm_fallback_detected": False,
                    "case_signal_active": True,
                },
            },
        )
        _write_json(
            sample_dir / "oracle.json",
            {
                "manifest_oracle_verified": True,
                "semantic_equivalence_verified": True,
                "oracle_stdout": audit_fixtures.ORACLE,
                "original_execution": {"success": True, "stdout": audit_fixtures.ORACLE},
                "obfuscated_execution": {"success": True, "stdout": audit_fixtures.ORACLE},
            },
        )
        for trial in range(1, 4):
            for condition in protocol.CONDITIONS:
                if condition == audit.CODESTEER_CONDITION:
                    exact = trial in {1, 2}
                    reasoning = (
                        audit_fixtures.STRONG_REASONING
                        if trial == 2
                        else audit_fixtures.WEAK_REASONING
                    )
                else:
                    exact = False
                    reasoning = audit_fixtures.WEAK_REASONING
                _rewrite_run_as_real_artifact(
                    result_root,
                    sample_id=sample_id,
                    trial=trial,
                    condition=condition_map[condition],
                    manifest_hash=manifest_hash,
                    source_code=LONG_SOURCE,
                    exact=exact,
                    reasoning=reasoning,
                )

        token_condition = condition_map[audit.CODESTEER_CONDITION]
        token_prompt = f"{token_condition.instruction}\n\n```java\n{token_condition.source_code}\n```"
        prompt_hash = _sha256_text(token_prompt)
        token_records.append(
            {
                "sample_id": sample_id,
                "case_id": "case-001",
                "denominator_index": index,
                "decision": {"inference_eligible": True, "exclusion_reasons": []},
                "inputs": {
                    "original_path": str(sample.original_path),
                    "obfuscated_path": str(sample.obfuscated_path),
                    "original_target_method": sample.original_target_method,
                    "obfuscated_target_method": sample.obfuscated_target_method,
                },
                "inference_helper_result": {
                    "algorithm_fallback_detected": False,
                    "algorithm_vector_length": 1000,
                    "algorithm_vs_fallback_l1": 1.0,
                    "case_signal_active": True,
                    "case_vector_count": 1,
                    "fallback_vector_length": 1000,
                    "n_bins": 12,
                    "parsed_case_ids": ["c001"],
                    "prompt_sha256": prompt_hash,
                },
                "prompt": {
                    "text": token_prompt,
                    "sha256": prompt_hash,
                    "token_count": 1000,
                    "token_ids_sha256": _sha256_text(f"ids-{sample_id}"),
                    "token_strings_sha256": _sha256_text(f"tokens-{sample_id}"),
                    "codesteer_instruction_equals_obfuscated_plain": True,
                    "markers": {
                        "cases_begin_present": True,
                        "cases_end_present": True,
                        "c001_spec_present": True,
                    },
                    "token_preflight": {
                        "prompt_sha256": prompt_hash,
                        "prompt_token_count": 1000,
                        "context_limit": 131072,
                        "max_new_tokens": 512,
                        "fits_context": True,
                        "context_margin_tokens": 129560,
                    },
                },
                "slicing_prior": {
                    "algorithm_fallback_detected": False,
                    "bin_index": 0,
                    "n_bins": 12,
                    "actual": _vector_summary(1000, f"actual-{sample_id}"),
                    "normalized_positional_fallback": _vector_summary(
                        1000, f"fallback-{sample_id}"
                    ),
                    "comparison": {
                        "same_shape": True,
                        "allclose": False,
                        "l1_distance": 1.0,
                    },
                },
                "slice_hybrid": {
                    "case_signal_active": True,
                    "case_vector_count": 1,
                    "parsed_case_ids": ["c001"],
                    "case_vectors": [
                        _vector_summary(1000, f"case-{sample_id}")
                    ],
                    "hybrid_vector": _vector_summary(1000, f"hybrid-{sample_id}"),
                },
            }
        )

    report = audit.audit_result_roots([result_root])
    assert report["validation"]["ok"], report["validation"]
    audit_paths = audit.write_reports(report, root / "audit")

    snapshot_dir = root / "model-cache" / "snapshots" / protocol.MODEL_SNAPSHOT_COMMIT
    snapshot_dir.mkdir(parents=True)
    tokenizer_files = {}
    for name in ("config.json", "merges.txt", "tokenizer.json", "tokenizer_config.json", "vocab.json"):
        path = snapshot_dir / name
        path.write_text(f"test {name}\n", encoding="utf-8")
        tokenizer_files[name] = {
            "bytes": path.stat().st_size,
            "sha256": hashlib.sha256(path.read_bytes()).hexdigest(),
        }
    token_report = {
        "schema_version": "long-code-tokenizer-preflight-v1",
        "purpose": "test full denominator",
        "counts": {
            "exploded_denominator_records": len(token_records),
            "input_top_level_variants": len(token_records),
            "inference_eligible_records": len(token_records),
            "excluded_records": 0,
            "preflight_error_records": 0,
        },
        "source_manifest": {
            "path": str((prepared_root / "eligible_variants.json").relative_to(HERE)),
            "sha256": source_manifest_hash,
        },
        "tokenizer": {
            "model_id": protocol.DEFAULT_MODEL_NAME,
            "snapshot_commit": protocol.MODEL_SNAPSHOT_COMMIT,
            "snapshot_dir_read_only_input": str(snapshot_dir),
            "model_max_length": 131072,
            "model_weights_loaded": False,
            "padding_side": "left",
            "offline_environment": {
                "HF_HUB_OFFLINE": "1",
                "TRANSFORMERS_OFFLINE": "1",
            },
            "files": tokenizer_files,
        },
        "records": token_records,
    }
    _write_json(tokenizer_root / "full_report.json", token_report)
    (tokenizer_root / "exclusions.jsonl").write_text("", encoding="utf-8")
    return {
        "result_root": result_root,
        "audit_json": Path(audit_paths["json"]),
        "audit_candidates_csv": Path(audit_paths["candidates_csv"]),
        "audit_runs_csv": Path(audit_paths["runs_csv"]),
        "tokenizer_report": tokenizer_root / "full_report.json",
        "tokenizer_exclusions": tokenizer_root / "exclusions.jsonl",
        "tokenizer_manifest": tokenizer_root / "manifest.json",
        "provenance_root": provenance_root,
        "candidate_pool_root": candidate_pool_root,
        "prepared_root": prepared_root,
        "sample_ids": sample_ids,
        "dataset_rows": dataset_rows,
    }


def _package_kwargs(fixture: dict, output_dir: Path) -> dict:
    return {
        "audit_json": fixture["audit_json"],
        "audit_candidates_csv": fixture["audit_candidates_csv"],
        "audit_runs_csv": fixture["audit_runs_csv"],
        "result_roots": [fixture["result_root"]],
        "output_dir": output_dir,
        "tokenizer_report": fixture["tokenizer_report"],
        "tokenizer_exclusions": fixture["tokenizer_exclusions"],
        "tokenizer_manifest": fixture["tokenizer_manifest"],
        "provenance_root": fixture["provenance_root"],
        "candidate_pool_root": fixture["candidate_pool_root"],
        "prepared_root": fixture["prepared_root"],
    }


def _package_fixture(
    fixture: dict, output_dir: Path, **overrides: object
) -> dict:
    # The integration fixture uses a deliberately tiny synthetic tokenizer and
    # synthetic parquet rows. Dedicated tests below exercise the real immutable
    # parquet binding and the recomputation gate's fail-closed behavior.
    with mock.patch.object(
        package, "_load_codecontests_rows", return_value=fixture["dataset_rows"]
    ), mock.patch.object(package, "_recompute_tokenizer_evidence", return_value=None):
        kwargs = _package_kwargs(fixture, output_dir)
        kwargs.update(overrides)
        return package.package_case_study(**kwargs)


def _manual_review_payload(
    fixture: dict, *, selected_trial: int = 1, reverse: bool = True
) -> dict:
    report = json.loads(fixture["audit_json"].read_text(encoding="utf-8"))
    candidates = list(report["candidates"][: package.CASE_COUNT])
    if reverse:
        candidates.reverse()
    entries = []
    for order, candidate in enumerate(candidates, 1):
        selected_run = next(
            run
            for run in candidate["runs"]
            if run["condition"] == package.CODESTEER_CONDITION
            and int(run["trial"]) == selected_trial
        )
        entries.append(
            {
                "selection_order": order,
                "sample_id": candidate["sample_id"],
                "canonical_problem_identity": candidate[
                    "canonical_problem_identity"
                ],
                "selected_codesteer_trial": selected_trial,
                "selected_codesteer_fingerprint": selected_run["fingerprint"],
                "publishable": True,
                "review_note": (
                    "The selected trace is concise and sufficiently grounded for the "
                    "qualitative discussion."
                ),
                "reasoning_quality": "mostly_coherent",
                "grounding_scores": {"source": 2, "input": 2, "state": 1},
                "baseline_failure_notes": {
                    condition: "All three registered trials fail trimmed exact match."
                    for condition in package.BASELINE_CONDITIONS
                },
            }
        )
    return {
        "schema_version": package.MANUAL_REVIEW_SCHEMA_VERSION,
        "publishable": True,
        "post_hoc_outcome_and_oracle_aware": True,
        "separate_from_outcome_blind_case_generation": True,
        "audit_inputs": {
            "json_sha256": package._sha256_file(fixture["audit_json"]),
            "candidates_csv_sha256": package._sha256_file(
                fixture["audit_candidates_csv"]
            ),
            "runs_csv_sha256": package._sha256_file(fixture["audit_runs_csv"]),
        },
        "entries": entries,
    }


def _tree_hashes(root: Path) -> dict[str, str]:
    return {
        path.relative_to(root).as_posix(): hashlib.sha256(path.read_bytes()).hexdigest()
        for path in sorted(root.rglob("*"))
        if path.is_file()
    }


class PackageLongCodeCaseStudyTests(unittest.TestCase):
    def test_prompt_lineage_join_filters_excluded_tokenizer_denominator_rows(self) -> None:
        records = package._eligible_token_record_map(
            {
                "records": [
                    {
                        "sample_id": "kept",
                        "decision": {"inference_eligible": True},
                    },
                    {
                        "sample_id": "excluded",
                        "decision": {"inference_eligible": False},
                    },
                ]
            }
        )
        self.assertEqual(set(records), {"kept"})

    def test_builds_deterministic_self_contained_ten_case_artifact(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as raw_temp:
            root = Path(raw_temp)
            fixture = _build_fixture(root)
            first = root / "package-one"
            second = root / "package-two"
            first_result = _package_fixture(fixture, first)
            second_result = _package_fixture(fixture, second)

            self.assertEqual(first_result["case_count"], 10)
            self.assertEqual(first_result["manifest_sha256"], second_result["manifest_sha256"])
            self.assertEqual(first_result["checksums_sha256"], second_result["checksums_sha256"])
            self.assertEqual(first_result["sample_ids"], sorted(fixture["sample_ids"])[:10])
            self.assertEqual(_tree_hashes(first), _tree_hashes(second))
            cases = sorted((first / "cases").glob("case_*"))
            self.assertEqual(len(cases), 10)
            for case_dir in cases:
                for name in ("original.java", "obfuscated.java", "stdin.txt", "oracle_stdout.txt"):
                    self.assertTrue((case_dir / name).is_file())
                for name in ("predicted_stdout.txt", "model_prompt_decoded.txt", "status.json"):
                    self.assertTrue((case_dir / "codesteer_best" / name).is_file())
                for name in package.REQUIRED_SAMPLE_ARTIFACTS:
                    self.assertTrue((case_dir / "sample_evidence" / name).is_file())
                metadata = json.loads((case_dir / "metadata.json").read_text(encoding="utf-8"))
                self.assertTrue(metadata["selection_is_post_hoc_outcome_conditioned"])
                self.assertFalse(metadata["aggregate_claim_supported"])
                best_config = json.loads(
                    (case_dir / "codesteer_best" / "run_config.json").read_text(encoding="utf-8")
                )
                for condition in package.BASELINE_CONDITIONS:
                    baseline_config = json.loads(
                        (case_dir / "paired_baselines" / condition / "run_config.json").read_text(
                            encoding="utf-8"
                        )
                    )
                    self.assertEqual(best_config["trial"], baseline_config["trial"])
                    self.assertEqual(best_config["paired_seed"], baseline_config["paired_seed"])
                trial_index = json.loads(
                    (case_dir / "all_trials" / "index.json").read_text(encoding="utf-8")
                )
                self.assertEqual(len(trial_index), 12)

            local_paths = json.loads(
                (first / "screened_pool" / "result_roots" / "local_audit_path_index.json").read_text()
            )
            self.assertEqual(len(local_paths), 10 * 3 * 4)
            for row in local_paths:
                self.assertTrue(
                    (first / "screened_pool" / "result_roots" / row["package_local_record_path"]).is_file()
                )
            self.assertTrue(
                (first / "screened_pool" / "candidate_pool" / "candidates" / "candidate-01" / "original.java").is_file()
            )
            self.assertTrue(
                (first / "screened_pool" / "prepared_variants" / "candidates" / "candidate-01").is_dir()
            )
            self.assertTrue(
                (first / "scripts" / "pipeline" / "test_package_long_code_case_study.py").is_file()
            )
            for name in ("full_report.json", "exclusions.jsonl", "manifest.json"):
                self.assertTrue((first / "screened_pool" / "tokenizer" / name).is_file())
            dependency_index = json.loads(
                (first / "scripts" / "runtime_dependencies" / "index.json").read_text()
            )
            self.assertGreaterEqual(len(dependency_index), 9)

            public_text = (first / "README.md").read_text() + (first / "SUMMARY.md").read_text()
            self.assertNotIn("pass@", public_text.lower())
            self.assertIn("does not include model weights", public_text.lower())
            checksum_rows = (first / "SHA256SUMS").read_text(encoding="utf-8").splitlines()
            for row in checksum_rows:
                expected, relative = row.split("  ", 1)
                self.assertEqual(hashlib.sha256((first / relative).read_bytes()).hexdigest(), expected)

    def test_manual_review_overrides_order_and_exact_codesteer_trial(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as raw_temp:
            root = Path(raw_temp)
            fixture = _build_fixture(root)
            review_payload = _manual_review_payload(
                fixture, selected_trial=1, reverse=True
            )
            review_path = root / "manual_trace_review.json"
            _write_json(review_path, review_payload)
            output = root / "manual-package"
            result = _package_fixture(
                fixture, output, manual_review=review_path
            )
            expected_ids = [entry["sample_id"] for entry in review_payload["entries"]]
            self.assertEqual(result["sample_ids"], expected_ids)
            self.assertEqual(
                (output / "selection_review" / "manual_trace_review.json").read_bytes(),
                review_path.read_bytes(),
            )
            manifest = json.loads((output / "manifest.json").read_text(encoding="utf-8"))
            manual = manifest["manual_trace_review"]
            self.assertTrue(manual["included"])
            self.assertTrue(manual["ordered_selection_override_applied"])
            self.assertTrue(manual["post_hoc_outcome_and_oracle_aware"])
            self.assertEqual(manual["sha256"], package._sha256_file(review_path))
            self.assertEqual(
                [entry["sample_id"] for entry in manual["selections"]], expected_ids
            )
            for index, expected_entry in enumerate(review_payload["entries"], 1):
                case_dir = output / "cases" / f"case_{index:02d}"
                metadata = json.loads(
                    (case_dir / "metadata.json").read_text(encoding="utf-8")
                )
                self.assertEqual(metadata["sample_id"], expected_entry["sample_id"])
                self.assertEqual(metadata["best_codesteer_trial"]["trial"], 1)
                self.assertEqual(
                    metadata["manual_trace_review"][
                        "heuristic_best_codesteer_trial"
                    ]["trial"],
                    2,
                )
                self.assertEqual(
                    metadata["best_codesteer_trial"]["fingerprint"],
                    expected_entry["selected_codesteer_fingerprint"],
                )
            summary = (output / "SUMMARY.md").read_text(encoding="utf-8")
            self.assertIn("post-hoc, outcome- and oracle-aware", summary)
            self.assertIn("Reviewed trial", summary)
            checksums = (output / "SHA256SUMS").read_text(encoding="utf-8")
            self.assertIn("selection_review/manual_trace_review.json", checksums)

    def test_manual_review_validation_rejects_tampering(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as raw_temp:
            root = Path(raw_temp)
            fixture = _build_fixture(root)
            report = json.loads(fixture["audit_json"].read_text(encoding="utf-8"))
            valid = _manual_review_payload(fixture, selected_trial=1)
            review_path = root / "manual_trace_review.json"

            def validate(payload: dict) -> None:
                _write_json(review_path, payload)
                package._validate_manual_trace_review(
                    review_path,
                    report=report,
                    audit_json=fixture["audit_json"],
                    audit_candidates_csv=fixture["audit_candidates_csv"],
                    audit_runs_csv=fixture["audit_runs_csv"],
                )

            validate(valid)
            mutations: list[tuple[str, dict, str]] = []

            bad_hash = json.loads(json.dumps(valid))
            bad_hash["audit_inputs"]["json_sha256"] = "0" * 64
            mutations.append(("audit hash", bad_hash, "audit hashes"))

            duplicate = json.loads(json.dumps(valid))
            duplicate["entries"][1] = dict(duplicate["entries"][0])
            duplicate["entries"][1]["selection_order"] = 2
            mutations.append(("duplicate identity", duplicate, "must be distinct"))

            nonexact = json.loads(json.dumps(valid))
            candidate = report["candidates"][0]
            failed_run = next(
                run
                for run in candidate["runs"]
                if run["condition"] == package.CODESTEER_CONDITION
                and run["trial"] == 3
            )
            target_entry = next(
                entry
                for entry in nonexact["entries"]
                if entry["sample_id"] == candidate["sample_id"]
            )
            target_entry["selected_codesteer_trial"] = 3
            target_entry["selected_codesteer_fingerprint"] = failed_run["fingerprint"]
            mutations.append(("nonexact trial", nonexact, "not an exact valid"))

            bad_grounding = json.loads(json.dumps(valid))
            bad_grounding["entries"][0]["grounding_scores"]["state"] = 3
            mutations.append(("grounding", bad_grounding, "outside 0-2"))

            not_publishable = json.loads(json.dumps(valid))
            not_publishable["entries"][0]["publishable"] = False
            mutations.append(("publishable", not_publishable, "not publishable"))

            empty_note = json.loads(json.dumps(valid))
            empty_note["entries"][0]["review_note"] = "   "
            mutations.append(("empty note", empty_note, "must be nonempty"))

            missing_baseline_note = json.loads(json.dumps(valid))
            del missing_baseline_note["entries"][0]["baseline_failure_notes"][
                package.BASELINE_CONDITIONS[0]
            ]
            mutations.append(
                ("baseline note", missing_baseline_note, "notes are incomplete")
            )

            invalid_reasoning = json.loads(json.dumps(valid))
            invalid_reasoning["entries"][0]["reasoning_quality"] = "excellent"
            mutations.append(("reasoning enum", invalid_reasoning, "enum is invalid"))

            for label, payload, message in mutations:
                with self.subTest(label=label), self.assertRaisesRegex(
                    package.PackageError, message
                ):
                    validate(payload)

    def test_refuses_non_ok_audit_before_packaging(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as raw_temp:
            root = Path(raw_temp)
            fixture = _build_fixture(root)
            report = json.loads(fixture["audit_json"].read_text(encoding="utf-8"))
            report["validation"]["ok"] = False
            _write_json(fixture["audit_json"], report)
            with self.assertRaisesRegex(package.PackageError, "validation is not OK"):
                _package_fixture(fixture, root / "rejected")
            self.assertFalse((root / "rejected").exists())
            self.assertEqual(list(root.glob(".rejected.building-*")), [])

    def test_refuses_ten_candidates_from_only_nine_true_problems(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as raw_temp:
            root = Path(raw_temp)
            fixture = _build_fixture(root, candidate_count=10, unique_problems=9)
            with self.assertRaisesRegex(package.PackageError, "distinct true problem keys"):
                _package_fixture(fixture, root / "rejected")
            self.assertFalse((root / "rejected").exists())

    def test_recomputes_loc_instead_of_trusting_metadata(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as raw_temp:
            root = Path(raw_temp)
            fixture = _build_fixture(root, physical_loc_delta=1)
            with self.assertRaisesRegex(package.PackageError, "source hashes/metrics"):
                _package_fixture(fixture, root / "rejected")

    def test_requires_exact_codecontests_revision(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as raw_temp:
            root = Path(raw_temp)
            fixture = _build_fixture(root)
            report = json.loads(fixture["audit_json"].read_text(encoding="utf-8"))
            candidate = report["candidates"][0]
            snapshot_path = next(fixture["result_root"].glob("samples/*/sample.json"))
            snapshot = json.loads(snapshot_path.read_text(encoding="utf-8"))
            snapshot["metadata"]["candidate_metadata"]["provenance"]["dataset_revision"] = "f" * 40
            with self.assertRaisesRegex(package.PackageError, "Non-canonical CodeContests provenance"):
                package._validate_problem_provenance(candidate, snapshot)

    def test_refuses_tokenizer_eligible_record_with_fallback(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as raw_temp:
            root = Path(raw_temp)
            fixture = _build_fixture(root)
            token_report = json.loads(fixture["tokenizer_report"].read_text(encoding="utf-8"))
            token_report["records"][0]["slicing_prior"]["algorithm_fallback_detected"] = True
            _write_json(fixture["tokenizer_report"], token_report)
            with self.assertRaisesRegex(package.PackageError, "SlicingPrior invariants"):
                _package_fixture(fixture, root / "rejected")

    def test_filtered_manifest_hash_must_match_experiment_config(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as raw_temp:
            root = Path(raw_temp)
            fixture = _build_fixture(root)
            manifest = json.loads(fixture["tokenizer_manifest"].read_text(encoding="utf-8"))
            manifest["extra_tamper"] = True
            _write_json(fixture["tokenizer_manifest"], manifest)
            with self.assertRaisesRegex(package.PackageError, "binds filtered manifest hash"):
                _package_fixture(fixture, root / "rejected")

    def test_model_decoded_prompt_must_match_runner_reconstruction(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as raw_temp:
            root = Path(raw_temp)
            fixture = _build_fixture(root)
            decoded = next(fixture["result_root"].glob("runs/*/trial_001/original_plain/model_prompt_decoded.txt"))
            decoded.write_text("tampered prompt\n", encoding="utf-8")
            with self.assertRaisesRegex(package.PackageError, "fails runner reconstruction"):
                _package_fixture(fixture, root / "rejected")

    def test_executable_oracle_evidence_is_required(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as raw_temp:
            root = Path(raw_temp)
            fixture = _build_fixture(root)
            oracle_path = next(fixture["result_root"].glob("samples/*/oracle.json"))
            oracle = json.loads(oracle_path.read_text(encoding="utf-8"))
            oracle["semantic_equivalence_verified"] = False
            _write_json(oracle_path, oracle)
            with self.assertRaisesRegex(package.PackageError, "executable oracle evidence is invalid"):
                _package_fixture(fixture, root / "rejected")

    def test_refuses_stale_or_modified_audit_csv(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as raw_temp:
            root = Path(raw_temp)
            fixture = _build_fixture(root)
            with fixture["audit_candidates_csv"].open("a", encoding="utf-8") as stream:
                stream.write("\n")
            with self.assertRaisesRegex(package.PackageError, "canonical companion"):
                _package_fixture(fixture, root / "rejected")

    def test_two_tokenizer_gates_require_disjoint_exact_union_and_root_binding(self) -> None:
        root_a = Path("/synthetic/root-a")
        root_b = Path("/synthetic/root-b")
        sets = [
            {
                "eligible_ids": {"a", "b"},
                "denominator_ids": {"a", "b", "excluded-a"},
                "bound_roots": {root_a},
            },
            {
                "eligible_ids": {"c", "d"},
                "denominator_ids": {"c", "d"},
                "bound_roots": {root_b},
            },
        ]
        package._validate_tokenizer_evidence_union(
            sets,
            audited_sample_ids={"a", "b", "c", "d"},
            strict_sample_ids={"b", "d"},
            result_roots=[root_a, root_b],
        )
        overlapping = [dict(sets[0]), dict(sets[1])]
        overlapping[1]["eligible_ids"] = {"b", "c", "d"}
        with self.assertRaisesRegex(package.PackageError, "eligible-ID sets overlap"):
            package._validate_tokenizer_evidence_union(
                overlapping,
                audited_sample_ids={"a", "b", "c", "d"},
                strict_sample_ids={"b", "d"},
                result_roots=[root_a, root_b],
            )
        with self.assertRaisesRegex(package.PackageError, "does not exactly equal audited IDs"):
            package._validate_tokenizer_evidence_union(
                sets,
                audited_sample_ids={"a", "b", "c", "d", "missing"},
                strict_sample_ids={"b", "d"},
                result_roots=[root_a, root_b],
            )

    def test_registered_tokenizer_layouts_support_balanced_waves_fail_closed(self) -> None:
        initial = _tokenizer_role(package.INITIAL_SOURCE_SCHEMA)
        supplemental = _tokenizer_role(package.SUPPLEMENTAL_SOURCE_SCHEMA)
        wave_1 = _tokenizer_role(
            package.BALANCED_SOURCE_SCHEMA, wave_id="balanced_wave_1"
        )
        wave_2 = _tokenizer_role(
            package.BALANCED_SOURCE_SCHEMA, wave_id="balanced_wave_2"
        )
        wave_3 = _tokenizer_role(
            package.BALANCED_EXTENSION_SOURCE_SCHEMA, wave_id="balanced_wave_3"
        )
        wave_4 = _tokenizer_role(
            package.BALANCED_EXTENSION2_SOURCE_SCHEMA, wave_id="balanced_wave_4"
        )
        wave_5 = _tokenizer_role(
            package.BALANCED_EXTENSION2_SOURCE_SCHEMA, wave_id="balanced_wave_5"
        )
        self.assertEqual(
            package._classify_tokenizer_evidence_sets([initial])["balanced"], []
        )
        self.assertIsNotNone(
            package._classify_tokenizer_evidence_sets([initial, supplemental])[
                "supplemental"
            ]
        )
        self.assertEqual(
            len(
                package._classify_tokenizer_evidence_sets(
                    [initial, supplemental, wave_1]
                )["balanced"]
            ),
            1,
        )
        self.assertEqual(
            len(
                package._classify_tokenizer_evidence_sets(
                    [wave_2, supplemental, initial, wave_1]
                )["balanced"]
            ),
            2,
        )
        self.assertIs(
            package._classify_tokenizer_evidence_sets(
                [wave_3, wave_2, supplemental, initial, wave_1]
            )["extension"],
            wave_3,
        )
        self.assertEqual(
            package._classify_tokenizer_evidence_sets(
                [initial, supplemental, wave_1, wave_2, wave_3, wave_4]
            )["extension2"],
            [wave_4],
        )
        self.assertEqual(
            package._classify_tokenizer_evidence_sets(
                [wave_5, wave_3, wave_2, supplemental, initial, wave_4, wave_1]
            )["extension2"],
            [wave_4, wave_5],
        )
        with self.assertRaisesRegex(package.PackageError, "contiguous Wave 1"):
            package._classify_tokenizer_evidence_sets(
                [initial, supplemental, wave_2]
            )
        with self.assertRaisesRegex(package.PackageError, "contiguous Wave 1"):
            package._classify_tokenizer_evidence_sets(
                [initial, supplemental, wave_1, wave_1]
            )
        unknown = _tokenizer_role("unregistered-schema")
        with self.assertRaisesRegex(package.PackageError, "Unregistered"):
            package._classify_tokenizer_evidence_sets([unknown])
        with self.assertRaisesRegex(package.PackageError, "layout|one to seven"):
            package._classify_tokenizer_evidence_sets(
                [initial, supplemental, wave_1, wave_2, wave_3, wave_3]
            )
        with self.assertRaisesRegex(package.PackageError, "contiguous Wave 4"):
            package._classify_tokenizer_evidence_sets(
                [initial, supplemental, wave_1, wave_2, wave_3, wave_5]
            )
        duplicate_wave_4 = _tokenizer_role(
            package.BALANCED_EXTENSION2_SOURCE_SCHEMA, wave_id="balanced_wave_4"
        )
        with self.assertRaises(package.PackageError):
            package._classify_tokenizer_evidence_sets(
                [
                    initial,
                    supplemental,
                    wave_1,
                    wave_2,
                    wave_3,
                    wave_4,
                    duplicate_wave_4,
                ]
            )
        wave_6 = _tokenizer_role(
            package.BALANCED_EXTENSION2_SOURCE_SCHEMA, wave_id="balanced_wave_6"
        )
        with self.assertRaisesRegex(package.PackageError, "contiguous Wave 4"):
            package._classify_tokenizer_evidence_sets(
                [initial, supplemental, wave_1, wave_2, wave_3, wave_4, wave_6]
            )

    def test_balanced_frozen_waves_bind_exact_plans_and_runner_provenance(self) -> None:
        initial = _tokenizer_role(package.INITIAL_SOURCE_SCHEMA)
        supplemental = _tokenizer_role(package.SUPPLEMENTAL_SOURCE_SCHEMA)
        with tempfile.TemporaryDirectory(dir=HERE) as raw_temp:
            root = Path(raw_temp)
            wave_1 = _build_balanced_evidence(root, 1)
            wave_2 = _build_balanced_evidence(root, 2)
            one_wave = package._validate_balanced_contingency(
                [initial, supplemental, wave_1],
                balanced_root=HERE / "balanced_contingency",
            )
            self.assertEqual(one_wave["balanced_case_count"], 38)
            self.assertEqual(one_wave["waves"][0]["samples_per_shard"], [10, 10, 9, 9])
            self.assertTrue(
                one_wave["execution_disclosure"][
                    "actual_interim_aggregate_look_occurred"
                ]
            )
            self.assertFalse(
                one_wave["execution_disclosure"]["current_wave_action_changed"]
            )
            summary = package._summary_markdown(
                {
                    "validation": {
                        "candidate_count": 0,
                        "complete_valid_candidate_count": 0,
                    },
                    "selection": {
                        "strict_eligible_count": 0,
                        "unique_problem_eligible_count": 0,
                    },
                },
                [],
                {
                    "counts": {
                        "exploded_denominator_records": 0,
                        "excluded_records": 0,
                    }
                },
                balanced_disclosure=one_wave,
            )
            self.assertIn("aggregate interim look did occur", summary)
            self.assertIn("complete valid post-Wave-2 audit below ten", summary)
            self.assertNotIn("never permits an interim look", summary)
            two_waves = package._validate_balanced_contingency(
                [wave_2, supplemental, initial, wave_1],
                balanced_root=HERE / "balanced_contingency",
            )
            self.assertEqual(two_waves["balanced_case_count"], 76)
            self.assertEqual(
                two_waves["freeze_manifest_sha256"],
                package.BALANCED_FREEZE_MANIFEST_SHA256,
            )

            repartitioned = dict(wave_1)
            repartitioned["root_sample_ids"] = {
                path: set(values)
                for path, values in wave_1["root_sample_ids"].items()
            }
            first_root, second_root = sorted(repartitioned["root_sample_ids"])[:2]
            first_id = sorted(repartitioned["root_sample_ids"][first_root])[0]
            second_id = sorted(repartitioned["root_sample_ids"][second_root])[0]
            repartitioned["root_sample_ids"][first_root].remove(first_id)
            repartitioned["root_sample_ids"][first_root].add(second_id)
            repartitioned["root_sample_ids"][second_root].remove(second_id)
            repartitioned["root_sample_ids"][second_root].add(first_id)
            with self.assertRaisesRegex(package.PackageError, "frozen shards"):
                package._validate_balanced_contingency(
                    [initial, supplemental, repartitioned],
                    balanced_root=HERE / "balanced_contingency",
                )

            tampered_root = sorted(wave_1["bound_roots"])[0]
            environment_path = tampered_root / "environment.json"
            environment = json.loads(environment_path.read_text(encoding="utf-8"))
            environment["runner_sha256"] = "f" * 64
            _write_json(environment_path, environment)
            with self.assertRaisesRegex(package.PackageError, "runner hash/provenance"):
                package._validate_balanced_contingency(
                    [initial, supplemental, wave_1],
                    balanced_root=HERE / "balanced_contingency",
                )

    def test_balanced_freeze_digest_is_hard_pinned(self) -> None:
        with mock.patch.object(
            package, "BALANCED_FREEZE_MANIFEST_SHA256", "0" * 64
        ):
            with self.assertRaisesRegex(package.PackageError, "immutable SHA256"):
                package._validate_balanced_freeze(HERE / "balanced_contingency")

    def test_balanced_execution_disclosure_is_fail_closed(self) -> None:
        real = json.loads(
            (HERE / package.BALANCED_EXECUTION_DISCLOSURE).read_text(
                encoding="utf-8"
            )
        )
        validated = package._validate_balanced_execution_disclosure(HERE)
        self.assertTrue(validated["outside_prelaunch_freeze"])
        self.assertEqual(
            validated["schema_version"],
            package.BALANCED_EXECUTION_DISCLOSURE_SCHEMA,
        )
        mutations = [
            ("schema_version", "wrong-schema"),
            ("registered_protocol_interim_looks_allowed", True),
            ("actual_interim_aggregate_look_occurred", False),
            ("current_wave_action_changed", True),
            ("current_wave_cases_changed", True),
            ("current_wave_trials_or_conditions_changed", True),
            ("current_wave_stopped_early", True),
            ("wave_2_trigger_policy_changed", True),
            ("wave_2_decision_requires_complete_valid_post_wave_1_audit", False),
            ("adaptive_extension_motivated_in_part_by_interim_aggregate_look", False),
            ("adaptive_extension_case_ranking_uses_model_outcomes", True),
            (
                "adaptive_extension_launch_requires_complete_valid_post_wave_2_audit_below_ten",
                False,
            ),
            ("excluded_path_rebase_attempt_result_contents_inspected", True),
            ("pass_at_k_displayed", True),
            ("content_not_inspected_for_the_interim_look", []),
            ("disclosure", "An interim look happened."),
        ]
        with tempfile.TemporaryDirectory(dir=HERE) as raw_temp:
            work_root = Path(raw_temp)
            for field, value in mutations:
                payload = json.loads(json.dumps(real))
                payload[field] = value
                _write_json(
                    work_root / package.BALANCED_EXECUTION_DISCLOSURE,
                    payload,
                )
                with self.subTest(field=field), self.assertRaises(
                    package.PackageError
                ):
                    package._validate_balanced_execution_disclosure(work_root)

    def test_balanced_trigger_sequence_is_reconstructed_fail_closed(self) -> None:
        def candidates(ids: list[str]) -> list[dict]:
            return [
                {
                    "sample_id": sample_id,
                    "strict_eligible": True,
                    "canonical_problem_identity": f"dataset:row-{index:06d}",
                }
                for index, sample_id in enumerate(ids, 1)
            ]

        base_ids = {f"base-{index}" for index in range(1, 6)}
        wave_1_ids = {f"wave1-{index}" for index in range(1, 6)}
        initial = _tokenizer_role(
            package.INITIAL_SOURCE_SCHEMA, eligible_ids=set(list(base_ids)[:2])
        )
        supplemental = _tokenizer_role(
            package.SUPPLEMENTAL_SOURCE_SCHEMA,
            eligible_ids=base_ids - initial["eligible_ids"],
        )
        wave_1 = _tokenizer_role(
            package.BALANCED_SOURCE_SCHEMA,
            wave_id="balanced_wave_1",
            eligible_ids=wave_1_ids,
        )
        disclosure: dict = {}
        package._validate_balanced_trigger_sequence(
            {"candidates": candidates(sorted(base_ids | wave_1_ids))},
            [initial, supplemental, wave_1],
            disclosure,
        )
        self.assertEqual(
            disclosure["trigger_audit"]["pre_wave_1_strict_canonical_problem_count"],
            5,
        )
        self.assertEqual(
            disclosure["trigger_audit"]["post_wave_1_strict_canonical_problem_count"],
            10,
        )
        wave_2 = _tokenizer_role(
            package.BALANCED_SOURCE_SCHEMA,
            wave_id="balanced_wave_2",
            eligible_ids={"wave2-1"},
        )
        with self.assertRaisesRegex(package.PackageError, "Wave 2 was not triggered"):
            package._validate_balanced_trigger_sequence(
                {
                    "candidates": candidates(
                        sorted(base_ids | wave_1_ids | wave_2["eligible_ids"])
                    )
                },
                [initial, supplemental, wave_1, wave_2],
                {},
            )

        small_base = {"base-a", "base-b", "base-c"}
        small_initial = _tokenizer_role(
            package.INITIAL_SOURCE_SCHEMA, eligible_ids={"base-a"}
        )
        small_supplemental = _tokenizer_role(
            package.SUPPLEMENTAL_SOURCE_SCHEMA,
            eligible_ids=small_base - {"base-a"},
        )
        small_wave_1 = _tokenizer_role(
            package.BALANCED_SOURCE_SCHEMA,
            wave_id="balanced_wave_1",
            eligible_ids={"wave1-a", "wave1-b", "wave1-c"},
        )
        small_wave_2 = _tokenizer_role(
            package.BALANCED_SOURCE_SCHEMA,
            wave_id="balanced_wave_2",
            eligible_ids={"wave2-a"},
        )
        two_wave_disclosure: dict = {}
        package._validate_balanced_trigger_sequence(
            {
                "candidates": candidates(
                    sorted(
                        small_base
                        | small_wave_1["eligible_ids"]
                        | small_wave_2["eligible_ids"]
                    )
                )
            },
            [small_initial, small_supplemental, small_wave_1, small_wave_2],
            two_wave_disclosure,
        )
        self.assertTrue(two_wave_disclosure["trigger_audit"]["wave_2_included"])

        too_few_wave_1_ids = {"wave1-only"}
        too_few_wave_1 = _tokenizer_role(
            package.BALANCED_SOURCE_SCHEMA,
            wave_id="balanced_wave_1",
            eligible_ids=too_few_wave_1_ids,
        )
        with self.assertRaisesRegex(package.PackageError, "Wave 2 is required"):
            package._validate_balanced_trigger_sequence(
                {"candidates": candidates(sorted(base_ids | too_few_wave_1_ids))},
                [initial, supplemental, too_few_wave_1],
                {},
            )

        ten_base = {f"base-{index}" for index in range(1, 11)}
        initial_ten = _tokenizer_role(
            package.INITIAL_SOURCE_SCHEMA, eligible_ids=ten_base
        )
        with self.assertRaisesRegex(package.PackageError, "Wave 1 was not triggered"):
            package._validate_balanced_trigger_sequence(
                {"candidates": candidates(sorted(ten_base | wave_1_ids))},
                [initial_ten, supplemental, wave_1],
                {},
            )

    def test_complete_balanced_tree_and_frozen_controls_are_copied(self) -> None:
        freeze, inventory, _ = package._validate_balanced_freeze(
            HERE / "balanced_contingency"
        )
        execution = package._validate_balanced_execution_disclosure(HERE)
        disclosure = {
            "control_files": freeze["control_files"],
            "execution_disclosure": execution,
        }
        with tempfile.TemporaryDirectory(dir=HERE) as raw_temp:
            destination = Path(raw_temp) / "screened_pool"
            package._copy_balanced_contingency_evidence(
                balanced_root=HERE / "balanced_contingency",
                destination=destination,
                disclosure=disclosure,
            )
            copied_root = destination / "balanced_contingency"
            self.assertEqual(
                package._sha256_file(copied_root / "freeze_manifest.json"),
                package.BALANCED_FREEZE_MANIFEST_SHA256,
            )
            for relative, row in inventory.items():
                copied = copied_root / relative
                self.assertEqual(copied.stat().st_size, row["bytes"])
                self.assertEqual(package._sha256_file(copied), row["sha256"])
            for row in freeze["control_files"]:
                copied = (
                    destination
                    / "balanced_contingency_control_files"
                    / row["path"]
                )
                self.assertEqual(package._sha256_file(copied), row["sha256"])
            copied_execution = (
                destination
                / "balanced_execution_evidence"
                / package.BALANCED_EXECUTION_DISCLOSURE
            )
            self.assertEqual(
                package._sha256_file(copied_execution), execution["sha256"]
            )

    def test_adaptive_wave3_freeze_plan_disclosure_and_copy_are_exact(self) -> None:
        initial = _tokenizer_role(package.INITIAL_SOURCE_SCHEMA)
        supplemental = _tokenizer_role(package.SUPPLEMENTAL_SOURCE_SCHEMA)
        wave_1 = _tokenizer_role(
            package.BALANCED_SOURCE_SCHEMA, wave_id="balanced_wave_1"
        )
        wave_2 = _tokenizer_role(
            package.BALANCED_SOURCE_SCHEMA, wave_id="balanced_wave_2"
        )
        with tempfile.TemporaryDirectory(dir=HERE) as raw_temp:
            result_work_root = Path(raw_temp)
            wave_3 = _build_balanced_extension_evidence(result_work_root)
            disclosure = package._validate_balanced_extension_contingency(
                [wave_3, wave_2, supplemental, initial, wave_1],
                extension_root=HERE / "balanced_extension_contingency",
                result_work_root=result_work_root,
                root_metadata=wave_3["root_metadata"],
            )
            self.assertIsNotNone(disclosure)
            assert disclosure is not None
            self.assertTrue(disclosure["adaptive"])
            self.assertFalse(disclosure["preregistered"])
            self.assertFalse(disclosure["outcome_blind_in_timing"])
            self.assertTrue(disclosure["case_ranking_outcome_independent"])
            self.assertEqual(disclosure["wave_3_case_count"], 114)
            self.assertEqual(disclosure["wave"]["samples_per_shard"], [29, 29, 28, 28])
            self.assertEqual(
                disclosure["adaptive_disclosure_sha256"],
                package.BALANCED_ADAPTIVE_DISCLOSURE_SHA256,
            )
            disclosure["trigger_audit"] = {
                "post_wave_2_strict_unique_canonical_problem_count": 4
            }
            summary = package._summary_markdown(
                {
                    "validation": {
                        "candidate_count": 0,
                        "complete_valid_candidate_count": 0,
                    },
                    "selection": {
                        "strict_eligible_count": 0,
                        "unique_problem_eligible_count": 0,
                    },
                },
                [],
                {"counts": {"exploded_denominator_records": 0, "excluded_records": 0}},
                balanced_extension_disclosure=disclosure,
            )
            self.assertIn("not preregistered", summary)
            self.assertIn("not outcome-blind in timing", summary)
            self.assertNotIn("pass@", summary.lower())

            destination = result_work_root / "copied_screened_pool"
            package._copy_balanced_extension_evidence(
                extension_root=HERE / "balanced_extension_contingency",
                destination=destination,
                disclosure=disclosure,
            )
            copied_root = destination / "balanced_extension_contingency"
            self.assertEqual(
                package._sha256_file(copied_root / "freeze_manifest.json"),
                package.BALANCED_EXTENSION_FREEZE_MANIFEST_SHA256,
            )
            self.assertEqual(
                package._sha256_file(
                    destination / package.BALANCED_EXTENSION_EXTERNAL_ANCHOR.name
                ),
                disclosure["external_freeze_anchor_sha256"],
            )
            copied_adaptive = (
                destination
                / "balanced_extension_execution_evidence"
                / package.BALANCED_EXECUTION_DISCLOSURE
            )
            self.assertEqual(
                package._sha256_file(copied_adaptive),
                package.BALANCED_ADAPTIVE_DISCLOSURE_SHA256,
            )

    def test_adaptive_wave3_missing_or_tampered_frozen_evidence_fails_closed(self) -> None:
        root = HERE / "balanced_extension_contingency"
        freeze, _, protocol_payload = package._validate_balanced_extension_freeze(root)
        self.assertEqual(freeze["schema_version"], package.BALANCED_EXTENSION_FREEZE_SCHEMA)
        self.assertFalse(protocol_payload["status"]["outcome_blind_in_timing"])

        with mock.patch.object(
            package, "BALANCED_EXTENSION_FREEZE_MANIFEST_SHA256", "0" * 64
        ):
            with self.assertRaisesRegex(package.PackageError, "immutable SHA256"):
                package._validate_balanced_extension_freeze(root)
        with mock.patch.object(
            package,
            "BALANCED_EXTENSION_EXTERNAL_ANCHOR",
            HERE / "missing-balanced-extension-anchor.sha256",
        ):
            with self.assertRaisesRegex(package.PackageError, "external freeze anchor"):
                package._validate_balanced_extension_freeze(root)
        with mock.patch.object(package, "BALANCED_EXTENSION_PROTOCOL_SHA256", "0" * 64):
            with self.assertRaisesRegex(package.PackageError, "protocol differs"):
                package._validate_balanced_extension_freeze(root)

        layout = [
            _tokenizer_role(package.INITIAL_SOURCE_SCHEMA),
            _tokenizer_role(package.SUPPLEMENTAL_SOURCE_SCHEMA),
            _tokenizer_role(
                package.BALANCED_SOURCE_SCHEMA, wave_id="balanced_wave_1"
            ),
            _tokenizer_role(
                package.BALANCED_SOURCE_SCHEMA, wave_id="balanced_wave_2"
            ),
            _tokenizer_role(
                package.BALANCED_EXTENSION_SOURCE_SCHEMA,
                wave_id="balanced_wave_3",
            ),
        ]
        with mock.patch.object(
            package,
            "_validate_balanced_execution_disclosure",
            return_value={"sha256": "0" * 64},
        ):
            with self.assertRaisesRegex(package.PackageError, "Adaptive execution disclosure"):
                package._validate_balanced_extension_contingency(
                    layout,
                    extension_root=root,
                )

    def test_adaptive_wave3_tampered_plan_and_path_rebase_fail_closed(self) -> None:
        initial = _tokenizer_role(package.INITIAL_SOURCE_SCHEMA)
        supplemental = _tokenizer_role(package.SUPPLEMENTAL_SOURCE_SCHEMA)
        wave_1 = _tokenizer_role(
            package.BALANCED_SOURCE_SCHEMA, wave_id="balanced_wave_1"
        )
        wave_2 = _tokenizer_role(
            package.BALANCED_SOURCE_SCHEMA, wave_id="balanced_wave_2"
        )
        with tempfile.TemporaryDirectory(dir=HERE) as raw_temp:
            result_work_root = Path(raw_temp)
            valid = _build_balanced_extension_evidence(result_work_root)
            with mock.patch.object(
                package, "BALANCED_EXTENSION_LAUNCH_PLAN_SHA256", "0" * 64
            ):
                with self.assertRaisesRegex(package.PackageError, "manifest/plan hash"):
                    package._validate_balanced_extension_contingency(
                        [initial, supplemental, wave_1, wave_2, valid],
                        extension_root=HERE / "balanced_extension_contingency",
                        result_work_root=result_work_root,
                        root_metadata=valid["root_metadata"],
                    )

            rebased = _build_balanced_extension_evidence(
                result_work_root, path_rebased=True
            )
            with self.assertRaisesRegex(package.PackageError, "path-rebased"):
                package._validate_balanced_extension_contingency(
                    [initial, supplemental, wave_1, wave_2, rebased],
                    extension_root=HERE / "balanced_extension_contingency",
                    result_work_root=result_work_root,
                    root_metadata=rebased["root_metadata"],
                )

    def test_adaptive_wave3_trigger_requires_complete_post_wave2_count_below_ten(self) -> None:
        initial = _tokenizer_role(
            package.INITIAL_SOURCE_SCHEMA, eligible_ids={"base-1", "base-2"}
        )
        supplemental = _tokenizer_role(
            package.SUPPLEMENTAL_SOURCE_SCHEMA, eligible_ids={"base-3"}
        )
        wave_1 = _tokenizer_role(
            package.BALANCED_SOURCE_SCHEMA,
            wave_id="balanced_wave_1",
            eligible_ids={"wave1-1", "wave1-2", "wave1-3"},
        )
        wave_2 = _tokenizer_role(
            package.BALANCED_SOURCE_SCHEMA,
            wave_id="balanced_wave_2",
            eligible_ids={"wave2-1", "wave2-2", "wave2-3"},
        )
        wave_3 = _tokenizer_role(
            package.BALANCED_EXTENSION_SOURCE_SCHEMA,
            wave_id="balanced_wave_3",
            eligible_ids={"wave3-1"},
        )
        prior_ids = set().union(
            initial["eligible_ids"],
            supplemental["eligible_ids"],
            wave_1["eligible_ids"],
            wave_2["eligible_ids"],
        )

        def candidate(sample_id: str, index: int, *, complete: bool = True) -> dict:
            return {
                "sample_id": sample_id,
                "complete_and_valid": complete,
                "strict_eligible": sample_id in prior_ids,
                "canonical_problem_identity": f"dataset:row-{index:06d}",
            }

        candidates = [
            candidate(sample_id, index)
            for index, sample_id in enumerate(sorted(prior_ids | {"wave3-1"}), 1)
        ]
        disclosure: dict = {}
        layout = [initial, supplemental, wave_1, wave_2, wave_3]
        package._validate_balanced_extension_trigger(
            {"candidates": candidates}, layout, disclosure
        )
        self.assertEqual(
            disclosure["trigger_audit"][
                "post_wave_2_strict_unique_canonical_problem_count"
            ],
            9,
        )
        self.assertTrue(disclosure["trigger_audit"]["wave_3_trigger_satisfied"])

        tenth = _tokenizer_role(
            package.SUPPLEMENTAL_SOURCE_SCHEMA,
            eligible_ids={"base-3", "base-10"},
        )
        tenth_candidate = candidate("base-10", 10)
        tenth_candidate["strict_eligible"] = True
        tenth_candidates = candidates + [tenth_candidate]
        with self.assertRaisesRegex(package.PackageError, "count reached ten"):
            package._validate_balanced_extension_trigger(
                {"candidates": tenth_candidates},
                [initial, tenth, wave_1, wave_2, wave_3],
                {},
            )

        incomplete = json.loads(json.dumps(candidates))
        incomplete[0]["complete_and_valid"] = False
        with self.assertRaisesRegex(package.PackageError, "complete valid post-Wave-2"):
            package._validate_balanced_extension_trigger(
                {"candidates": incomplete}, layout, {}
            )

    def test_adaptive_wave3_requires_exactly_ten_distinct_manual_strict_cases(self) -> None:
        review = {
            "entry_count": 10,
            "all_entries_strict_complete": True,
            "sha256": "a" * 64,
            "entries": [
                {
                    "sample_id": f"sample-{index}",
                    "canonical_problem_identity": f"dataset:row-{index:06d}",
                }
                for index in range(1, 11)
            ],
        }
        disclosure: dict = {}
        package._require_balanced_extension_manual_review(disclosure, review)
        self.assertEqual(
            disclosure["manual_trace_review"][
                "distinct_canonical_strict_case_count"
            ],
            10,
        )
        with self.assertRaisesRegex(package.PackageError, "exactly ten distinct"):
            package._require_balanced_extension_manual_review({}, None)
        duplicated = json.loads(json.dumps(review))
        duplicated["entries"][1]["canonical_problem_identity"] = duplicated["entries"][0][
            "canonical_problem_identity"
        ]
        with self.assertRaisesRegex(package.PackageError, "exactly ten distinct"):
            package._require_balanced_extension_manual_review({}, duplicated)

    def test_extension2_freeze_failures_and_external_disclosures_are_exact(self) -> None:
        root = HERE / "balanced_extension2_contingency"
        freeze, inventory, protocol_payload, failures = (
            package._validate_balanced_extension2_freeze(root)
        )
        self.assertEqual(
            freeze["schema_version"], package.BALANCED_EXTENSION2_FREEZE_SCHEMA
        )
        self.assertEqual(len(inventory), 3362)
        self.assertEqual(len(freeze["control_files"]), 20)
        self.assertFalse(protocol_payload["status"]["outcome_blind_in_timing"])
        self.assertEqual(
            [(row["missing_rank"], row["evidence_file_count"]) for row in failures],
            [(25, 641), (20, 1071)],
        )
        listing = package._validate_balanced_extension2_packaging_disclosure(HERE)
        self.assertTrue(listing["result_path_names_listed"])
        self.assertFalse(listing["result_file_contents_read"])
        self.assertFalse(listing["result_progress_inspected"])
        refinement = package._validate_balanced_extension2_refinement_disclosure(HERE)
        self.assertEqual(
            refinement["observed_complete_wave_3_paired_audit"][
                "paired_eligible_distinct_sample_id_count"
            ],
            9,
        )
        self.assertEqual(
            refinement["observed_complete_wave_3_paired_audit"][
                "distinct_canonical_problem_count"
            ],
            4,
        )

        with mock.patch.object(
            package, "BALANCED_EXTENSION2_FREEZE_MANIFEST_SHA256", "0" * 64
        ):
            with self.assertRaisesRegex(package.PackageError, "immutable SHA256"):
                package._validate_balanced_extension2_freeze(root)
        with mock.patch.object(
            package,
            "BALANCED_EXTENSION2_EXTERNAL_ANCHOR",
            HERE / "missing-extension2-anchor.sha256",
        ):
            with self.assertRaisesRegex(package.PackageError, "external freeze anchor"):
                package._validate_balanced_extension2_freeze(root)
        with mock.patch.object(
            package, "BALANCED_EXTENSION2_PACKAGING_DISCLOSURE_SHA256", "0" * 64
        ):
            with self.assertRaisesRegex(package.PackageError, "registered SHA256"):
                package._validate_balanced_extension2_packaging_disclosure(HERE)
        with mock.patch.object(
            package, "BALANCED_EXTENSION2_REFINEMENT_DISCLOSURE_SHA256", "0" * 64
        ):
            with self.assertRaisesRegex(package.PackageError, "registered SHA256"):
                package._validate_balanced_extension2_refinement_disclosure(HERE)
        with mock.patch.object(
            package,
            "BALANCED_EXTENSION2_PACKAGING_DISCLOSURE",
            "missing-extension2-packaging-disclosure.json",
        ):
            with self.assertRaisesRegex(package.PackageError, "escapes or is missing"):
                package._validate_balanced_extension2_packaging_disclosure(HERE)
        with mock.patch.object(
            package,
            "BALANCED_EXTENSION2_REFINEMENT_DISCLOSURE",
            "missing-extension2-refinement-disclosure.json",
        ):
            with self.assertRaisesRegex(package.PackageError, "escapes or is missing"):
                package._validate_balanced_extension2_refinement_disclosure(HERE)

        missing_inventory = dict(inventory)
        missing_path = next(
            path
            for path in sorted(missing_inventory)
            if path.startswith("rank25_feasibility_failure/")
        )
        missing_inventory.pop(missing_path)
        with self.assertRaisesRegex(package.PackageError, "absent from the freeze"):
            package._validate_balanced_extension2_failure_archive(
                extension_root=root,
                inventory=missing_inventory,
                missing_rank=25,
            )

    def test_extension2_exact_plans_contiguous_roots_and_copy(self) -> None:
        initial = _tokenizer_role(package.INITIAL_SOURCE_SCHEMA)
        supplemental = _tokenizer_role(package.SUPPLEMENTAL_SOURCE_SCHEMA)
        wave_1 = _tokenizer_role(
            package.BALANCED_SOURCE_SCHEMA, wave_id="balanced_wave_1"
        )
        wave_2 = _tokenizer_role(
            package.BALANCED_SOURCE_SCHEMA, wave_id="balanced_wave_2"
        )
        wave_3 = _tokenizer_role(
            package.BALANCED_EXTENSION_SOURCE_SCHEMA, wave_id="balanced_wave_3"
        )
        with tempfile.TemporaryDirectory(dir=HERE) as raw_temp:
            result_work_root = Path(raw_temp)
            wave_4 = _build_balanced_extension2_evidence(result_work_root, 4)
            wave_5 = _build_balanced_extension2_evidence(result_work_root, 5)
            metadata = {**wave_4["root_metadata"], **wave_5["root_metadata"]}
            base = [initial, supplemental, wave_1, wave_2, wave_3]
            disclosure_4 = package._validate_balanced_extension2_contingency(
                base + [wave_4],
                extension_root=HERE / "balanced_extension2_contingency",
                result_work_root=result_work_root,
                root_metadata=metadata,
            )
            self.assertEqual(disclosure_4["included_wave_count"], 1)
            self.assertEqual(
                disclosure_4["waves"][0]["expected_run_records_per_shard"],
                [288, 288, 288, 276],
            )
            disclosure = package._validate_balanced_extension2_contingency(
                base + [wave_4, wave_5],
                extension_root=HERE / "balanced_extension2_contingency",
                result_work_root=result_work_root,
                root_metadata=metadata,
            )
            self.assertEqual(disclosure["included_wave_count"], 2)
            self.assertEqual(
                disclosure["waves"][1]["expected_run_records_per_shard"],
                [228, 228, 228, 228],
            )
            self.assertEqual(disclosure["freeze_generated_file_count"], 3362)
            self.assertEqual(disclosure["freeze_control_file_count"], 20)

            rebased = _build_balanced_extension2_evidence(
                result_work_root, 4, path_rebased=True
            )
            with self.assertRaisesRegex(package.PackageError, "path-rebased"):
                package._validate_balanced_extension2_contingency(
                    base + [rebased],
                    extension_root=HERE / "balanced_extension2_contingency",
                    result_work_root=result_work_root,
                    root_metadata=rebased["root_metadata"],
                )
            with mock.patch.dict(
                package.BALANCED_EXTENSION2_WAVE_SPECS[4],
                {"launch_plan_sha256": "0" * 64},
            ):
                with self.assertRaisesRegex(package.PackageError, "Wave-4 artifact"):
                    package._validate_balanced_extension2_contingency(
                        base + [wave_4],
                        extension_root=HERE / "balanced_extension2_contingency",
                        result_work_root=result_work_root,
                        root_metadata=wave_4["root_metadata"],
                    )

            destination = result_work_root / "copied_screened_pool"
            package._copy_balanced_extension2_evidence(
                extension_root=HERE / "balanced_extension2_contingency",
                destination=destination,
                disclosure=disclosure,
            )
            copied_root = destination / "balanced_extension2_contingency"
            self.assertEqual(
                package._sha256_file(copied_root / "freeze_manifest.json"),
                package.BALANCED_EXTENSION2_FREEZE_MANIFEST_SHA256,
            )
            copied_controls = list(
                (destination / "balanced_extension2_contingency_control_files").glob(
                    "*"
                )
            )
            self.assertEqual(len(copied_controls), 20)
            for name, digest in (
                (
                    package.BALANCED_EXTENSION2_PACKAGING_DISCLOSURE,
                    package.BALANCED_EXTENSION2_PACKAGING_DISCLOSURE_SHA256,
                ),
                (
                    package.BALANCED_EXTENSION2_REFINEMENT_DISCLOSURE,
                    package.BALANCED_EXTENSION2_REFINEMENT_DISCLOSURE_SHA256,
                ),
            ):
                self.assertEqual(
                    package._sha256_file(
                        destination / "balanced_extension2_execution_evidence" / name
                    ),
                    digest,
                )

    def test_extension2_paired_triggers_are_sequential_and_complete(self) -> None:
        post_ids = [f"post-{index}" for index in range(9)]
        initial = _tokenizer_role(
            package.INITIAL_SOURCE_SCHEMA, eligible_ids=set(post_ids[:2])
        )
        supplemental = _tokenizer_role(
            package.SUPPLEMENTAL_SOURCE_SCHEMA, eligible_ids=set(post_ids[2:4])
        )
        wave_1 = _tokenizer_role(
            package.BALANCED_SOURCE_SCHEMA,
            wave_id="balanced_wave_1",
            eligible_ids=set(post_ids[4:6]),
        )
        wave_2 = _tokenizer_role(
            package.BALANCED_SOURCE_SCHEMA,
            wave_id="balanced_wave_2",
            eligible_ids=set(post_ids[6:8]),
        )
        wave_3 = _tokenizer_role(
            package.BALANCED_EXTENSION_SOURCE_SCHEMA,
            wave_id="balanced_wave_3",
            eligible_ids={post_ids[8]},
        )
        wave_4 = _tokenizer_role(
            package.BALANCED_EXTENSION2_SOURCE_SCHEMA,
            wave_id="balanced_wave_4",
            eligible_ids={"wave4-a", "wave4-b"},
        )
        wave_5 = _tokenizer_role(
            package.BALANCED_EXTENSION2_SOURCE_SCHEMA,
            wave_id="balanced_wave_5",
            eligible_ids={"wave5-a"},
        )
        base_layout = [initial, supplemental, wave_1, wave_2, wave_3]
        post_candidates = [
            _paired_candidate(sample_id, canonical_index=(index % 4) + 1)
            for index, sample_id in enumerate(post_ids)
        ]

        def disclosure(observed_count: int = 9, observed_problems: int = 4) -> dict:
            return {
                "paired_trial_protocol_refinement_disclosure": {
                    "observed_complete_wave_3_paired_audit": {
                        "paired_eligible_distinct_sample_id_count": observed_count,
                        "distinct_canonical_problem_count": observed_problems,
                    }
                }
            }

        stop_candidates = post_candidates + [
            _paired_candidate("wave4-a", canonical_index=1),
            _paired_candidate(
                "wave4-b", canonical_index=2, paired_eligible=False
            ),
        ]
        stopped = disclosure()
        package._validate_balanced_extension2_trigger(
            {"validation": {"ok": True}, "candidates": stop_candidates},
            base_layout + [wave_4],
            stopped,
        )
        self.assertTrue(
            stopped["paired_trigger_audit"][
                "wave_5_stopped_because_threshold_reached"
            ]
        )
        self.assertEqual(
            stopped["paired_trigger_audit"][
                "post_wave_4_paired_eligible_distinct_sample_id_count"
            ],
            10,
        )

        continue_candidates = post_candidates + [
            _paired_candidate(
                "wave4-a", canonical_index=1, paired_eligible=False
            ),
            _paired_candidate(
                "wave4-b", canonical_index=2, paired_eligible=False
            ),
            _paired_candidate("wave5-a", canonical_index=3),
        ]
        continued = disclosure()
        package._validate_balanced_extension2_trigger(
            {"validation": {"ok": True}, "candidates": continue_candidates},
            base_layout + [wave_4, wave_5],
            continued,
        )
        self.assertTrue(continued["paired_trigger_audit"]["wave_5_included"])

        with self.assertRaisesRegex(package.PackageError, "Wave 5 is required"):
            package._validate_balanced_extension2_trigger(
                {"validation": {"ok": True}, "candidates": continue_candidates[:-1]},
                base_layout + [wave_4],
                disclosure(),
            )
        with self.assertRaisesRegex(package.PackageError, "Wave 5 was not triggered"):
            package._validate_balanced_extension2_trigger(
                {
                    "validation": {"ok": True},
                    "candidates": stop_candidates
                    + [_paired_candidate("wave5-a", canonical_index=3)],
                },
                base_layout + [wave_4, wave_5],
                disclosure(),
            )
        incomplete_post = json.loads(json.dumps(stop_candidates))
        incomplete_post[0]["complete_and_valid"] = False
        with self.assertRaisesRegex(package.PackageError, "complete valid post-Wave-3"):
            package._validate_balanced_extension2_trigger(
                {"validation": {"ok": True}, "candidates": incomplete_post},
                base_layout + [wave_4],
                disclosure(),
            )
        incomplete_wave4 = json.loads(json.dumps(stop_candidates))
        next(
            row for row in incomplete_wave4 if row["sample_id"] == "wave4-a"
        )["complete_and_valid"] = False
        with self.assertRaisesRegex(package.PackageError, "complete valid Wave-4"):
            package._validate_balanced_extension2_trigger(
                {"validation": {"ok": True}, "candidates": incomplete_wave4},
                base_layout + [wave_4],
                disclosure(),
            )
        incomplete_wave5 = json.loads(json.dumps(continue_candidates))
        next(
            row for row in incomplete_wave5 if row["sample_id"] == "wave5-a"
        )["complete_and_valid"] = False
        with self.assertRaisesRegex(package.PackageError, "complete valid Wave-5"):
            package._validate_balanced_extension2_trigger(
                {"validation": {"ok": True}, "candidates": incomplete_wave5},
                base_layout + [wave_4, wave_5],
                disclosure(),
            )
        ten_ids = post_ids + ["post-9"]
        initial_ten = _tokenizer_role(
            package.INITIAL_SOURCE_SCHEMA,
            eligible_ids=set(post_ids[:2]) | {"post-9"},
        )
        ten_candidates = post_candidates + [
            _paired_candidate("post-9", canonical_index=1),
            _paired_candidate("wave4-a", canonical_index=1),
            _paired_candidate(
                "wave4-b", canonical_index=2, paired_eligible=False
            ),
        ]
        with self.assertRaisesRegex(package.PackageError, "Wave 4 was not triggered"):
            package._validate_balanced_extension2_trigger(
                {"validation": {"ok": True}, "candidates": ten_candidates},
                [initial_ten, supplemental, wave_1, wave_2, wave_3, wave_4],
                disclosure(observed_count=len(ten_ids)),
            )
        with self.assertRaisesRegex(package.PackageError, "hard-pinned refinement"):
            package._validate_balanced_extension2_trigger(
                {"validation": {"ok": True}, "candidates": stop_candidates},
                base_layout + [wave_4],
                {},
            )

    def test_paired_review_accepts_repeats_and_rejects_adversarial_claims(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as raw_temp:
            root = Path(raw_temp)
            audit_json = root / "audit.json"
            candidates_csv = root / "candidates.csv"
            runs_csv = root / "runs.csv"
            audit_json.write_text("{}\n", encoding="utf-8")
            candidates_csv.write_text("sample_id\n", encoding="utf-8")
            runs_csv.write_text("sample_id\n", encoding="utf-8")
            candidates = [
                _paired_candidate(
                    f"paired-{index}",
                    canonical_index=(index % 4) + 1,
                    paired_trial=(index % 3) + 1,
                )
                for index in range(10)
            ]
            report = {
                "candidates": candidates,
                "selection": {
                    "strict_eligible_count": 0,
                    "unique_problem_eligible_count": 0,
                },
                "validation": {
                    "candidate_count": 10,
                    "complete_valid_candidate_count": 10,
                },
            }
            payload = _paired_review_payload(
                candidates,
                audit_json=audit_json,
                audit_candidates_csv=candidates_csv,
                audit_runs_csv=runs_csv,
            )
            review_path = root / "paired_review.json"
            _write_json(review_path, payload)
            validated = package._validate_manual_trace_review(
                review_path,
                report=report,
                audit_json=audit_json,
                audit_candidates_csv=candidates_csv,
                audit_runs_csv=runs_csv,
            )
            self.assertEqual(validated["distinct_sample_id_count"], 10)
            self.assertEqual(validated["distinct_canonical_problem_count"], 4)
            self.assertEqual(validated["canonical_problem_repeat_entry_count"], 6)

            def provenance(candidate: dict, _snapshot: dict) -> tuple[dict, str]:
                fields = candidate["canonical_problem_identity_fields"]
                metadata = {
                    "provenance": {
                        "dataset_id": fields["dataset_id"],
                        "dataset_revision": fields["dataset_revision"],
                        "dataset_file_sha256": fields["dataset_file_sha256"],
                        "split": fields["split"],
                        "row_index": fields["row_index"],
                        "cf_contest_id": fields["cf_contest_id"],
                        "cf_index": fields["cf_index"],
                    }
                }
                return metadata, str(candidate["canonical_problem_identity"])

            with mock.patch.object(
                package,
                "_locate_sample_snapshot",
                return_value=({}, root / "sample.json"),
            ), mock.patch.object(
                package, "_validate_problem_provenance", side_effect=provenance
            ), mock.patch.object(
                package,
                "_validate_codecontests_source_binding",
                return_value=root / "source.java",
            ):
                selected = package._select_cases(
                    report, [], root, {}, validated
                )
            self.assertEqual(len(selected), 10)
            self.assertEqual(
                len({row["canonical_problem_identity"] for row in selected}), 4
            )
            summary = package._summary_markdown(
                report,
                selected,
                {"counts": {"exploded_denominator_records": 10, "excluded_records": 0}},
                manual_review=validated,
            )
            self.assertIn("Actual distinct canonical problems: 4", summary)
            self.assertIn("distinct concrete inputs", summary)
            self.assertNotIn("pass@", summary.lower())

            mismatched = json.loads(json.dumps(payload))
            mismatched["entries"][0]["paired_baseline_trial"] = 2
            _write_json(review_path, mismatched)
            with self.assertRaisesRegex(package.PackageError, "order/trial/seed"):
                package._validate_manual_trace_review(
                    review_path,
                    report=report,
                    audit_json=audit_json,
                    audit_candidates_csv=candidates_csv,
                    audit_runs_csv=runs_csv,
                )
            bad_fingerprint = json.loads(json.dumps(payload))
            bad_fingerprint["entries"][0]["selected_codesteer_fingerprint"] = "f" * 64
            _write_json(review_path, bad_fingerprint)
            with self.assertRaisesRegex(package.PackageError, "CodeSteer run"):
                package._validate_manual_trace_review(
                    review_path,
                    report=report,
                    audit_json=audit_json,
                    audit_candidates_csv=candidates_csv,
                    audit_runs_csv=runs_csv,
                )
            bad_disclosure = json.loads(json.dumps(payload))
            bad_disclosure["canonical_problem_repeats_allowed"] = False
            _write_json(review_path, bad_disclosure)
            with self.assertRaisesRegex(package.PackageError, "schema/disclosure"):
                package._validate_manual_trace_review(
                    review_path,
                    report=report,
                    audit_json=audit_json,
                    audit_candidates_csv=candidates_csv,
                    audit_runs_csv=runs_csv,
                )
            bad_seed = json.loads(json.dumps(payload))
            bad_seed["entries"][0]["paired_seed"] += 1
            _write_json(review_path, bad_seed)
            with self.assertRaisesRegex(package.PackageError, "mismatched seeds"):
                package._validate_manual_trace_review(
                    review_path,
                    report=report,
                    audit_json=audit_json,
                    audit_candidates_csv=candidates_csv,
                    audit_runs_csv=runs_csv,
                )
            duplicate = json.loads(json.dumps(payload))
            duplicate["entries"][1]["sample_id"] = duplicate["entries"][0]["sample_id"]
            _write_json(review_path, duplicate)
            with self.assertRaisesRegex(package.PackageError, "sample IDs must be distinct"):
                package._validate_manual_trace_review(
                    review_path,
                    report=report,
                    audit_json=audit_json,
                    audit_candidates_csv=candidates_csv,
                    audit_runs_csv=runs_csv,
                )
            false_claim = json.loads(json.dumps(payload))
            false_claim["reported_distinct_canonical_problem_count"] = 10
            _write_json(review_path, false_claim)
            with self.assertRaisesRegex(package.PackageError, "false distinct-problem"):
                package._validate_manual_trace_review(
                    review_path,
                    report=report,
                    audit_json=audit_json,
                    audit_candidates_csv=candidates_csv,
                    audit_runs_csv=runs_csv,
                )
            exact_baseline_candidates = json.loads(json.dumps(candidates))
            first = exact_baseline_candidates[0]
            selected_baseline = next(
                run
                for run in first["runs"]
                if run["trial"] == 1
                and run["condition"] == package.BASELINE_CONDITIONS[0]
            )
            selected_baseline["trimmed_exact_match"] = True
            _write_json(review_path, payload)
            with self.assertRaisesRegex(package.PackageError, "order/trial/seed"):
                package._validate_manual_trace_review(
                    review_path,
                    report={"candidates": exact_baseline_candidates},
                    audit_json=audit_json,
                    audit_candidates_csv=candidates_csv,
                    audit_runs_csv=runs_csv,
                )

    def test_supplemental_disclosure_is_preserved_and_fail_closed(self) -> None:
        disclosure = {
            "schema_version": "long-code-supplemental-cases-v2",
            "frozen_source_denominator": 25,
            "supplemental_cases_change_source_denominator": False,
            "selected_supplemental_case_count": 60,
            "outcome_blind_disclosure": (
                "Selected without reading or using any model response, score, or outcome."
            ),
            "timing_disclosure": (
                "Designed after the initial screen started but before that screen completed."
            ),
        }
        result = package._validate_supplemental_disclosure(
            [
                {
                    "source_manifest": {"schema_version": "long-code-obfuscated-variants-v1"},
                    "manifest": {"schema_version": "long-code-obfuscated-variants-v1"},
                },
                {
                    "source_manifest": disclosure,
                    "manifest": {"schema_version": "long-code-supplemental-cases-v2"},
                },
            ]
        )
        self.assertEqual(result["frozen_source_denominator"], 25)
        tampered = json.loads(json.dumps(disclosure))
        tampered["supplemental_cases_change_source_denominator"] = True
        with self.assertRaisesRegex(package.PackageError, "disclosure invalid"):
            package._validate_supplemental_disclosure(
                [
                    {
                        "source_manifest": {
                            "schema_version": "long-code-obfuscated-variants-v1"
                        },
                        "manifest": {
                            "schema_version": "long-code-obfuscated-variants-v1"
                        },
                    },
                    {
                        "source_manifest": tampered,
                        "manifest": {
                            "schema_version": "long-code-supplemental-cases-v2"
                        },
                    },
                ]
            )

    def test_supplemental_plan_runner_must_match_bound_root_provenance(self) -> None:
        plan = json.loads((HERE / "supplemental_launch_plan.json").read_text())
        eligible_ids = {
            sample_id
            for shard in plan["shards"]
            for sample_id in shard["sample_ids"]
        }
        with tempfile.TemporaryDirectory(dir=HERE) as raw_temp:
            root = Path(raw_temp)
            runner_name = (
                "PromptSteering/long-code-sample-work/run_long_code_experiment.py"
            )
            environment = {
                "runner_sha256": plan["runner_sha256_at_planning"],
                "runtime_code_provenance": {
                    "dependency_sha256": {
                        runner_name: plan["runner_sha256_at_planning"]
                    }
                },
            }
            _write_json(root / "environment.json", environment)
            evidence = {
                "source_manifest": {
                    "schema_version": "long-code-supplemental-cases-v2"
                },
                "filtered_manifest_sha256": plan["manifest_sha256"],
                "eligible_ids": eligible_ids,
                "bound_roots": {root},
            }
            result = package._validate_supplemental_launch_plan([evidence])
            self.assertEqual(result["sample_count"], 60)

            environment["runner_sha256"] = "f" * 64
            _write_json(root / "environment.json", environment)
            with self.assertRaisesRegex(package.PackageError, "runner hash/provenance disagree"):
                package._validate_supplemental_launch_plan([evidence])

    def test_path_based_concrete_cases_are_resolved_and_packaged(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as raw_temp:
            root = Path(raw_temp)
            fixture = _build_fixture(root, path_based_cases=True)
            output = root / "path-cases"
            result = _package_fixture(fixture, output)
            self.assertEqual(result["case_count"], 10)
            for case_dir in sorted((output / "cases").glob("case_*")):
                self.assertEqual((case_dir / "stdin.txt").read_text(), "3\n")
                self.assertEqual(
                    (case_dir / "oracle_stdout.txt").read_text(), audit_fixtures.ORACLE
                )

    def test_parent_inline_io_cannot_shadow_path_based_child_case(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as raw_temp:
            root = Path(raw_temp)
            (root / "stdin.txt").write_text("child-input\n", encoding="utf-8")
            (root / "oracle.txt").write_text("child-output\n", encoding="utf-8")
            concrete = {
                "case_id": "child",
                "stdin_path": "stdin.txt",
                "expected_output_path": "oracle.txt",
                "input_sha256": _sha256_text("child-input\n"),
                "raw_expected_stdout_sha256": _sha256_text("child-output\n"),
            }
            evidence = {"source_manifest_path": root / "manifest.json"}
            shadowed = SimpleNamespace(
                sample_id="parent__child",
                stdin="parent-input\n",
                expected_stdout="parent-output\n",
                metadata={
                    "input": "parent-input\n",
                    "expected_stdout": "parent-output\n",
                    "concrete_case": concrete,
                },
            )
            with self.assertRaisesRegex(package.PackageError, "shadowed"):
                package._validate_loaded_sample_case_io(shadowed, evidence)

    def test_real_parquet_binds_exact_java_solution_source(self) -> None:
        rows = package._load_codecontests_rows(package.CODECONTESTS_PARQUET)
        metadata_path = sorted(
            (HERE / "candidate_pool" / "candidates").glob("*/metadata.json")
        )[0]
        metadata = json.loads(metadata_path.read_text(encoding="utf-8"))
        source = package._validate_codecontests_source_binding(
            metadata, HERE / "candidate_pool", rows
        )
        provenance = metadata["provenance"]
        row = rows[int(provenance["row_index"])]
        self.assertEqual(
            source.read_text(encoding="utf-8"),
            row["solutions"]["solution"][int(provenance["solution_index"])],
        )

    def test_repeated_tokenizer_cli_triples_are_retained_in_order(self) -> None:
        args = package.parse_args(
            [
                "--audit-json", "audit.json",
                "--audit-candidates-csv", "candidates.csv",
                "--audit-runs-csv", "runs.csv",
                "--tokenizer-report", "first/report.json",
                "--tokenizer-report", "second/report.json",
                "--tokenizer-exclusions", "first/exclusions.jsonl",
                "--tokenizer-exclusions", "second/exclusions.jsonl",
                "--tokenizer-manifest", "first/manifest.json",
                "--tokenizer-manifest", "second/manifest.json",
                "--tokenizer-set-name", "initial",
                "--tokenizer-set-name", "supplemental",
                "--balanced-extension-contingency-root", "frozen-wave3",
                "--balanced-extension2-contingency-root", "frozen-wave4-wave5",
                "--manual-review", "manual-review.json",
                "result-root",
            ]
        )
        self.assertEqual(args.tokenizer_set_name, ["initial", "supplemental"])
        self.assertEqual(
            args.tokenizer_report,
            [Path("first/report.json"), Path("second/report.json")],
        )
        self.assertEqual(
            args.balanced_extension_contingency_root, Path("frozen-wave3")
        )
        self.assertEqual(
            args.balanced_extension2_contingency_root,
            Path("frozen-wave4-wave5"),
        )
        self.assertEqual(args.manual_review, Path("manual-review.json"))

    def test_path_containment_helper_rejects_escape(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as raw_temp:
            root = Path(raw_temp)
            contained = root / "inside.txt"
            contained.write_text("inside\n", encoding="utf-8")
            self.assertEqual(
                package._resolve_existing_under(contained, root, "test", require_file=True),
                contained.resolve(),
            )
            with self.assertRaisesRegex(package.PackageError, "escapes"):
                package._resolve_existing_under(HERE / "PROTOCOL.md", root, "test", require_file=True)


if __name__ == "__main__":
    unittest.main()
