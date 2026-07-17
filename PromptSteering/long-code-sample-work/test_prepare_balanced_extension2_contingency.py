#!/usr/bin/env python3
"""Unit and frozen-artifact checks for adaptive balanced Waves 4--6."""

from __future__ import annotations

import json
import sys
import unittest
from collections import Counter
from pathlib import Path


HERE = Path(__file__).resolve().parent
if str(HERE) not in sys.path:
    sys.path.insert(0, str(HERE))

import finalize_balanced_extension2_contingency as finalizer
import prepare_balanced_contingency as balanced
import prepare_balanced_extension2_contingency as extension2
from prepare_long_code_variants import sha256_file, sha256_text


ARTIFACT = HERE / "balanced_extension2_contingency"
EXTERNAL_ANCHOR = HERE / "balanced_extension2_contingency.FREEZE.sha256"
EXPECTED_RANKS = {
    4: set(range(11, 16)),
    5: set(range(16, 20)),
}
EXPECTED_CASES = {4: 95, 5: 76}
EXPECTED_CASES_PER_PROBLEM = {4: 5, 5: 4}
EXPECTED_SHARDS = {4: [24, 24, 24, 23], 5: [19, 19, 19, 19]}
EXPECTED_SHARD_RECORDS = {
    4: [288, 288, 288, 276],
    5: [228, 228, 228, 228],
}


def read_json(path: Path):
    return json.loads(path.read_text(encoding="utf-8"))


def cases(payload):
    return [case for variant in payload["variants"] for case in variant["cases"]]


def case_keys(payload):
    return {tuple(case["canonical_case_key"]) for case in cases(payload)}


class BalancedExtension2ProtocolTests(unittest.TestCase):
    def test_protocol_disclosure_triggers_and_populations_are_exact(self) -> None:
        protocol = read_json(HERE / "balanced_extension2_contingency_protocol.json")
        self.assertEqual(protocol["schema_version"], extension2.SCHEMA_VERSION)
        self.assertEqual(
            protocol["status"],
            {
                "adaptive": True,
                "outcome_aware_from_wave_2": True,
                "preregistered": False,
                "outcome_blind_in_timing": False,
                "specified_during_live_wave_3": True,
                "prospectively_revised_during_live_wave_3": True,
                "prospective_revision_count": 2,
                "wave_3_outputs_or_results_inspected": False,
                "case_eligibility_ranking_selection_outcome_independent": True,
                "revision_uses_model_outcomes": False,
            },
        )
        disclosure = protocol["timing_disclosure"]
        self.assertIn("during live Wave 3", disclosure)
        self.assertIn("post-Wave-2 audit", disclosure)
        self.assertIn("four distinct strict canonical", disclosure)
        self.assertIn("No Wave-3 model output", disclosure)
        failure = protocol["case_selection"]["rank_25_feasibility_failure"]
        self.assertEqual(failure["status"], "failed_closed")
        self.assertEqual(failure["limiting_canonical_row_index"], 27)
        self.assertEqual(failure["statically_eligible_candidate_count"], 202)
        self.assertEqual(failure["jdk_valid_accepted_rank_count"], 24)
        self.assertEqual(
            failure["revision_basis"], "exhaustive frozen-rule static/JDK feasibility only"
        )
        failure20 = protocol["case_selection"]["rank_20_feasibility_failure"]
        self.assertEqual(failure20["status"], "failed_closed")
        self.assertEqual(failure20["limiting_canonical_row_index"], 54)
        self.assertEqual(failure20["statically_eligible_candidate_count"], 255)
        self.assertEqual(failure20["jdk_valid_accepted_rank_count"], 19)
        self.assertEqual(failure20["missing_accepted_rank"], 20)
        self.assertIn("largest uniform", protocol["adaptive_status_disclosure"])
        trigger = protocol["sequential_trigger"]
        self.assertEqual(trigger["threshold"], 10)
        self.assertTrue(trigger["audit_must_be_complete_and_valid"])
        self.assertTrue(trigger["stop_all_later_waves_when_threshold_reached"])
        self.assertFalse(trigger["interim_looks_within_wave_allowed"])
        waves = {int(row["wave_id"].rsplit("_", 1)[1]): row for row in protocol["waves"]}
        self.assertEqual(set(waves), {4, 5})
        for number, expected in EXPECTED_RANKS.items():
            self.assertEqual(set(waves[number]["accepted_ranks_per_problem"]), expected)
            self.assertEqual(waves[number]["canonical_problem_count"], 19)
            self.assertEqual(
                waves[number]["cases_per_problem"], EXPECTED_CASES_PER_PROBLEM[number]
            )
            self.assertEqual(waves[number]["case_count"], EXPECTED_CASES[number])
        inference = protocol["inference"]
        self.assertEqual(
            inference["shard_case_counts_by_wave"],
            {f"balanced_wave_{number}": EXPECTED_SHARDS[number] for number in EXPECTED_RANKS},
        )
        self.assertEqual(
            inference["shard_expected_run_records_by_wave"],
            {
                f"balanced_wave_{number}": EXPECTED_SHARD_RECORDS[number]
                for number in EXPECTED_RANKS
            },
        )
        self.assertEqual(
            inference["expected_run_records_by_wave"],
            {"balanced_wave_4": 1140, "balanced_wave_5": 912},
        )
        self.assertEqual(inference["maximum_expected_run_records_all_two_waves"], 2052)
        self.assertFalse(inference["wave_6_launch_plan"])

    def test_prior_balanced_rank_manifests_are_exact_through_rank_10(self) -> None:
        accepted, keys, source_ids = extension2.validate_prior_balanced_waves(
            read_json(extension2.DEFAULT_WAVE_1_MANIFEST),
            read_json(extension2.DEFAULT_WAVE_2_MANIFEST),
            read_json(extension2.DEFAULT_WAVE_3_MANIFEST),
        )
        self.assertEqual(len(accepted), 19)
        self.assertTrue(all(set(ranks) == set(range(1, 11)) for ranks in accepted.values()))
        self.assertEqual(len(keys), 190)
        self.assertEqual(len(source_ids), 19)

    def test_preparer_defaults_are_static_inputs_only(self) -> None:
        args = extension2.build_parser().parse_args([])
        self.assertEqual(args.output_root, ARTIFACT)
        self.assertEqual(args.wave_3_manifest, extension2.DEFAULT_WAVE_3_MANIFEST)
        self.assertNotIn("inference", args.wave_3_manifest.parts)
        for path in (
            args.candidate_manifest,
            args.prepared_manifest,
            args.eligible_manifest,
            args.supplemental_manifest,
            args.wave_1_manifest,
            args.wave_2_manifest,
            args.wave_3_manifest,
            args.dataset,
        ):
            self.assertTrue(path.is_file())


class FrozenBalancedExtension2ArtifactTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        if not ARTIFACT.is_dir():
            raise AssertionError(f"Frozen second extension artifact is missing: {ARTIFACT}")
        cls.filtered = {
            number: read_json(
                ARTIFACT
                / "tokenizer_preflight"
                / f"wave_{number}"
                / "inference_eligible_variants.json"
            )
            for number in EXPECTED_RANKS
        }

    def test_manifests_are_exact_balanced_and_mutually_disjoint(self) -> None:
        seen = set()
        for number, payload in self.filtered.items():
            self.assertEqual(payload["state"], "exact_tokenizer_gate_passed")
            self.assertEqual(payload["wave_id"], f"balanced_wave_{number}")
            self.assertEqual(len(payload["variants"]), 19)
            self.assertEqual(payload["case_count"], EXPECTED_CASES[number])
            all_cases = cases(payload)
            self.assertEqual(len(all_cases), EXPECTED_CASES[number])
            counts = Counter(case["source_case_metadata"]["row_index"] for case in all_cases)
            self.assertEqual(len(counts), 19)
            self.assertEqual(set(counts.values()), {EXPECTED_CASES_PER_PROBLEM[number]})
            keys = case_keys(payload)
            self.assertEqual(len(keys), EXPECTED_CASES[number])
            self.assertFalse(keys & seen)
            seen |= keys
            ranks = Counter(case["accepted_rank"] for case in all_cases)
            self.assertEqual(ranks, Counter({rank: 19 for rank in EXPECTED_RANKS[number]}))
            for variant in payload["variants"]:
                self.assertFalse(set(variant) & balanced.PARENT_CASE_ALIASES)
                self.assertEqual(
                    {case["accepted_rank"] for case in variant["cases"]},
                    EXPECTED_RANKS[number],
                )
        self.assertEqual(len(seen), 171)

    def test_sources_match_waves_1_through_3_and_all_prior_keys_are_excluded(self) -> None:
        source_ids = {
            balanced.variant_id(row) for row in self.filtered[4]["variants"]
        }
        for number in sorted(set(EXPECTED_RANKS) - {4}):
            self.assertEqual(
                source_ids,
                {balanced.variant_id(row) for row in self.filtered[number]["variants"]},
            )
        for path in (
            extension2.DEFAULT_WAVE_1_MANIFEST,
            extension2.DEFAULT_WAVE_2_MANIFEST,
            extension2.DEFAULT_WAVE_3_MANIFEST,
        ):
            self.assertEqual(
                source_ids,
                {balanced.variant_id(row) for row in read_json(path)["variants"]},
            )
        prior_keys = set()
        for label, path, expected_count in (
            ("initial", extension2.DEFAULT_ELIGIBLE_MANIFEST, 23),
            ("supplemental", extension2.DEFAULT_SUPPLEMENTAL_MANIFEST, 60),
            ("wave_1", extension2.DEFAULT_WAVE_1_MANIFEST, 38),
            ("wave_2", extension2.DEFAULT_WAVE_2_MANIFEST, 38),
            ("wave_3", extension2.DEFAULT_WAVE_3_MANIFEST, 114),
        ):
            keys, _ = balanced.collect_screened_keys(
                read_json(path), label=label, expected_case_count=expected_count
            )
            prior_keys |= keys
        for payload in self.filtered.values():
            self.assertFalse(case_keys(payload) & prior_keys)
        audit = read_json(ARTIFACT / "previous_screened_case_audit.json")
        self.assertEqual(audit["wave_3_case_record_count"], 114)
        self.assertEqual(audit["wave_4_overlap_count"], 0)
        self.assertEqual(audit["wave_5_overlap_count"], 0)
        self.assertNotIn("wave_6_overlap_count", audit)
        self.assertEqual(audit["cross_new_wave_overlap_count"], 0)

    def test_jdk_continuity_and_selected_evidence_are_complete(self) -> None:
        audit = read_json(ARTIFACT / "source_denominator_audit.json")
        self.assertEqual(audit["frozen_source_denominator"], 25)
        self.assertEqual(audit["tokenizer_eligible_source_count"], 23)
        self.assertEqual(audit["canonical_problem_count"], 19)
        self.assertEqual(audit["chosen_source_count"], 19)
        self.assertEqual(audit["prior_accepted_ranks_revalidated_per_problem"], 10)
        for number in EXPECTED_RANKS:
            self.assertEqual(audit[f"wave_{number}_case_count"], EXPECTED_CASES[number])
        for source in audit["sources"]:
            self.assertEqual(
                {row["accepted_rank"] for row in source["continuity_verified_ranks_1_10"]},
                set(range(1, 11)),
            )
            self.assertEqual(
                {case["accepted_rank"] for case in source["selected_cases"]},
                set(range(11, 20)),
            )
            self.assertEqual(sha256_file(HERE / source["original_path"]), source["original_sha256"])
            self.assertEqual(
                sha256_file(HERE / source["obfuscated_path"]), source["obfuscated_sha256"]
            )
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

    def test_loader_hash_audit_covers_both_final_waves(self) -> None:
        audit = read_json(ARTIFACT / "loader_hash_audit.json")
        self.assertTrue(audit["parent_shadow_regression_checked"])
        self.assertTrue(audit["all_loaded_hashes_match"])
        self.assertEqual(set(audit["waves"]), {"balanced_wave_4", "balanced_wave_5"})
        for wave in audit["waves"].values():
            number = int(wave["manifest"].split("wave_")[1].split("_")[0])
            self.assertEqual(wave["expanded_case_count"], EXPECTED_CASES[number])
            self.assertTrue(wave["all_loaded_hashes_match"])
            self.assertEqual(len(wave["checks"]), EXPECTED_CASES[number])
            self.assertTrue(all(row["all_match"] for row in wave["checks"]))

    def test_exact_tokenizer_gates_pass_without_fallback_or_weights(self) -> None:
        for number in EXPECTED_RANKS:
            root = ARTIFACT / "tokenizer_preflight" / f"wave_{number}"
            report = read_json(root / "full_report.json")
            self.assertEqual(
                report["counts"]["exploded_denominator_records"], EXPECTED_CASES[number]
            )
            self.assertEqual(
                report["counts"]["inference_eligible_records"], EXPECTED_CASES[number]
            )
            self.assertEqual(report["counts"]["excluded_records"], 0)
            self.assertEqual(report["counts"]["preflight_error_records"], 0)
            self.assertFalse(report["tokenizer"]["model_weights_loaded"])
            self.assertEqual(report["tokenizer"]["snapshot_commit"], finalizer.MODEL_SNAPSHOT)
            self.assertEqual((root / "exclusions.jsonl").read_text(encoding="utf-8"), "")
            self.assertEqual(len(report["records"]), EXPECTED_CASES[number])
            for record in report["records"]:
                self.assertTrue(record["decision"]["inference_eligible"])
                self.assertFalse(record["slicing_prior"]["algorithm_fallback_detected"])
                self.assertTrue(record["slice_hybrid"]["case_signal_active"])
                self.assertTrue(record["prompt"]["token_preflight"]["fits_context"])

    def test_provenance_is_honest_static_and_wave_3_blind(self) -> None:
        provenance = read_json(ARTIFACT / "provenance.json")
        self.assertTrue(provenance["specified_during_live_wave_3"])
        self.assertEqual(provenance["prospective_revision_count"], 2)
        self.assertTrue(provenance["rank25_feasibility_failure_preserved"])
        self.assertTrue(provenance["rank20_feasibility_failure_preserved"])
        self.assertEqual(provenance["final_design_wave_count"], 2)
        self.assertTrue(provenance["wave_6_removed"])
        self.assertEqual(provenance["completed_wave_2_strict_canonical_problem_count"], 4)
        self.assertFalse(provenance["wave_3_outputs_results_or_result_files_inspected"])
        self.assertTrue(provenance["case_ranking_outcome_independent"])
        self.assertEqual(provenance["model_result_directories_listed"], 0)
        self.assertEqual(provenance["model_result_files_read"], 0)
        self.assertEqual(provenance["wave_3_result_files_read"], 0)
        self.assertEqual(provenance["model_inference_calls"], 0)
        self.assertFalse(provenance["model_weights_loaded"])
        self.assertEqual(provenance["public_test_values_read"], 0)
        self.assertNotIn("public_tests", provenance["dataset"]["columns_loaded"])

    def test_both_feasibility_failures_are_preserved_and_final_revision_is_explicit(self) -> None:
        audit = read_json(ARTIFACT / "rank25_feasibility_failure_audit.json")
        self.assertEqual(
            audit["schema_version"],
            "long-code-balanced-extension2-rank25-feasibility-failure-v1",
        )
        self.assertEqual(
            audit["original_proposal"]["wave_6_accepted_ranks_per_problem"],
            [21, 22, 23, 24, 25],
        )
        failure = audit["failure"]
        self.assertEqual(failure["row_index"], 27)
        self.assertEqual(failure["statically_eligible_candidate_count"], 202)
        self.assertEqual(failure["jdk_executed_candidate_count"], 202)
        self.assertEqual(failure["accepted_rank_count"], 24)
        self.assertEqual(failure["new_accepted_rank_count"], 14)
        self.assertEqual(failure["missing_accepted_rank"], 25)
        self.assertFalse(failure["exact_19_by_5_possible"])
        revision = audit["prospective_revision"]
        self.assertEqual(revision["wave_6_accepted_ranks_per_problem"], [21, 22, 23, 24])
        self.assertTrue(revision["largest_uniform_block_across_same_19_problems"])
        self.assertTrue(revision["specified_before_any_wave_3_output_or_result_inspection"])
        evidence_root = ARTIFACT / audit["evidence_root"]
        actual = []
        for path in sorted(evidence_root.rglob("*")):
            if path.is_file():
                actual.append(
                    {
                        "path": str(path.relative_to(evidence_root)),
                        "bytes": path.stat().st_size,
                        "sha256": sha256_file(path),
                    }
                )
        self.assertEqual(actual, audit["evidence_files"])
        self.assertEqual(len(actual), 641)
        canonical = json.dumps(
            actual, sort_keys=True, ensure_ascii=False, separators=(",", ":")
        )
        self.assertEqual(sha256_text(canonical), audit["evidence_inventory_sha256"])
        row27 = (
            evidence_root
            / "validation"
            / "cc-valid-r027-s0184-1553-d-backspace__t5_easy_seed1"
        )
        validations = [read_json(path) for path in sorted(row27.glob("*.json"))]
        self.assertEqual(len(validations), 202)
        self.assertEqual(sum(int(row["accepted"]) for row in validations), 24)
        external = HERE / audit["external_preserved_archive"]
        self.assertTrue(external.is_dir())

        audit20 = read_json(ARTIFACT / "rank20_feasibility_failure_audit.json")
        self.assertEqual(
            audit20["schema_version"],
            "long-code-balanced-extension2-rank20-feasibility-failure-v1",
        )
        failure20 = audit20["failure"]
        self.assertEqual(failure20["row_index"], 54)
        self.assertEqual(failure20["statically_eligible_candidate_count"], 255)
        self.assertEqual(failure20["jdk_executed_candidate_count"], 255)
        self.assertEqual(failure20["accepted_rank_count"], 19)
        self.assertEqual(failure20["new_accepted_rank_count"], 9)
        self.assertEqual(failure20["missing_accepted_rank"], 20)
        self.assertFalse(failure20["exact_wave_5_19_by_5_possible"])
        self.assertFalse(failure20["any_uniform_wave_6_possible"])
        final_design = audit20["prospective_final_design"]
        self.assertEqual(final_design["wave_4_accepted_ranks_per_problem"], [11, 12, 13, 14, 15])
        self.assertEqual(final_design["wave_5_accepted_ranks_per_problem"], [16, 17, 18, 19])
        self.assertEqual(final_design["wave_count"], 2)
        self.assertTrue(final_design["wave_6_removed"])
        self.assertTrue(final_design["largest_uniform_two_wave_design_across_same_19_problems"])
        evidence20 = ARTIFACT / audit20["evidence_root"]
        actual20 = []
        for path in sorted(evidence20.rglob("*")):
            if path.is_file():
                actual20.append(
                    {
                        "path": str(path.relative_to(evidence20)),
                        "bytes": path.stat().st_size,
                        "sha256": sha256_file(path),
                    }
                )
        self.assertEqual(actual20, audit20["evidence_files"])
        self.assertEqual(len(actual20), 1071)
        canonical20 = json.dumps(
            actual20, sort_keys=True, ensure_ascii=False, separators=(",", ":")
        )
        self.assertEqual(sha256_text(canonical20), audit20["evidence_inventory_sha256"])
        row54 = (
            evidence20
            / "validation"
            / "cc-valid-r054-s0229-1557-c-moamen-and-xor__t5_easy_seed1"
        )
        validations54 = [read_json(path) for path in sorted(row54.glob("*.json"))]
        self.assertEqual(len(validations54), 255)
        self.assertEqual(sum(int(row["accepted"]) for row in validations54), 19)
        self.assertTrue((HERE / audit20["external_preserved_archive"]).is_dir())

    def test_launch_plans_are_exact_sequential_here_relative_and_not_launched(self) -> None:
        for number in EXPECTED_RANKS:
            plan = read_json(ARTIFACT / f"launch_plan_wave_{number}.json")
            self.assertEqual(plan["schema_version"], "long-code-balanced-extension2-launch-plan-v1")
            self.assertEqual(plan["state"], "frozen_not_launched")
            self.assertEqual(plan["wave_id"], f"balanced_wave_{number}")
            self.assertEqual(Path(plan["working_directory"]).resolve(), HERE.resolve())
            self.assertEqual(plan["runner"], "run_long_code_experiment.py")
            self.assertEqual(
                plan["manifest"],
                f"balanced_extension2_contingency/tokenizer_preflight/wave_{number}/inference_eligible_variants.json",
            )
            self.assertEqual(plan["sample_count"], EXPECTED_CASES[number])
            self.assertEqual(plan["samples_per_shard"], EXPECTED_SHARDS[number])
            self.assertEqual(
                plan["expected_run_records_per_shard"], EXPECTED_SHARD_RECORDS[number]
            )
            self.assertEqual(plan["expected_run_records"], EXPECTED_CASES[number] * 12)
            self.assertEqual(plan["accepted_ranks_per_problem"], sorted(EXPECTED_RANKS[number]))
            self.assertTrue(plan["stop_later_waves_if_threshold_reached"])
            self.assertFalse(plan["interim_looks_within_wave_allowed"])
            sample_ids = [sample for shard in plan["shards"] for sample in shard["sample_ids"]]
            self.assertEqual(len(sample_ids), len(set(sample_ids)))
            self.assertEqual(len(sample_ids), EXPECTED_CASES[number])
            for shard in plan["shards"]:
                expected = (
                    f"balanced_extension2_contingency_inference/wave_{number}/"
                    f"shard_{shard['shard_index']}"
                )
                self.assertEqual(shard["output_root"], expected)
                self.assertFalse(Path(shard["output_root"]).is_absolute())
                self.assertFalse((HERE / expected).exists())
        self.assertFalse((ARTIFACT / "launch_plan_wave_6.json").exists())
        self.assertFalse((ARTIFACT / "wave_6_manifest_pre_tokenizer.json").exists())

    def test_freeze_inventory_and_both_anchors_are_exact(self) -> None:
        freeze_path = ARTIFACT / "freeze_manifest.json"
        digest = sha256_file(freeze_path)
        self.assertEqual((ARTIFACT / "FREEZE.sha256").read_text(encoding="utf-8").split()[0], digest)
        self.assertEqual(EXTERNAL_ANCHOR.read_text(encoding="utf-8").split()[0], digest)
        freeze = read_json(freeze_path)
        self.assertEqual(freeze["schema_version"], "long-code-balanced-extension2-freeze-v1")
        self.assertEqual(freeze["state"], "frozen_not_launched")
        actual = {
            str(path.relative_to(ARTIFACT))
            for path in ARTIFACT.rglob("*")
            if path.is_file() and path.name not in {"freeze_manifest.json", "FREEZE.sha256"}
        }
        self.assertEqual({row["path"] for row in freeze["generated_files"]}, actual)
        for row in freeze["generated_files"]:
            path = ARTIFACT / row["path"]
            self.assertEqual(path.stat().st_size, row["bytes"])
            self.assertEqual(sha256_file(path), row["sha256"])
        for row in freeze["control_files"]:
            path = HERE / row["path"]
            self.assertEqual(path.stat().st_size, row["bytes"])
            self.assertEqual(sha256_file(path), row["sha256"])
        invariants = freeze["invariants"]
        self.assertTrue(invariants["specified_during_live_wave_3"])
        self.assertEqual(invariants["completed_post_wave_2_unique_strict_canonical_problem_count"], 4)
        self.assertFalse(invariants["wave_3_outputs_or_results_inspected"])
        self.assertEqual(invariants["case_count_by_wave"], {"4": 95, "5": 76})
        self.assertEqual(
            invariants["cases_per_problem_by_wave"], {"4": 5, "5": 4}
        )
        self.assertEqual(invariants["total_frozen_new_cases"], 171)
        self.assertEqual(invariants["tokenizer_exclusions_by_wave"], {"4": 0, "5": 0})
        self.assertTrue(invariants["rank25_original_proposal_failed_closed"])
        self.assertEqual(invariants["rank25_feasibility_evidence_file_count"], 641)
        self.assertTrue(invariants["rank20_revised_design_failed_closed"])
        self.assertEqual(invariants["rank20_feasibility_evidence_file_count"], 1071)
        self.assertFalse(invariants["result_roots_created"])

    def test_final_summary_is_frozen_conditional_and_disclosed(self) -> None:
        summary = read_json(ARTIFACT / "final_summary.json")
        self.assertEqual(summary["state"], "fully_frozen_tokenizer_gated_not_launched")
        self.assertTrue(summary["specified_during_live_wave_3"])
        self.assertEqual(summary["prospective_revision_count"], 2)
        self.assertTrue(summary["adaptive_outcome_aware_from_wave_2"])
        self.assertTrue(summary["adaptive_not_preregistered"])
        self.assertFalse(summary["outcome_blind_in_timing"])
        self.assertFalse(summary["wave_3_outputs_or_results_inspected"])
        self.assertTrue(summary["case_eligibility_ranking_selection_outcome_independent"])
        self.assertEqual(summary["total_frozen_new_cases"], 171)
        self.assertEqual(summary["model_result_files_read_by_preparer_or_finalizer"], 0)
        self.assertFalse(summary["result_roots_created"])
        readme = (ARTIFACT / "README.md").read_text(encoding="utf-8")
        self.assertIn("during live Wave 3", readme)
        self.assertIn("not preregistered", readme)
        self.assertIn("post-Wave-3 audit below 10", readme)
        self.assertIn("Reaching 10 stops every later wave", readme)


if __name__ == "__main__":
    unittest.main()
