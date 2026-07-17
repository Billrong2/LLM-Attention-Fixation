from __future__ import annotations

import json
import sys
import tempfile
import unittest
from pathlib import Path


HERE = Path(__file__).resolve().parent
if str(HERE) not in sys.path:
    sys.path.insert(0, str(HERE))

import audit_long_code_results as audit
import run_long_code_experiment as protocol


SOURCE = """public class Demo {
    static int solve(int input) {
        int state = input;
        state = state + 4;
        return state;
    }
    public static void main(String[] args) {
        System.out.println(solve(3));
    }
}
"""
ORACLE = "7\n"
BASE_PROMPT = (
    "Predict stdout for target method solve.\n"
    "### CASES_BEGIN\n"
    'c001: target_method=solve; stdin="3\\n"; argv=[]\n'
    "### CASES_END\n\n"
    f"```java\n{SOURCE}\n```"
)
STRONG_REASONING = (
    "The solve call starts with input 3, so state = 3. Then the assignment updates state "
    "to 7 before the return. The main call receives that value and System.out.print writes it "
    "to stdout, so the console output follows from this intermediate state transition."
)
WEAK_REASONING = "I followed the program and got the answer."


def _steering_payload() -> dict:
    cfg = protocol.build_codesteer_config()
    cfg.model_name = protocol.DEFAULT_MODEL_NAME
    cfg.steer_layer_start = 40
    cfg.steer_layer_end = 47
    return protocol._serializable_steering_config(cfg)


def _write_experiment_config(root: Path, sample_id: str | list[str], trials: int = 3) -> None:
    sample_ids = [sample_id] if isinstance(sample_id, str) else list(sample_id)
    runner_sha256 = "2" * 64
    config_path = root / "experiment_config.json"
    protocol.atomic_write_json(
        config_path,
        {
            "protocol_version": protocol.PROTOCOL_VERSION,
            "manifest_sha256": "manifest-hash",
            "model_name": protocol.DEFAULT_MODEL_NAME,
            "trials": trials,
            "base_seed": 31,
            "sample_ids": sample_ids,
            "conditions": list(protocol.CONDITIONS),
            "generation": protocol.GENERATION_DEFAULTS,
            "static_prior_cache": protocol.STATIC_PRIOR_CACHE_PROFILE,
        },
    )
    protocol.atomic_write_json(
        root / "environment.json",
        {
            "experiment_config_sha256": protocol.sha256_file(config_path),
            "model_snapshot_commit_registered": protocol.MODEL_SNAPSHOT_COMMIT,
            "model_snapshot_commit_cached_ref": protocol.MODEL_SNAPSHOT_COMMIT,
            "model_snapshot_commit_verified": True,
            "runner_sha256": runner_sha256,
            "runtime_code_provenance": {
                "dependency_sha256": {
                    name: (
                        runner_sha256
                        if name == audit.RUNNER_DEPENDENCY_KEY
                        else "0" * 64
                    )
                    for name in (
                        "models.py",
                        "PromptSteering/element_prompting.py",
                        "PromptSteering/prompt.py",
                        "steering/config.py",
                        "steering/runtime.py",
                        "steering/priors.py",
                        "steering/levels.py",
                        "steering/backends/qwen2_backend.py",
                        "PromptSteering/long-code-sample-work/run_long_code_experiment.py",
                    )
                },
                "git_revision": "1" * 40,
                "git_dirty": True,
            },
            "static_prior_cache": {
                **protocol.STATIC_PRIOR_CACHE_PROFILE,
                "installed": True,
                "already_installed": False,
            },
        },
    )
    for value in sample_ids:
        protocol.atomic_write_json(
            root / "samples" / value / "sample.json",
            {
                "sample_id": value,
                "metadata": {
                    "candidate_metadata": {
                        "problem_key": "codeforces-9999-A",
                        "provenance": {
                            **audit.PUBLISHED_DATASET_PROFILE,
                            "row_index": 999,
                            "solution_index": 7,
                            "cf_contest_id": 9999,
                            "cf_index": "A",
                        },
                    }
                },
            },
        )


def _write_run(
    root: Path,
    *,
    sample_id: str,
    trial: int,
    condition: str,
    exact: bool,
    reasoning: str,
    source_code: str = SOURCE,
    use_marker: bool = True,
) -> None:
    run_dir = root / "runs" / sample_id / f"trial_{trial:03d}" / condition
    source_kind = "original" if condition == "original_plain" else "obfuscated"
    guidance = "Prompt-only slice guidance."
    base_prompt = BASE_PROMPT.replace(SOURCE, source_code)
    prompt = (
        guidance + "\n\n" + base_prompt
        if condition == "obfuscated_prompt_slice"
        else base_prompt
    )
    predicted = ORACLE if exact else "8\n"
    completion = reasoning + "\n" + (
        "FINAL_OUTPUT_JSON: " if use_marker else ""
    ) + json.dumps({"stdout": predicted})
    reasoning_artifact = reasoning if use_marker else completion.strip()
    parsed, parse_meta = protocol.parse_final_output(completion)
    assert parsed is not None
    normalized = protocol.normalize_stdout(parsed)
    oracle_normalized = protocol.normalize_stdout(ORACLE)
    score = {
        **parse_meta,
        "predicted_stdout": parsed,
        "predicted_stdout_normalized": normalized,
        "oracle_stdout_normalized": oracle_normalized,
        "exact_match_whitespace_normalized": normalized == oracle_normalized,
        "trimmed_exact_match": normalized == oracle_normalized,
        "reasoning_character_count": len(reasoning_artifact),
    }
    prompt_meta = {
        "enabled": condition == "obfuscated_prompt_slice",
        "mode": "slice" if condition == "obfuscated_prompt_slice" else None,
        "max_elements": 24 if condition == "obfuscated_prompt_slice" else None,
        "emitted_element_count": 12 if condition == "obfuscated_prompt_slice" else 0,
        "eligible_element_count": 18 if condition == "obfuscated_prompt_slice" else 0,
        "target_method": "solve" if condition == "obfuscated_prompt_slice" else None,
        "guidance_text": guidance if condition == "obfuscated_prompt_slice" else None,
    }
    steering = _steering_payload() if condition == audit.CODESTEER_CONDITION else None
    fingerprint_payload = {
        "protocol_version": protocol.PROTOCOL_VERSION,
        "manifest_sha256": "manifest-hash",
        "sample_id": sample_id,
        "original_sha256": protocol._sha256_bytes(source_code.encode()),
        "obfuscated_sha256": protocol._sha256_bytes(source_code.encode()),
        "condition": condition,
        "trial": trial,
        "paired_seed": protocol.paired_seed(31, sample_id, trial),
        "model_name": protocol.DEFAULT_MODEL_NAME,
        "model_snapshot_commit": protocol.MODEL_SNAPSHOT_COMMIT,
        "generation": dict(protocol.GENERATION_DEFAULTS),
        "prompt_sha256": protocol._sha256_bytes(prompt.encode()),
        "steering": steering,
    }
    fingerprint = protocol._run_fingerprint(fingerprint_payload)
    run_config = {
        **fingerprint_payload,
        "fingerprint": fingerprint,
        "source_kind": source_kind,
        "source_path": str(run_dir / "source.java"),
        "target_method": "solve",
        "prompt_metadata": prompt_meta,
        "codesteer_prior_preflight": (
            {
                "algorithm_fallback_detected": False,
                "case_signal_active": True,
                "parsed_case_ids": ["c001"],
            }
            if condition == audit.CODESTEER_CONDITION
            else None
        ),
        "activation_steering": condition == audit.CODESTEER_CONDITION,
    }
    debug = (
        {
            "enabled": True,
            "steer_calls": 20,
            "recency_mix": True,
            "recency_rho": 0.2,
            "recency_window": 64,
            "head_subset_mode": "none",
            "level_call_counts": {
                "l1_calls": 0,
                "l2_calls": 20,
                "l4_calls": 0,
                "l5_calls": 0,
            },
        }
        if condition == audit.CODESTEER_CONDITION
        else {"enabled": False, "steer_calls": 0}
    )
    record = {
        "status": "complete",
        "fingerprint": fingerprint,
        "sample_id": sample_id,
        "trial": trial,
        "condition": condition,
        "paired_seed": fingerprint_payload["paired_seed"],
        "score": score,
    }
    protocol.atomic_write_json(run_dir / "run_config.json", run_config)
    protocol.atomic_write_text(run_dir / "submitted_prompt.txt", prompt)
    protocol.atomic_write_text(run_dir / "raw_completion.txt", completion)
    protocol.atomic_write_text(run_dir / "reasoning.txt", reasoning_artifact)
    protocol.atomic_write_text(run_dir / "source.java", source_code)
    protocol.atomic_write_text(run_dir / "oracle_stdout.txt", ORACLE)
    protocol.atomic_write_json(run_dir / "score.json", score)
    protocol.atomic_write_json(run_dir / "steering_debug.json", debug)
    protocol.atomic_write_json(run_dir / "model_output.json", {"score": score})
    protocol.atomic_write_json(run_dir / "record.json", record)


def _build_complete_root(
    root: Path,
    *,
    sample_id: str = "candidate-01__c001",
    baseline_success: bool = False,
    omit: tuple[int, str] | None = None,
) -> None:
    _write_experiment_config(root, sample_id)
    for trial in range(1, 4):
        for condition in protocol.CONDITIONS:
            if omit == (trial, condition):
                continue
            if condition == audit.CODESTEER_CONDITION:
                exact = trial in {1, 2}
                reasoning = STRONG_REASONING if trial == 2 else WEAK_REASONING
            else:
                exact = baseline_success and condition == "original_plain" and trial == 1
                reasoning = WEAK_REASONING
            _write_run(
                root,
                sample_id=sample_id,
                trial=trial,
                condition=condition,
                exact=exact,
                reasoning=reasoning,
            )


class AuditLongCodeResultsTests(unittest.TestCase):
    def test_static_prior_cache_profile_is_required_in_both_provenance_files(self) -> None:
        for target, expected_error in (
            ("experiment_config.json", "missing static prior cache profile in experiment config"),
            ("environment.json", "missing static prior cache profile in environment"),
        ):
            with self.subTest(target=target), tempfile.TemporaryDirectory(dir=HERE) as temp_raw:
                root = Path(temp_raw)
                _write_experiment_config(root, "cache-required__c001")
                path = root / target
                payload = json.loads(path.read_text(encoding="utf-8"))
                payload.pop("static_prior_cache")
                protocol.atomic_write_json(path, payload)
                if target == "experiment_config.json":
                    environment_path = root / "environment.json"
                    environment = json.loads(environment_path.read_text(encoding="utf-8"))
                    environment["experiment_config_sha256"] = protocol.sha256_file(path)
                    protocol.atomic_write_json(environment_path, environment)

                report = audit.audit_result_roots([root])
                self.assertFalse(report["validation"]["ok"])
                self.assertTrue(
                    any(
                        expected_error in error
                        for error in report["validation"]["global_errors"]
                    )
                )

    def test_static_prior_cache_profile_and_runtime_installation_are_strict(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as temp_raw:
            root = Path(temp_raw)
            _write_experiment_config(root, "cache-profile__c001")
            config_path = root / "experiment_config.json"
            config = json.loads(config_path.read_text(encoding="utf-8"))
            config["static_prior_cache"]["scope"] = "wrong scope"
            protocol.atomic_write_json(config_path, config)

            environment_path = root / "environment.json"
            environment = json.loads(environment_path.read_text(encoding="utf-8"))
            environment["experiment_config_sha256"] = protocol.sha256_file(config_path)
            environment["static_prior_cache"]["enabled"] = False
            environment["static_prior_cache"]["installed"] = False
            environment["static_prior_cache"]["unexpected"] = "not registered"
            protocol.atomic_write_json(environment_path, environment)

            report = audit.audit_result_roots([root])
            errors = report["validation"]["global_errors"]
            self.assertFalse(report["validation"]["ok"])
            self.assertTrue(
                any(
                    "static prior cache profile mismatch for 'scope' in experiment config"
                    in error
                    for error in errors
                )
            )
            self.assertTrue(
                any("static prior cache is not enabled in environment" in error for error in errors)
            )
            self.assertTrue(
                any(
                    "static prior cache was not installed in environment" in error
                    for error in errors
                )
            )
            self.assertTrue(
                any("static prior cache profile has unexpected keys" in error for error in errors)
            )

    def test_runner_sha256_must_match_runtime_dependency_hash(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as temp_raw:
            root = Path(temp_raw)
            _write_experiment_config(root, "runner-hash__c001")
            environment_path = root / "environment.json"
            environment = json.loads(environment_path.read_text(encoding="utf-8"))
            environment["runner_sha256"] = "3" * 64
            protocol.atomic_write_json(environment_path, environment)

            report = audit.audit_result_roots([root])
            self.assertFalse(report["validation"]["ok"])
            self.assertTrue(
                any(
                    "runner SHA256 disagrees with runtime dependency hash" in error
                    for error in report["validation"]["global_errors"]
                )
            )

    def test_codesteer_exact_without_required_final_marker_is_not_eligible(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as temp_raw:
            root = Path(temp_raw)
            sample_id = "candidate-no-marker__c001"
            _write_experiment_config(root, sample_id)
            for trial in range(1, 4):
                for condition in protocol.CONDITIONS:
                    _write_run(
                        root,
                        sample_id=sample_id,
                        trial=trial,
                        condition=condition,
                        exact=condition == audit.CODESTEER_CONDITION and trial == 1,
                        reasoning=STRONG_REASONING,
                        use_marker=not (
                            condition == audit.CODESTEER_CONDITION and trial == 1
                        ),
                    )
            report = audit.audit_result_roots([root])
            self.assertTrue(report["validation"]["ok"])
            candidate = report["candidates"][0]
            self.assertEqual(candidate["exact_counts"]["obfuscated_codesteer"], 1)
            self.assertEqual(candidate["marker_json_exact_codesteer_trials"], [])
            self.assertFalse(candidate["strict_eligible"])

    def test_recorded_preflight_rejection_is_preserved_without_failing_audit(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as temp_raw:
            root = Path(temp_raw)
            sample_id = "fallback-candidate__c001"
            _write_experiment_config(root, sample_id)
            protocol.atomic_write_json(
                root / "preflight_rejections.json",
                {
                    "protocol_version": protocol.PROTOCOL_VERSION,
                    "rejection_count": 1,
                    "rejections": [
                        {
                            "sample_id": sample_id,
                            "reasons": ["algorithm prior equals positional fallback"],
                        }
                    ],
                },
            )
            report = audit.audit_result_roots([root])
            self.assertTrue(report["validation"]["ok"])
            candidate = report["candidates"][0]
            self.assertTrue(candidate["preflight_rejected"])
            self.assertFalse(candidate["complete_and_valid"])
            self.assertFalse(candidate["strict_eligible"])
            self.assertEqual(report["validation"]["preflight_rejected_candidate_count"], 1)

    def test_unique_problem_selection_keeps_duplicate_variants_but_selects_one(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as temp_raw:
            root = Path(temp_raw)
            sample_ids = ["problem-a__variant-1", "problem-a__variant-2"]
            _write_experiment_config(root, sample_ids)
            for sample_id in sample_ids:
                source_code = (
                    SOURCE
                    if sample_id.endswith("variant-1")
                    else SOURCE.replace("state = state + 4", "state = 4 + state")
                )
                for trial in range(1, 4):
                    for condition in protocol.CONDITIONS:
                        _write_run(
                            root,
                            sample_id=sample_id,
                            trial=trial,
                            condition=condition,
                            exact=condition == audit.CODESTEER_CONDITION and trial == 2,
                            reasoning=(
                                STRONG_REASONING
                                if condition == audit.CODESTEER_CONDITION and trial == 2
                                else WEAK_REASONING
                            ),
                            source_code=source_code,
                        )
            report = audit.audit_result_roots([root])
            self.assertTrue(report["validation"]["ok"])
            self.assertEqual(report["selection"]["strict_eligible_count"], 2)
            self.assertEqual(report["selection"]["unique_problem_eligible_count"], 1)
            self.assertEqual(
                len(
                    {
                        run["original_sha256"]
                        for candidate in report["candidates"]
                        for run in candidate["runs"]
                    }
                ),
                2,
            )
            selected = [
                candidate["sample_id"]
                for candidate in report["candidates"]
                if candidate["unique_problem_selected"]
            ]
            self.assertEqual(selected, ["problem-a__variant-1"])
            self.assertEqual(len(report["candidates"]), 2)
            self.assertEqual(
                report["candidates"][0]["canonical_problem_identity"],
                "deepmind/code_contests@802411c3010cb00d1b05bad57ca77365a3c699d6:"
                "valid:row-000999",
            )

    def test_unique_problem_grouping_uses_canonical_dataset_row(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as temp_raw:
            root = Path(temp_raw)
            sample_ids = ["row-999__case", "row-1000__case"]
            _write_experiment_config(root, sample_ids)
            second_snapshot_path = root / "samples" / sample_ids[1] / "sample.json"
            second_snapshot = json.loads(second_snapshot_path.read_text(encoding="utf-8"))
            candidate_metadata = second_snapshot["metadata"]["candidate_metadata"]
            candidate_metadata["problem_key"] = "codeforces-10000-B"
            candidate_metadata["provenance"]["row_index"] = 1000
            candidate_metadata["provenance"]["cf_contest_id"] = 10000
            candidate_metadata["provenance"]["cf_index"] = "B"
            protocol.atomic_write_json(second_snapshot_path, second_snapshot)
            for sample_id in sample_ids:
                for trial in range(1, 4):
                    for condition in protocol.CONDITIONS:
                        _write_run(
                            root,
                            sample_id=sample_id,
                            trial=trial,
                            condition=condition,
                            exact=condition == audit.CODESTEER_CONDITION and trial == 1,
                            reasoning=STRONG_REASONING,
                        )

            report = audit.audit_result_roots([root])
            self.assertTrue(report["validation"]["ok"])
            self.assertEqual(report["selection"]["strict_eligible_count"], 2)
            self.assertEqual(report["selection"]["unique_problem_eligible_count"], 2)
            self.assertEqual(
                {
                    candidate["canonical_problem_identity"]
                    for candidate in report["candidates"]
                },
                {
                    "deepmind/code_contests@802411c3010cb00d1b05bad57ca77365a3c699d6:"
                    "valid:row-000999",
                    "deepmind/code_contests@802411c3010cb00d1b05bad57ca77365a3c699d6:"
                    "valid:row-001000",
                },
            )

    def test_published_dataset_provenance_and_problem_key_are_strict(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as temp_raw:
            root = Path(temp_raw)
            sample_id = "bad-provenance__case"
            _write_experiment_config(root, sample_id)
            snapshot_path = root / "samples" / sample_id / "sample.json"
            snapshot = json.loads(snapshot_path.read_text(encoding="utf-8"))
            candidate_metadata = snapshot["metadata"]["candidate_metadata"]
            candidate_metadata["problem_key"] = "mutable-label"
            candidate_metadata["provenance"]["dataset_revision"] = "moving-main"
            protocol.atomic_write_json(snapshot_path, snapshot)

            report = audit.audit_result_roots([root])
            self.assertFalse(report["validation"]["ok"])
            errors = report["validation"]["global_errors"]
            self.assertTrue(
                any("provenance mismatch for 'dataset_revision'" in error for error in errors)
            )
            self.assertTrue(any("problem key/provenance mismatch" in error for error in errors))

    def test_multiple_roots_merge_into_matched_trials(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as temp_raw:
            parent = Path(temp_raw)
            roots = [parent / "wave-a", parent / "wave-b"]
            sample_id = "candidate-01__c001"
            for root in roots:
                _write_experiment_config(root, sample_id)
            for trial in range(1, 4):
                for condition in protocol.CONDITIONS:
                    target_root = roots[0] if condition in protocol.CONDITIONS[:2] else roots[1]
                    _write_run(
                        target_root,
                        sample_id=sample_id,
                        trial=trial,
                        condition=condition,
                        exact=condition == audit.CODESTEER_CONDITION and trial == 2,
                        reasoning=(
                            STRONG_REASONING
                            if condition == audit.CODESTEER_CONDITION and trial == 2
                            else WEAK_REASONING
                        ),
                    )
            report = audit.audit_result_roots(roots)
            self.assertTrue(report["validation"]["ok"])
            self.assertTrue(report["candidates"][0]["strict_eligible"])
            self.assertEqual(report["candidates"][0]["run_count"], 12)

    def test_strict_eligibility_and_best_trace_ranking(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as temp_raw:
            root = Path(temp_raw)
            _build_complete_root(root)
            report = audit.audit_result_roots([root])
            self.assertTrue(report["validation"]["ok"])
            self.assertEqual(report["selection"]["strict_eligible_count"], 1)
            candidate = report["candidates"][0]
            self.assertTrue(candidate["complete_and_valid"])
            self.assertTrue(candidate["strict_eligible"])
            self.assertEqual(candidate["exact_counts"]["obfuscated_codesteer"], 2)
            self.assertEqual(candidate["best_successful_codesteer_trial"]["trial"], 2)
            ranking = candidate["successful_codesteer_trace_ranking"]
            self.assertGreater(
                ranking[0]["trace_quality"]["score"], ranking[1]["trace_quality"]["score"]
            )
            self.assertFalse(ranking[0]["trace_quality"]["uses_outcome_or_oracle"])
            self.assertTrue(
                ranking[0]["trace_quality"]["heuristic_only_manual_audit_required"]
            )
            self.assertIn("assignment", ranking[0]["trace_quality"]["intermediate_state_evidence"])

    def test_any_baseline_success_makes_candidate_ineligible(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as temp_raw:
            root = Path(temp_raw)
            _build_complete_root(root, baseline_success=True)
            report = audit.audit_result_roots([root])
            self.assertTrue(report["validation"]["ok"])
            candidate = report["candidates"][0]
            self.assertFalse(candidate["strict_eligible"])
            self.assertEqual(candidate["exact_counts"]["original_plain"], 1)

    def test_missing_condition_fails_matched_completeness(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as temp_raw:
            root = Path(temp_raw)
            _build_complete_root(root, omit=(3, "obfuscated_prompt_slice"))
            report = audit.audit_result_roots([root])
            self.assertFalse(report["validation"]["ok"])
            candidate = report["candidates"][0]
            self.assertFalse(candidate["complete_and_valid"])
            self.assertFalse(candidate["strict_eligible"])
            self.assertTrue(any("condition mismatch" in error for error in candidate["validation_errors"]))

    def test_fingerprint_corruption_is_detected(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as temp_raw:
            root = Path(temp_raw)
            _build_complete_root(root)
            path = (
                root
                / "runs"
                / "candidate-01__c001"
                / "trial_001"
                / "original_plain"
                / "run_config.json"
            )
            payload = json.loads(path.read_text(encoding="utf-8"))
            payload["paired_seed"] += 1
            protocol.atomic_write_json(path, payload)
            report = audit.audit_result_roots([root])
            self.assertFalse(report["validation"]["ok"])
            candidate = report["candidates"][0]
            self.assertTrue(any("fingerprint" in error for error in candidate["validation_errors"]))

    def test_reports_preserve_all_candidates_as_json_and_csv(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as results_raw:
            root = Path(results_raw)
            _build_complete_root(root, baseline_success=True)
            report = audit.audit_result_roots([root])
            with tempfile.TemporaryDirectory(dir=HERE) as output_raw:
                paths = audit.write_reports(report, Path(output_raw))
                for path in paths.values():
                    self.assertTrue(Path(path).is_file())
                    self.assertIn(str(HERE), str(Path(path).resolve()))
                candidates_csv = Path(paths["candidates_csv"]).read_text(encoding="utf-8")
                runs_csv = Path(paths["runs_csv"]).read_text(encoding="utf-8")
                self.assertIn("candidate-01__c001", candidates_csv)
                self.assertEqual(len(runs_csv.splitlines()), 13)


if __name__ == "__main__":
    unittest.main()
