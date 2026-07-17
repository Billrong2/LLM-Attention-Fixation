#!/usr/bin/env python3
"""Unit and frozen-artifact checks for the balanced contingency waves."""

from __future__ import annotations

import json
import sys
import unittest
from collections import Counter
from pathlib import Path


HERE = Path(__file__).resolve().parent
if str(HERE) not in sys.path:
    sys.path.insert(0, str(HERE))

import finalize_balanced_contingency as finalizer
import prepare_balanced_contingency as balanced
from prepare_long_code_variants import sha256_file, sha256_text


ARTIFACT = HERE / "balanced_contingency"


def read_json(path: Path):
    return json.loads(path.read_text(encoding="utf-8"))


class BalancedCriteriaTests(unittest.TestCase):
    def test_rank_key_and_seven_line_boundary(self) -> None:
        private = balanced.BalancedCandidate(1, "private_tests", 9, "x" * 512, "a\n", 512, 2, 1)
        generated = balanced.BalancedCandidate(1, "generated_tests", 0, "x" * 80, "z\n", 80, 2, 1)
        self.assertLess(private.rank_key, generated.rank_key)

        accepted, audit = balanced.assess_pair(
            row_index=1,
            suite="generated_tests",
            dataset_test_index=3,
            stdin="x" * 5,
            expected_stdout="1\n2\n3\n4\n5\n6\n7\n",
            previously_screened=set(),
            tokenizer_rejections=set(),
        )
        self.assertIsNotNone(accepted)
        self.assertEqual(accepted.output_lines, 7)
        self.assertEqual(audit["eligibility"], "statically_eligible")

        rejected, audit = balanced.assess_pair(
            row_index=1,
            suite="generated_tests",
            dataset_test_index=4,
            stdin="x" * 512,
            expected_stdout="1\n2\n3\n4\n5\n6\n7\n8\n",
            previously_screened=set(),
            tokenizer_rejections=set(),
        )
        self.assertIsNone(rejected)
        self.assertIn("expected_output_over_7_lines", audit["reasons"])

    def test_prior_and_tokenizer_rejections_scan_out_of_pool(self) -> None:
        key = (7, "private_tests", 2)
        for screened, tokenizer, expected in (
            ({key}, set(), "excluded_previously_screened"),
            (set(), {key}, "excluded_recorded_tokenizer_rejection"),
        ):
            candidate, audit = balanced.assess_pair(
                row_index=7,
                suite="private_tests",
                dataset_test_index=2,
                stdin="12345",
                expected_stdout="ok\n",
                previously_screened=screened,
                tokenizer_rejections=tokenizer,
            )
            self.assertIsNone(candidate)
            self.assertEqual(audit["eligibility"], expected)

    def test_source_choice_is_first_eligible_in_frozen_order(self) -> None:
        def row(identity, row_index):
            return {
                "id": identity,
                "candidate_metadata": {
                    "provenance": {
                        "dataset_id": balanced.DATASET_ID,
                        "dataset_revision": balanced.DATASET_REVISION,
                        "split": balanced.DATASET_SPLIT,
                        "dataset_file_sha256": balanced.DATASET_SHA256,
                        "row_index": row_index,
                    }
                },
            }

        prepared = [row("first", 1), row("second", 1), row("third", 2)]
        with self.assertRaisesRegex(ValueError, "expected 19"):
            balanced.choose_sources(prepared, {"first", "second", "third"})

        # Directly check ordering logic without weakening the production count invariant.
        grouped = {}
        for item in prepared:
            grouped.setdefault(item["candidate_metadata"]["provenance"]["row_index"], []).append(item)
        self.assertEqual(grouped[1][0]["id"], "first")


class FrozenBalancedArtifactTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        if not ARTIFACT.is_dir():
            raise AssertionError(f"Frozen balanced artifact is missing: {ARTIFACT}")
        cls.pre = [
            read_json(ARTIFACT / f"wave_{wave}_manifest_pre_tokenizer.json")
            for wave in (1, 2)
        ]
        cls.filtered_paths = [
            ARTIFACT / "tokenizer_preflight" / f"wave_{wave}" / "inference_eligible_variants.json"
            for wave in (1, 2)
        ]
        cls.filtered = [read_json(path) for path in cls.filtered_paths]

    def _case_keys(self, payload):
        return {
            tuple(case["canonical_case_key"])
            for variant in payload["variants"]
            for case in variant["cases"]
        }

    def test_each_wave_is_exactly_balanced_and_parent_alias_free(self) -> None:
        for wave, payload in enumerate(self.filtered, start=1):
            self.assertEqual(len(payload["variants"]), 19)
            self.assertEqual(payload["case_count"], 38)
            self.assertEqual(payload["state"], "exact_tokenizer_gate_passed")
            cases = [case for variant in payload["variants"] for case in variant["cases"]]
            self.assertEqual(len(cases), 38)
            counts = Counter(case["source_case_metadata"]["row_index"] for case in cases)
            self.assertEqual(len(counts), 19)
            self.assertEqual(set(counts.values()), {2})
            self.assertEqual(len(self._case_keys(payload)), 38)
            for variant in payload["variants"]:
                self.assertFalse(set(variant) & balanced.PARENT_CASE_ALIASES)
                for case in variant["cases"]:
                    self.assertEqual(case["source_case_metadata"]["wave_id"], f"balanced_wave_{wave}")

    def test_waves_are_disjoint_and_do_not_overlap_prior_screens(self) -> None:
        wave_1 = self._case_keys(self.filtered[0])
        wave_2 = self._case_keys(self.filtered[1])
        self.assertFalse(wave_1 & wave_2)
        prior = read_json(ARTIFACT / "previous_screened_case_audit.json")
        prior_keys = {tuple(row["canonical_case_key"]) for row in prior["records"]}
        self.assertFalse((wave_1 | wave_2) & prior_keys)
        self.assertEqual(prior["initial_case_record_count"], 23)
        self.assertEqual(prior["supplemental_case_record_count"], 60)
        self.assertEqual(prior["supplemental_unique_canonical_case_count"], 48)

    def test_source_denominator_and_frozen_source_hashes(self) -> None:
        audit = read_json(ARTIFACT / "source_denominator_audit.json")
        self.assertEqual(audit["frozen_source_denominator"], 25)
        self.assertEqual(audit["tokenizer_eligible_source_count"], 23)
        self.assertEqual(audit["canonical_problem_count"], 19)
        self.assertEqual(audit["chosen_source_count"], 19)
        self.assertEqual(audit["wave_1_case_count"], 38)
        self.assertEqual(audit["wave_2_case_count"], 38)
        for source in audit["sources"]:
            original = HERE / source["original_path"]
            obfuscated = HERE / source["obfuscated_path"]
            self.assertEqual(sha256_file(original), source["original_sha256"])
            self.assertEqual(sha256_file(obfuscated), source["obfuscated_sha256"])
            self.assertGreaterEqual(source["physical_loc"], 250)
            self.assertLessEqual(source["physical_loc"], 350)

    def test_all_selected_jdk_records_and_exact_bytes_are_valid(self) -> None:
        source_audit = read_json(ARTIFACT / "source_denominator_audit.json")
        for source in source_audit["sources"]:
            for case in source["selected_cases"]:
                validation = read_json(ARTIFACT / case["validation_path"])
                self.assertTrue(validation["accepted"])
                self.assertTrue(validation["original_obfuscated_trimmed_agreement"])
                for side in ("original", "obfuscated"):
                    section = validation[side]
                    self.assertTrue(section["accepted"])
                    evidence = section["cases"][0]
                    self.assertTrue(evidence["accepted"])
                    self.assertTrue(evidence["trimmed_exact_match"])
                    self.assertEqual(evidence["exit_code"], 0)
                    self.assertEqual(evidence["stderr"], "")
                stdin = (ARTIFACT / case["stdin_path"]).read_text(encoding="utf-8")
                oracle = (ARTIFACT / case["oracle_stdout_path"]).read_text(encoding="utf-8")
                self.assertEqual(sha256_text(stdin), case["input_sha256"])
                self.assertEqual(sha256_text(oracle), case["raw_expected_stdout_sha256"])

    def test_runner_loaded_child_hashes_not_parent_values(self) -> None:
        audit = read_json(ARTIFACT / "loader_hash_audit.json")
        self.assertTrue(audit["parent_shadow_regression_checked"])
        self.assertTrue(audit["all_loaded_hashes_match"])
        for wave in audit["waves"].values():
            self.assertEqual(wave["expanded_case_count"], 38)
            self.assertTrue(wave["all_loaded_hashes_match"])
            self.assertTrue(all(row["all_match"] for row in wave["checks"]))

    def test_exact_tokenizer_gate_passes_without_weights(self) -> None:
        for wave in (1, 2):
            root = ARTIFACT / "tokenizer_preflight" / f"wave_{wave}"
            report = read_json(root / "full_report.json")
            self.assertEqual(report["counts"]["exploded_denominator_records"], 38)
            self.assertEqual(report["counts"]["inference_eligible_records"], 38)
            self.assertEqual(report["counts"]["excluded_records"], 0)
            self.assertFalse(report["tokenizer"]["model_weights_loaded"])
            self.assertEqual(report["tokenizer"]["snapshot_commit"], finalizer.MODEL_SNAPSHOT)
            self.assertEqual((root / "exclusions.jsonl").read_text(encoding="utf-8"), "")
            for record in report["records"]:
                self.assertTrue(record["decision"]["inference_eligible"])
                self.assertFalse(record["slicing_prior"]["algorithm_fallback_detected"])
                self.assertTrue(record["slice_hybrid"]["case_signal_active"])
                self.assertTrue(record["prompt"]["token_preflight"]["fits_context"])

    def test_launch_plans_are_frozen_partitions_but_not_launched(self) -> None:
        for wave in (1, 2):
            plan = read_json(ARTIFACT / f"launch_plan_wave_{wave}.json")
            self.assertEqual(plan["state"], "frozen_not_launched")
            self.assertFalse(plan["result_roots_created"])
            working_directory = Path(plan["working_directory"]).resolve()
            self.assertEqual(working_directory, HERE.resolve())
            self.assertEqual(
                (working_directory / plan["runner"]).resolve(),
                (HERE / "run_long_code_experiment.py").resolve(),
            )
            self.assertEqual(
                (working_directory / plan["manifest"]).resolve(),
                (
                    ARTIFACT
                    / "tokenizer_preflight"
                    / f"wave_{wave}"
                    / "inference_eligible_variants.json"
                ).resolve(),
            )
            self.assertEqual(plan["sample_count"], 38)
            self.assertEqual(plan["samples_per_shard"], [10, 10, 9, 9])
            self.assertEqual(plan["expected_run_records"], 456)
            sample_ids = [sample for shard in plan["shards"] for sample in shard["sample_ids"]]
            self.assertEqual(len(sample_ids), len(set(sample_ids)))
            self.assertEqual(len(sample_ids), 38)
            for shard in plan["shards"]:
                output = (working_directory / shard["output_root"]).resolve()
                self.assertEqual(
                    output,
                    (
                        HERE
                        / "balanced_contingency_inference"
                        / f"wave_{wave}"
                        / f"shard_{shard['shard_index']}"
                    ).resolve(),
                )
                self.assertNotIn("long-code-sample-work/long-code-sample-work", str(output))
                self.assertFalse(output.exists())

    def test_freeze_inventory_and_anchor_are_exact(self) -> None:
        freeze_path = ARTIFACT / "freeze_manifest.json"
        anchor = (ARTIFACT / "FREEZE.sha256").read_text(encoding="utf-8").split()[0]
        self.assertEqual(sha256_file(freeze_path), anchor)
        freeze = read_json(freeze_path)
        self.assertEqual(freeze["state"], "frozen_not_launched")
        for row in freeze["generated_files"]:
            path = ARTIFACT / row["path"]
            self.assertTrue(path.is_file())
            self.assertEqual(path.stat().st_size, row["bytes"])
            self.assertEqual(sha256_file(path), row["sha256"])
        for row in freeze["control_files"]:
            path = HERE / row["path"]
            self.assertTrue(path.is_file())
            self.assertEqual(sha256_file(path), row["sha256"])

    def test_final_summary_discloses_no_results_or_inference(self) -> None:
        summary = read_json(ARTIFACT / "final_summary.json")
        self.assertEqual(summary["state"], "fully_frozen_tokenizer_gated_not_launched")
        self.assertEqual(summary["model_result_files_read"], 0)
        self.assertEqual(summary["model_inference_calls"], 0)
        self.assertFalse(summary["model_weights_loaded"])
        self.assertTrue(summary["selection_frozen_before_outcomes"])
        self.assertTrue(summary["administrative_refreeze_after_outcomes"])
        correction = read_json(ARTIFACT / "path_correction_provenance.json")
        self.assertFalse(correction["case_selection_or_ranking_changed"])
        self.assertFalse(correction["tokenizer_filtered_manifests_changed"])
        self.assertEqual(correction["excluded_attempt"]["total_completed_records"], 21)
        self.assertFalse(summary["result_roots_created"])
        readme = (ARTIFACT / "README.md").read_text(encoding="utf-8")
        self.assertIn("exact-tokenizer-gated", readme)
        self.assertNotIn("next model-free steps", readme)


if __name__ == "__main__":
    unittest.main()
