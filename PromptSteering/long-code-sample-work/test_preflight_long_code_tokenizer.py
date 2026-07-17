#!/usr/bin/env python3
"""Focused tests for the tokenizer-only long-code inference gate."""

from __future__ import annotations

import re
import sys
import tempfile
import unittest
from pathlib import Path


HERE = Path(__file__).resolve().parent
if str(HERE) not in sys.path:
    sys.path.insert(0, str(HERE))

import preflight_long_code_tokenizer as preflight
import run_long_code_experiment as experiment


DEPENDENT_JAVA = """public class Demo {
    static int solve(int value) {
        int result = value + 1;
        return result;
    }
    public static void main(String[] args) {
        System.out.println(solve(1));
    }
}
"""


CONSTANT_JAVA = """public class Demo {
    static int solve(int value) {
        return 7;
    }
    public static void main(String[] args) {
        System.out.println(solve(1));
    }
}
"""


class TinyTokenizer:
    model_max_length = 2048

    def __call__(self, text, add_special_tokens=True):
        del add_special_tokens
        self.tokens = re.findall(r"[A-Za-z_][A-Za-z_0-9]*|\d+|\S", text)
        return {"input_ids": list(range(len(self.tokens)))}

    def convert_ids_to_tokens(self, ids):
        return [self.tokens[index] for index in ids]


def exact_prompt_builder(code_snippet, *, instruction, language, answer_prefix=""):
    return f"{instruction}\n\n```{language}\n{code_snippet}\n```{answer_prefix}"


class TokenizerPreflightTests(unittest.TestCase):
    def test_output_boundary_rejects_everything_above_work_root(self) -> None:
        accepted = preflight.ensure_output_dir(HERE / "nested" / "result")
        self.assertEqual(accepted, (HERE / "nested" / "result").resolve())
        with self.assertRaisesRegex(ValueError, "must remain below"):
            preflight.ensure_output_dir(HERE.parent / "outside-long-code-work")

    def test_filter_retains_only_passing_parent_cases(self) -> None:
        source = {
            "schema_version": 1,
            "variant_count": 2,
            "case_count": 3,
            "state": "tokenizer pending",
            "variants": [
                {
                    "id": "variant-a",
                    "cases": [
                        {"case_id": "00-generated-156", "stdin": "1"},
                        {"case_id": "00-private-003", "stdin": "2"},
                    ],
                },
                {"id": "variant-b", "cases": [{"case_id": "00-public-001", "stdin": "3"}]},
            ],
        }
        records = [
            {
                "sample_id": "variant-a__00-generated-156",
                "parent_variant_id": "variant-a",
                "case_id": "00-generated-156",
                "decision": {"inference_eligible": True},
            },
            {
                "sample_id": "variant-a__00-private-003",
                "parent_variant_id": "variant-a",
                "case_id": "00-private-003",
                "decision": {"inference_eligible": False},
            },
            {
                "sample_id": "variant-b__00-public-001",
                "parent_variant_id": "variant-b",
                "case_id": "00-public-001",
                "decision": {"inference_eligible": False},
            },
        ]
        filtered = preflight.filter_manifest_to_passing(source, records)
        self.assertEqual(filtered["variant_count"], 1)
        self.assertEqual([row["id"] for row in filtered["variants"]], ["variant-a"])
        self.assertEqual(
            filtered["variants"][0]["cases"],
            [{"case_id": "00-generated-156", "stdin": "1"}],
        )
        self.assertEqual(
            filtered["tokenizer_preflight"]["retained_exploded_sample_count"],
            1,
        )
        self.assertEqual(filtered["case_count"], 1)
        self.assertEqual(filtered["state"], "exact_tokenizer_gate_passed")

    def test_existing_relative_paths_are_rebased_for_filtered_manifest(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as raw_temp:
            root = Path(raw_temp)
            source_dir = root / "source"
            output_dir = root / "output"
            source_dir.mkdir()
            output_dir.mkdir()
            (source_dir / "Demo.java").write_text(DEPENDENT_JAVA, encoding="utf-8")
            payload = {"variants": [{"original_path": "Demo.java", "note_path": "missing.txt"}]}
            rebased = preflight.rebase_existing_manifest_paths(
                payload,
                source_dir=source_dir,
                output_dir=output_dir,
            )
            self.assertEqual(rebased["variants"][0]["original_path"], "../source/Demo.java")
            self.assertEqual(rebased["variants"][0]["note_path"], "missing.txt")

    def test_exact_prompt_detects_dependency_and_cases_signal(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as raw_temp:
            root = Path(raw_temp)
            original = root / "original.java"
            obfuscated = root / "obfuscated.java"
            original.write_text(DEPENDENT_JAVA, encoding="utf-8")
            obfuscated.write_text(DEPENDENT_JAVA, encoding="utf-8")
            sample = experiment.Sample(
                "demo__c001",
                original,
                obfuscated,
                "solve",
                "solve",
                stdin="1\n",
                metadata={
                    "parent_candidate_id": "demo",
                    "concrete_case": {"case_id": "c001"},
                },
            )
            adapter = preflight.TokenizerOnlyRunner(
                TinyTokenizer(),
                prompt_builder=exact_prompt_builder,
            )
            record = preflight.evaluate_sample(sample, adapter, experiment, denominator_index=1)
            self.assertTrue(record["decision"]["inference_eligible"])
            self.assertFalse(record["slicing_prior"]["algorithm_fallback_detected"])
            self.assertTrue(record["slice_hybrid"]["case_signal_active"])
            self.assertEqual(record["slice_hybrid"]["parsed_case_ids"], ["c001"])
            self.assertTrue(record["prompt"]["codesteer_instruction_equals_obfuscated_plain"])

    def test_exact_prompt_excludes_constant_return_positional_fallback(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as raw_temp:
            root = Path(raw_temp)
            original = root / "original.java"
            obfuscated = root / "obfuscated.java"
            original.write_text(CONSTANT_JAVA, encoding="utf-8")
            obfuscated.write_text(CONSTANT_JAVA, encoding="utf-8")
            sample = experiment.Sample(
                "constant__c001",
                original,
                obfuscated,
                "solve",
                "solve",
                stdin="1\n",
                metadata={
                    "parent_candidate_id": "constant",
                    "concrete_case": {"case_id": "c001"},
                },
            )
            adapter = preflight.TokenizerOnlyRunner(
                TinyTokenizer(),
                prompt_builder=exact_prompt_builder,
            )
            record = preflight.evaluate_sample(sample, adapter, experiment, denominator_index=1)
            self.assertFalse(record["decision"]["inference_eligible"])
            self.assertTrue(record["slicing_prior"]["algorithm_fallback_detected"])
            self.assertEqual(
                record["decision"]["exclusion_reasons"],
                ["algorithm_prior_matches_normalized_positional_fallback"],
            )


if __name__ == "__main__":
    unittest.main()
