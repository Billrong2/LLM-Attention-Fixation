#!/usr/bin/env python3
"""Unit and frozen-artifact checks for the adaptive balanced Wave-3 extension."""

from __future__ import annotations

import json
import sys
import unittest
from collections import Counter
from pathlib import Path


HERE = Path(__file__).resolve().parent
if str(HERE) not in sys.path:
    sys.path.insert(0, str(HERE))

import finalize_balanced_extension_contingency as finalizer
import prepare_balanced_contingency as balanced
import prepare_balanced_extension_contingency as extension
from prepare_long_code_variants import sha256_file, sha256_text


ARTIFACT = HERE / "balanced_extension_contingency"
EXTERNAL_ANCHOR = HERE / "balanced_extension_contingency.FREEZE.sha256"


def read_json(path: Path):
    return json.loads(path.read_text(encoding="utf-8"))


def cases(payload):
    return [case for variant in payload["variants"] for case in variant["cases"]]


def case_keys(payload):
    return {tuple(case["canonical_case_key"]) for case in cases(payload)}


class BalancedExtensionProtocolTests(unittest.TestCase):
    def test_protocol_is_adaptive_and_selection_rules_are_exact(self) -> None:
        protocol = read_json(HERE / "balanced_extension_contingency_protocol.json")
        self.assertEqual(protocol["schema_version"], extension.SCHEMA_VERSION)
        self.assertEqual(
            protocol["status"],
            {
                "adaptive": True,
                "preregistered": False,
                "outcome_blind_in_timing": False,
                "case_eligibility_ranking_selection_outcome_independent": True,
            },
        )
        disclosure = protocol["timing_disclosure"]
        self.assertIn("aggregate interim results-index exact-count look", disclosure)
        self.assertIn("zero exact CodeSteer trials", disclosure)
        self.assertIn("baseline exact matches", disclosure)
        self.assertIn("No raw model completion", disclosure)
        self.assertNotIn("before corrected Wave 1 outcomes", disclosure)
        self.assertEqual(protocol["trigger"]["run_wave_3_only_when_complete_post_wave_2_metric_below"], 10)
        self.assertEqual(protocol["wave"]["accepted_ranks_per_problem"], list(range(5, 11)))
        self.assertEqual(protocol["wave"]["case_count"], 114)
        self.assertEqual(protocol["inference"]["shard_case_counts"], [29, 29, 28, 28])
        self.assertEqual(protocol["inference"]["shard_expected_run_records"], [348, 348, 336, 336])
        self.assertEqual(protocol["inference"]["expected_run_records"], 1368)

    def test_prior_balanced_rank_manifests_are_exact(self) -> None:
        wave_1 = read_json(extension.DEFAULT_WAVE_1_MANIFEST)
        wave_2 = read_json(extension.DEFAULT_WAVE_2_MANIFEST)
        accepted, keys, source_ids = extension.validate_prior_balanced_waves(wave_1, wave_2)
        self.assertEqual(len(accepted), 19)
        self.assertTrue(all(set(ranks) == {1, 2, 3, 4} for ranks in accepted.values()))
        self.assertEqual(len(keys), 76)
        self.assertEqual(len(source_ids), 19)

    def test_preparer_default_reads_are_static_manifests_only(self) -> None:
        parser = extension.build_parser()
        args = parser.parse_args([])
        self.assertEqual(args.output_root, ARTIFACT)
        self.assertEqual(args.wave_1_manifest, extension.DEFAULT_WAVE_1_MANIFEST)
        self.assertEqual(args.wave_2_manifest, extension.DEFAULT_WAVE_2_MANIFEST)
        for path in (
            args.candidate_manifest,
            args.prepared_manifest,
            args.eligible_manifest,
            args.supplemental_manifest,
            args.wave_1_manifest,
            args.wave_2_manifest,
            args.dataset,
        ):
            self.assertFalse("inference" in path.parts and "tokenizer_preflight" not in path.parts)


class FrozenBalancedExtensionArtifactTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        if not ARTIFACT.is_dir():
            raise AssertionError(f"Frozen extension artifact is missing: {ARTIFACT}")
        cls.pre = read_json(ARTIFACT / "wave_3_manifest_pre_tokenizer.json")
        cls.filtered_path = ARTIFACT / "tokenizer_preflight" / "inference_eligible_variants.json"
        cls.filtered = read_json(cls.filtered_path)

    def test_manifest_is_19_by_6_ranks_5_through_10(self) -> None:
        payload = self.filtered
        self.assertEqual(payload["state"], "exact_tokenizer_gate_passed")
        self.assertEqual(payload["wave_id"], "balanced_wave_3")
        self.assertEqual(len(payload["variants"]), 19)
        self.assertEqual(payload["case_count"], 114)
        all_cases = cases(payload)
        self.assertEqual(len(all_cases), 114)
        counts = Counter(case["source_case_metadata"]["row_index"] for case in all_cases)
        self.assertEqual(len(counts), 19)
        self.assertEqual(set(counts.values()), {6})
        self.assertEqual(len(case_keys(payload)), 114)
        ranks = Counter(case["accepted_rank"] for case in all_cases)
        self.assertEqual(ranks, Counter({rank: 19 for rank in range(5, 11)}))
        for variant in payload["variants"]:
            self.assertFalse(set(variant) & balanced.PARENT_CASE_ALIASES)
            self.assertEqual({case["accepted_rank"] for case in variant["cases"]}, set(range(5, 11)))
            for case in variant["cases"]:
                self.assertEqual(case["source_case_metadata"]["wave_id"], "balanced_wave_3")

    def test_sources_match_frozen_waves_and_all_prior_keys_are_excluded(self) -> None:
        wave_1 = read_json(extension.DEFAULT_WAVE_1_MANIFEST)
        wave_2 = read_json(extension.DEFAULT_WAVE_2_MANIFEST)
        self.assertEqual(
            {balanced.variant_id(row) for row in self.filtered["variants"]},
            {balanced.variant_id(row) for row in wave_1["variants"]},
        )
        self.assertEqual(
            {balanced.variant_id(row) for row in self.filtered["variants"]},
            {balanced.variant_id(row) for row in wave_2["variants"]},
        )
        prior_keys = set()
        for label, path, expected_count in (
            ("initial", extension.DEFAULT_ELIGIBLE_MANIFEST, 23),
            ("supplemental", extension.DEFAULT_SUPPLEMENTAL_MANIFEST, 60),
            ("wave_1", extension.DEFAULT_WAVE_1_MANIFEST, 38),
            ("wave_2", extension.DEFAULT_WAVE_2_MANIFEST, 38),
        ):
            keys, _ = balanced.collect_screened_keys(
                read_json(path), label=label, expected_case_count=expected_count
            )
            prior_keys |= keys
        self.assertFalse(case_keys(self.filtered) & prior_keys)
        audit = read_json(ARTIFACT / "previous_screened_case_audit.json")
        self.assertEqual(audit["initial_case_record_count"], 23)
        self.assertEqual(audit["supplemental_case_record_count"], 60)
        self.assertEqual(audit["wave_1_case_record_count"], 38)
        self.assertEqual(audit["wave_2_case_record_count"], 38)
        self.assertEqual(audit["wave_3_overlap_count"], 0)

    def test_jdk_continuity_and_selected_case_evidence_are_complete(self) -> None:
        audit = read_json(ARTIFACT / "source_denominator_audit.json")
        self.assertEqual(audit["frozen_source_denominator"], 25)
        self.assertEqual(audit["tokenizer_eligible_source_count"], 23)
        self.assertEqual(audit["canonical_problem_count"], 19)
        self.assertEqual(audit["chosen_source_count"], 19)
        self.assertEqual(audit["wave_3_case_count"], 114)
        for source in audit["sources"]:
            self.assertEqual(
                {row["accepted_rank"] for row in source["continuity_verified_ranks_1_4"]},
                {1, 2, 3, 4},
            )
            self.assertEqual({case["accepted_rank"] for case in source["selected_cases"]}, set(range(5, 11)))
            self.assertEqual(sha256_file(HERE / source["original_path"]), source["original_sha256"])
            self.assertEqual(sha256_file(HERE / source["obfuscated_path"]), source["obfuscated_sha256"])
            for case in source["selected_cases"]:
                validation = read_json(ARTIFACT / case["validation_path"])
                self.assertTrue(validation["accepted"])
                self.assertTrue(validation["original_obfuscated_trimmed_agreement"])
                for side in ("original", "obfuscated"):
                    evidence = validation[side]["cases"][0]
                    self.assertTrue(evidence["accepted"])
                    self.assertTrue(evidence["trimmed_exact_match"])
                    self.assertEqual(evidence["exit_code"], 0)
                    self.assertEqual(evidence["stderr"], "")
                stdin = (ARTIFACT / case["stdin_path"]).read_text(encoding="utf-8")
                oracle = (ARTIFACT / case["oracle_stdout_path"]).read_text(encoding="utf-8")
                self.assertEqual(sha256_text(stdin), case["input_sha256"])
                self.assertEqual(sha256_text(oracle), case["raw_expected_stdout_sha256"])

    def test_loader_hash_audit_covers_all_114_children(self) -> None:
        audit = read_json(ARTIFACT / "loader_hash_audit.json")
        self.assertTrue(audit["parent_shadow_regression_checked"])
        self.assertTrue(audit["all_loaded_hashes_match"])
        wave = audit["wave_3"]
        self.assertEqual(wave["expanded_case_count"], 114)
        self.assertTrue(wave["all_loaded_hashes_match"])
        self.assertEqual(len(wave["checks"]), 114)
        self.assertTrue(all(row["all_match"] for row in wave["checks"]))

    def test_exact_tokenizer_gate_passes_all_114_without_weights(self) -> None:
        root = ARTIFACT / "tokenizer_preflight"
        report = read_json(root / "full_report.json")
        self.assertEqual(report["counts"]["exploded_denominator_records"], 114)
        self.assertEqual(report["counts"]["inference_eligible_records"], 114)
        self.assertEqual(report["counts"]["excluded_records"], 0)
        self.assertEqual(report["counts"]["preflight_error_records"], 0)
        self.assertFalse(report["tokenizer"]["model_weights_loaded"])
        self.assertEqual(report["tokenizer"]["snapshot_commit"], finalizer.MODEL_SNAPSHOT)
        self.assertEqual((root / "exclusions.jsonl").read_text(encoding="utf-8"), "")
        self.assertEqual(len(report["records"]), 114)
        for record in report["records"]:
            self.assertTrue(record["decision"]["inference_eligible"])
            self.assertFalse(record["slicing_prior"]["algorithm_fallback_detected"])
            self.assertTrue(record["slice_hybrid"]["case_signal_active"])
            self.assertTrue(record["prompt"]["token_preflight"]["fits_context"])

    def test_adaptive_provenance_is_accurate_and_static_only(self) -> None:
        provenance = read_json(ARTIFACT / "provenance.json")
        external = provenance["adaptive_interim_look_external_fact"]
        self.assertEqual(external["observed_codesteer_exact_trial_count"], 0)
        self.assertTrue(external["included_baseline_exact_sample_identifiers"])
        self.assertFalse(external["raw_completions_used_to_specify_contingency_or_case_rules"])
        self.assertFalse(external["used_by_case_eligibility_ranking_or_selection"])
        self.assertEqual(provenance["model_result_files_read"], 0)
        self.assertEqual(provenance["model_inference_calls"], 0)
        self.assertFalse(provenance["model_weights_loaded"])
        self.assertEqual(provenance["public_test_values_read"], 0)
        self.assertNotIn("public_tests", provenance["dataset"]["columns_loaded"])
        self.assertIn("not outcome-blind in timing", provenance["adaptive_status_disclosure"])

    def test_launch_plan_is_exact_here_relative_partition_and_not_launched(self) -> None:
        plan = read_json(ARTIFACT / "launch_plan_wave_3.json")
        self.assertEqual(plan["schema_version"], "long-code-balanced-extension-launch-plan-v1")
        self.assertEqual(plan["state"], "frozen_not_launched")
        self.assertEqual(plan["wave_id"], "balanced_wave_3")
        self.assertEqual(Path(plan["working_directory"]).resolve(), HERE.resolve())
        self.assertEqual(plan["working_directory_label"], "long-code-sample-work")
        self.assertEqual(plan["runner"], "run_long_code_experiment.py")
        self.assertEqual(
            plan["manifest"],
            "balanced_extension_contingency/tokenizer_preflight/inference_eligible_variants.json",
        )
        self.assertEqual(plan["sample_count"], 114)
        self.assertEqual(plan["samples_per_shard"], [29, 29, 28, 28])
        self.assertEqual(plan["expected_run_records_per_shard"], [348, 348, 336, 336])
        self.assertEqual(plan["expected_run_records"], 1368)
        self.assertEqual(plan["trials_per_case"], 3)
        self.assertEqual(plan["conditions_per_trial"], 4)
        self.assertEqual(plan["base_seed"], 20260713)
        self.assertEqual(plan["temperature"], 1.05)
        self.assertEqual(plan["top_p"], 0.95)
        self.assertEqual(plan["top_k"], 7)
        self.assertEqual(plan["max_new_tokens"], 512)
        sample_ids = [sample for shard in plan["shards"] for sample in shard["sample_ids"]]
        self.assertEqual(len(sample_ids), len(set(sample_ids)))
        self.assertEqual(len(sample_ids), 114)
        for shard in plan["shards"]:
            self.assertFalse(Path(shard["output_root"]).is_absolute())
            self.assertEqual(
                shard["output_root"],
                f"balanced_extension_contingency_inference/wave_3/shard_{shard['shard_index']}",
            )
            self.assertFalse((HERE / shard["output_root"]).exists())

    def test_freeze_inventory_internal_and_external_anchors_are_exact(self) -> None:
        freeze_path = ARTIFACT / "freeze_manifest.json"
        digest = sha256_file(freeze_path)
        self.assertEqual((ARTIFACT / "FREEZE.sha256").read_text(encoding="utf-8").split()[0], digest)
        self.assertEqual(EXTERNAL_ANCHOR.read_text(encoding="utf-8").split()[0], digest)
        freeze = read_json(freeze_path)
        self.assertEqual(freeze["schema_version"], "long-code-balanced-extension-freeze-v1")
        self.assertEqual(freeze["state"], "frozen_not_launched")
        actual = {
            str(path.relative_to(ARTIFACT))
            for path in ARTIFACT.rglob("*")
            if path.is_file() and path.name not in {"freeze_manifest.json", "FREEZE.sha256"}
        }
        recorded = {row["path"] for row in freeze["generated_files"]}
        self.assertEqual(recorded, actual)
        for row in freeze["generated_files"]:
            path = ARTIFACT / row["path"]
            self.assertEqual(path.stat().st_size, row["bytes"])
            self.assertEqual(sha256_file(path), row["sha256"])
        for row in freeze["control_files"]:
            path = HERE / row["path"]
            self.assertTrue(path.is_file())
            self.assertEqual(path.stat().st_size, row["bytes"])
            self.assertEqual(sha256_file(path), row["sha256"])
        invariants = freeze["invariants"]
        self.assertTrue(invariants["adaptive_not_preregistered"])
        self.assertFalse(invariants["outcome_blind_in_timing"])
        self.assertTrue(invariants["case_ranking_outcome_independent"])
        self.assertEqual(invariants["wave_3_cases"], 114)
        self.assertEqual(invariants["accepted_ranks_per_problem"], list(range(5, 11)))
        self.assertEqual(invariants["tokenizer_exclusions"], 0)
        self.assertFalse(invariants["result_roots_created"])

    def test_final_summary_is_frozen_conditional_and_disclosed(self) -> None:
        summary = read_json(ARTIFACT / "final_summary.json")
        self.assertEqual(summary["state"], "fully_frozen_tokenizer_gated_not_launched")
        self.assertTrue(summary["adaptive_not_preregistered"])
        self.assertFalse(summary["outcome_blind_in_timing"])
        self.assertTrue(summary["case_eligibility_ranking_selection_outcome_independent"])
        self.assertEqual(summary["model_result_files_read_by_preparer_or_finalizer"], 0)
        self.assertEqual(summary["model_inference_calls"], 0)
        self.assertFalse(summary["model_weights_loaded"])
        self.assertFalse(summary["result_roots_created"])
        readme = (ARTIFACT / "README.md").read_text(encoding="utf-8")
        self.assertIn("not preregistered", readme)
        self.assertIn("not outcome-blind in timing", readme)
        self.assertIn("complete valid post-Wave-2 audit", readme)
        self.assertNotIn("before corrected Wave 1 outcomes", readme)


if __name__ == "__main__":
    unittest.main()
