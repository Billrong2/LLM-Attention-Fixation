from __future__ import annotations

import hashlib
import json
import sys
import unittest
from pathlib import Path


sys.dont_write_bytecode = True
HERE = Path(__file__).resolve().parent
if str(HERE) not in sys.path:
    sys.path.insert(0, str(HERE))

import run_long_code_experiment as runner
import audit_long_code_results as auditor


PLAN_PATH = HERE / "supplemental_launch_plan.json"


class SupplementalLaunchPlanTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.plan = json.loads(PLAN_PATH.read_text(encoding="utf-8"))
        cls.manifest_path = HERE / cls.plan["manifest"]
        cls.expanded, _ = runner.load_manifest(cls.manifest_path)

    def test_manifest_and_runner_are_pinned(self) -> None:
        manifest_digest = hashlib.sha256(self.manifest_path.read_bytes()).hexdigest()
        runner_digest = hashlib.sha256((HERE / self.plan["runner"]).read_bytes()).hexdigest()
        self.assertEqual(manifest_digest, self.plan["manifest_sha256"])
        self.assertEqual(runner_digest, self.plan["runner_sha256_at_planning"])

    def test_round_robin_is_exact_complete_and_disjoint(self) -> None:
        expanded_ids = [sample.sample_id for sample in self.expanded]
        self.assertEqual(len(expanded_ids), 60)
        self.assertEqual(len(set(expanded_ids)), 60)
        shards = self.plan["shards"]
        self.assertEqual(len(shards), 4)
        for index, shard in enumerate(shards):
            self.assertEqual(shard["shard_index"], index)
            self.assertEqual(shard["sample_ids"], expanded_ids[index::4])
            self.assertEqual(len(shard["sample_ids"]), 15)
        flattened = [sample_id for shard in shards for sample_id in shard["sample_ids"]]
        self.assertEqual(len(flattened), 60)
        self.assertEqual(set(flattened), set(expanded_ids))

    def test_expanded_case_content_matches_frozen_case_hashes(self) -> None:
        inputs_by_parent = {}
        for sample in self.expanded:
            concrete_case = sample.metadata["concrete_case"]
            self.assertEqual(
                hashlib.sha256(sample.stdin.encode("utf-8")).hexdigest(),
                concrete_case["input_sha256"],
                sample.sample_id,
            )
            self.assertIsNotNone(sample.expected_stdout, sample.sample_id)
            self.assertEqual(
                hashlib.sha256(sample.expected_stdout.encode("utf-8")).hexdigest(),
                concrete_case["raw_expected_stdout_sha256"],
                sample.sample_id,
            )
            parent_id = sample.metadata["parent_candidate_id"]
            inputs_by_parent.setdefault(parent_id, set()).add(concrete_case["input_sha256"])
        self.assertEqual(len(inputs_by_parent), 15)
        self.assertTrue(all(len(digests) == 4 for digests in inputs_by_parent.values()))

    def test_each_exact_argv_uses_registered_protocol_and_local_output_root(self) -> None:
        expected_conditions = list(runner.CONDITIONS)
        for index, shard in enumerate(self.plan["shards"]):
            argv = [
                *self.plan["shared_argv"],
                "--gpu-ids",
                shard["gpu_id"],
                "--sample-ids",
                ",".join(shard["sample_ids"]),
                "--output-root",
                shard["output_root"],
            ]
            args = runner.parse_args(argv)
            self.assertEqual(args.model_name, runner.DEFAULT_MODEL_NAME)
            self.assertEqual(args.trials, 3)
            self.assertEqual(args.base_seed, 20260713)
            self.assertEqual(args.max_new_tokens, runner.GENERATION_DEFAULTS["max_new_tokens"])
            self.assertEqual(args.temperature, runner.GENERATION_DEFAULTS["temperature"])
            self.assertEqual(args.top_p, runner.GENERATION_DEFAULTS["top_p"])
            self.assertEqual(args.top_k, runner.GENERATION_DEFAULTS["top_k"])
            self.assertEqual(args.conditions.split(","), expected_conditions)
            self.assertEqual(args.gpu_ids, str(index))
            self.assertEqual(args.offline, "on")
            self.assertEqual(args.hf_login, "off")
            self.assertEqual(
                runner._experiment_output_root(args.output_root),
                HERE / "supplemental_results" / f"shard_{index}",
            )

    def test_combined_audit_has_disjoint_ids_and_canonical_problem_units(self) -> None:
        compatibility = self.plan["combined_audit_compatibility"]
        initial_path = HERE / compatibility["initial_manifest"]
        initial_digest = hashlib.sha256(initial_path.read_bytes()).hexdigest()
        self.assertEqual(initial_digest, compatibility["initial_manifest_sha256"])
        initial, _ = runner.load_manifest(initial_path)
        initial_ids = {sample.sample_id for sample in initial}
        supplemental_ids = {sample.sample_id for sample in self.expanded}
        self.assertFalse(initial_ids & supplemental_ids)
        self.assertEqual(len(initial), compatibility["initial_sample_count"])
        self.assertEqual(len(self.expanded), compatibility["supplemental_sample_count"])
        self.assertEqual(
            len(initial_ids | supplemental_ids), compatibility["combined_sample_count"]
        )

        def canonical_identities(samples):
            identities = set()
            for sample in samples:
                candidate_metadata = sample.metadata["candidate_metadata"]
                identity, _, _, errors = auditor._published_problem_identity(
                    candidate_metadata,
                    location=self.manifest_path,
                )
                self.assertEqual(errors, [])
                self.assertIsNotNone(identity)
                identities.add(identity)
            return identities

        initial_problems = canonical_identities(initial)
        supplemental_problems = canonical_identities(self.expanded)
        self.assertEqual(
            len(initial_problems), compatibility["initial_canonical_problem_count"]
        )
        self.assertEqual(
            len(supplemental_problems),
            compatibility["supplemental_canonical_problem_count"],
        )
        self.assertEqual(
            len(initial_problems | supplemental_problems),
            compatibility["combined_canonical_problem_count"],
        )
        self.assertTrue(supplemental_problems <= initial_problems)


if __name__ == "__main__":
    unittest.main()
