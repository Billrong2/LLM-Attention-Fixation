from __future__ import annotations

import copy
import unittest

from evaluate_prompt_results import EvaluationError, evaluate_records


def fixture_manifest() -> dict:
    return {
        "protocol": {
            "prompt_mode": "slice",
            "prompt_mechanism": "artifact_conditioned_natural_language_instruction_only",
            "temperature": 0.9,
            "top_p": 0.95,
            "do_sample": True,
            "base_seed": 20260527,
            "trials_per_unit": 3,
        },
        "rows": [
            {
                "model_label": "model-label",
                "model_name": "org/model",
                "model": "Model",
                "dataset": "dataset",
                "expected_units": 1,
                "case_total": 2,
                "pass_correct": [1, 2, 2],
                "pass_percent": [50.0, 100.0, 100.0],
                "original_percent": [100.0, 100.0, 100.0],
                "obfuscated_percent": [0.0, 0.0, 0.0],
            }
        ],
    }


def fixture_record(trial: int, correct: tuple[bool, bool]) -> dict:
    return {
        "record_type": "trial",
        "model_label": "model-label",
        "model": "org/model",
        "dataset": "dataset",
        "unit_id": "unit",
        "source_sha256": "a" * 64,
        "trial_id": trial,
        "run_index": trial,
        "generation_params": {
            "temperature": 0.9,
            "top_p": 0.95,
            "do_sample": True,
            "base_seed": 20260527,
            "seed": 100 + trial,
        },
        "prompt_steering": {
            "mode": "slice",
            "mechanism": "artifact_conditioned_natural_language_instruction_only",
        },
        "prompt_text": "same prompt",
        "generated_completion": "answer",
        "per_case_scores": [
            {
                "case_id": "c1",
                "expected": "T",
                "predicted": "T" if correct[0] else "F",
                "correct": correct[0],
            },
            {
                "case_id": "c2",
                "expected": "T",
                "predicted": "T" if correct[1] else "F",
                "correct": correct[1],
            },
        ],
    }


class EvaluatePromptResultsTest(unittest.TestCase):
    def setUp(self) -> None:
        self.records = [
            fixture_record(1, (True, False)),
            fixture_record(2, (False, True)),
            fixture_record(3, (False, False)),
        ]

    def test_exact_cumulative_union(self) -> None:
        rows, summary = evaluate_records(self.records, fixture_manifest())
        self.assertEqual([rows[0][f"prompt_p{k}"] for k in (1, 2, 3)], ["50.00", "100.00", "100.00"])
        self.assertEqual(summary["rows"][0]["pass_correct"], [1, 2, 2])

    def test_missing_trial_is_rejected(self) -> None:
        with self.assertRaisesRegex(EvaluationError, "Trial set mismatch"):
            evaluate_records(self.records[:2], fixture_manifest())

    def test_duplicate_trial_is_rejected(self) -> None:
        with self.assertRaisesRegex(EvaluationError, "Duplicate trial"):
            evaluate_records([*self.records, copy.deepcopy(self.records[0])], fixture_manifest())

    def test_case_set_drift_is_rejected(self) -> None:
        records = copy.deepcopy(self.records)
        records[1]["per_case_scores"][1]["case_id"] = "different"
        with self.assertRaisesRegex(EvaluationError, "Case-set or oracle drift"):
            evaluate_records(records, fixture_manifest())


if __name__ == "__main__":
    unittest.main()
