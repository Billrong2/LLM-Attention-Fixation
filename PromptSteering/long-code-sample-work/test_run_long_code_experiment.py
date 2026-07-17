from __future__ import annotations

import json
import os
import re
import sys
import tempfile
import unittest
from unittest import mock
from pathlib import Path


HERE = Path(__file__).resolve().parent
if str(HERE) not in sys.path:
    sys.path.insert(0, str(HERE))

import run_long_code_experiment as runner


JAVA = """public class Demo {
    static int solve(int value) {
        return value + 1;
    }
    public static void main(String[] args) {
        System.out.println(solve(1));
    }
}
"""


class LongCodeRunnerTests(unittest.TestCase):
    def test_java_oracle_uses_local_scratch_and_sanitizes_injected_options(self) -> None:
        java_home = Path("/people/cs/x/xxr230000/jdks/jdk-17.0.11+9")
        if not (java_home / "bin" / "javac").is_file():
            self.skipTest("registered JDK is unavailable")
        code = (
            "public class Demo { public static void main(String[] args) { "
            'System.out.println(System.getProperty("case.secret", "clean")); } }'
        )
        with tempfile.TemporaryDirectory(dir=HERE) as scratch_raw:
            scratch = Path(scratch_raw)
            with mock.patch.dict(
                os.environ,
                {
                    "JAVA_TOOL_OPTIONS": "-Dcase.secret=leak-a",
                    "JDK_JAVA_OPTIONS": "-Dcase.secret=leak-b",
                    "_JAVA_OPTIONS": "-Dcase.secret=leak-c",
                    "CLASSPATH": "/definitely/not/the/experiment/classpath",
                },
                clear=False,
            ):
                result = runner.run_java_source(
                    code=code,
                    explicit_main_class="Demo",
                    stdin="",
                    argv=[],
                    classpath=[],
                    java_home=java_home,
                    timeout_seconds=10,
                    scratch_root=scratch,
                )
            self.assertTrue(result["success"], result)
            self.assertEqual(result["stdout"], "clean\n")
            self.assertEqual(result["compile_stderr"], "")
            self.assertEqual(result["stderr"], "")
            self.assertEqual(list(scratch.iterdir()), [])

    def test_registered_generation_and_codesteer_profile(self) -> None:
        self.assertEqual(
            runner.GENERATION_DEFAULTS,
            {
                "do_sample": True,
                "temperature": 1.05,
                "top_p": 0.95,
                "top_k": 7,
                "max_new_tokens": 512,
            },
        )
        cfg = runner.build_codesteer_config()
        self.assertEqual(list(cfg.enabled_levels), [2])
        self.assertEqual(cfg.prior, "slice_hybrid")
        self.assertEqual(cfg.n_bins, 12)
        self.assertEqual(cfg.beta_post, 0.8)
        self.assertEqual(cfg.recency_rho, 0.2)
        self.assertEqual(cfg.recency_window, 64)
        self.assertEqual(cfg.head_subset_mode, "none")

    def test_paired_seed_is_stable_and_trial_specific(self) -> None:
        first = runner.paired_seed(17, "sample-a", 1)
        self.assertEqual(first, runner.paired_seed(17, "sample-a", 1))
        self.assertNotEqual(first, runner.paired_seed(17, "sample-a", 2))
        self.assertNotEqual(first, runner.paired_seed(17, "sample-b", 1))

    def test_static_prior_cache_is_per_manager_and_bin_without_value_change(self) -> None:
        from types import SimpleNamespace
        from steering.manager import SteeringManager

        profile = runner.install_static_prior_vector_cache()
        self.assertTrue(profile["installed"])

        class CountingProvider:
            def __init__(self) -> None:
                self.calls = 0

            def vector(self, bin_index: int, bin_count: int):
                import numpy as np

                self.calls += 1
                return np.asarray([bin_index, bin_count, 0.25], dtype=float)

        def manager() -> SteeringManager:
            value = object.__new__(SteeringManager)
            value.state = SimpleNamespace(current_bin=0, bins=[None, None, None])
            value.prior_provider = CountingProvider()
            return value

        first = manager()
        vector_1 = first.prior_vector()
        vector_2 = first.prior_vector()
        self.assertIs(vector_1, vector_2)
        self.assertEqual(first.prior_provider.calls, 1)
        first.state.current_bin = 1
        self.assertEqual(first.prior_vector().tolist(), [1.0, 3.0, 0.25])
        self.assertEqual(first.prior_provider.calls, 2)

        second = manager()
        self.assertEqual(second.prior_vector().tolist(), [0.0, 3.0, 0.25])
        self.assertEqual(second.prior_provider.calls, 1)

    def test_historical_trimmed_exact_scoring(self) -> None:
        self.assertEqual(runner.normalize_stdout(" a  b\r\n c \n"), "a  b\n c")
        self.assertEqual(runner.normalize_stdout(""), "")
        self.assertNotEqual(runner.normalize_stdout("a b"), runner.normalize_stdout("a  b"))

    def test_parse_required_machine_readable_final_output(self) -> None:
        completion = (
            "The loop prints twice.\n"
            'FINAL_OUTPUT_JSON: {"stdout":"first\\nsecond\\n"}\n'
        )
        stdout, meta = runner.parse_final_output(completion)
        self.assertEqual(stdout, "first\nsecond\n")
        self.assertEqual(meta["parse_status"], "marker_json")
        missing, missing_meta = runner.parse_final_output("The answer is probably 3.")
        self.assertIsNone(missing)
        self.assertEqual(missing_meta["parse_status"], "missing_or_invalid_final_json")

    def test_cases_markers_and_target_are_always_in_base_prompt(self) -> None:
        sample = runner.Sample(
            sample_id="demo",
            original_path=Path("original.java"),
            obfuscated_path=Path("obfuscated.java"),
            original_target_method="solve",
            obfuscated_target_method="m1",
            stdin="5\n",
        )
        prompt = runner.build_base_instruction(sample, target_method="m1")
        self.assertIn("### CASES_BEGIN", prompt)
        self.assertIn("c001:", prompt)
        self.assertIn("### CASES_END", prompt)
        self.assertIn("target_method=m1", prompt)
        self.assertIn("FINAL_OUTPUT_JSON:", prompt)

    def test_variant_manifest_with_nested_sources_and_cases(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as temp_raw:
            temp = Path(temp_raw)
            (temp / "original.java").write_text(JAVA, encoding="utf-8")
            (temp / "obfuscated.java").write_text(JAVA, encoding="utf-8")
            manifest = {
                "schema_version": 1,
                "variants": [
                    {
                        "candidate_id": "candidate-7",
                        "original": {"source_path": "original.java", "class": "Demo"},
                        "obfuscated": {"source_path": "obfuscated.java", "class": "Demo"},
                        "codesteer_target_method": "solve",
                        "cases": [
                            {"case_id": "c001", "stdin": "", "expected_output": "2\n"}
                        ],
                    }
                ],
            }
            manifest_path = temp / "manifest.json"
            manifest_path.write_text(json.dumps(manifest), encoding="utf-8")
            samples, metadata = runner.load_manifest(manifest_path)
            self.assertEqual(metadata["schema_version"], 1)
            self.assertEqual(len(samples), 1)
            sample = samples[0]
            self.assertEqual(sample.sample_id, "candidate-7__c001")
            self.assertEqual(sample.expected_stdout, "2\n")
            self.assertEqual(sample.original_main_class, "Demo")
            self.assertEqual(sample.obfuscated_main_class, "Demo")
            self.assertEqual(sample.obfuscated_target_method, "solve")

    def test_case_paths_replace_parent_inline_input_output_and_args(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as temp_raw:
            temp = Path(temp_raw)
            (temp / "original.java").write_text(JAVA, encoding="utf-8")
            (temp / "obfuscated.java").write_text(JAVA, encoding="utf-8")
            (temp / "case.in").write_text("41\n", encoding="utf-8")
            (temp / "case.out").write_text("42\n", encoding="utf-8")
            manifest = {
                "variants": [
                    {
                        "id": "parent",
                        "original_path": "original.java",
                        "obfuscated_path": "obfuscated.java",
                        "target_method": "solve",
                        "stdin": "999\n",
                        "input": "998\n",
                        "expected_stdout": "1000\n",
                        "expected_output": "1001\n",
                        "argv": ["parent-arg"],
                        "cases": [
                            {
                                "case_id": "path-case",
                                "stdin_path": "case.in",
                                "expected_output_path": "case.out",
                                "args": ["case-arg"],
                            }
                        ],
                    }
                ]
            }
            manifest_path = temp / "manifest.json"
            manifest_path.write_text(json.dumps(manifest), encoding="utf-8")

            samples, _ = runner.load_manifest(manifest_path)
            self.assertEqual(len(samples), 1)
            self.assertEqual(samples[0].stdin, "41\n")
            self.assertEqual(samples[0].expected_stdout, "42\n")
            self.assertEqual(samples[0].argv, ("case-arg",))
            self.assertNotIn("stdin", samples[0].metadata)
            self.assertNotIn("input", samples[0].metadata)
            self.assertNotIn("expected_stdout", samples[0].metadata)
            self.assertNotIn("expected_output", samples[0].metadata)
            self.assertNotIn("argv", samples[0].metadata)

    def test_prompt_slice_targets_recorded_method_and_caps_at_24(self) -> None:
        with tempfile.TemporaryDirectory(dir=HERE) as temp_raw:
            temp = Path(temp_raw)
            original = temp / "original.java"
            obfuscated = temp / "obfuscated.java"
            original.write_text(JAVA, encoding="utf-8")
            obfuscated.write_text(JAVA, encoding="utf-8")
            sample = runner.Sample("demo", original, obfuscated, "solve", "solve")
            conditions, prompt_meta = runner.prepare_conditions(sample)
            self.assertEqual([entry.name for entry in conditions], list(runner.CONDITIONS))
            self.assertEqual(prompt_meta["recorded_target_method"], "solve")
            self.assertEqual(prompt_meta["target_method"], "solve")
            self.assertLessEqual(prompt_meta["emitted_element_count"], 24)
            prompt_condition = conditions[2]
            codesteer_condition = conditions[3]
            self.assertIn("artifact-conditioned", prompt_condition.instruction)
            self.assertEqual(
                codesteer_condition.instruction,
                conditions[1].instruction,
                "CodeSteer and obfuscated plain must differ only by activation steering",
            )

    def test_codesteer_static_selector_matches_recorded_method(self) -> None:
        analysis = runner.analyze_target_method(JAVA, "solve")
        self.assertEqual(analysis["parse_status"], "javalang")
        self.assertTrue(analysis["recorded_target_found"])
        self.assertEqual(analysis["codesteer_selected_target_method"], "solve")
        self.assertTrue(analysis["codesteer_target_matches_recorded"])
        self.assertEqual(analysis["parameter_count"], 1)
        self.assertEqual(analysis["return_sink_count"], 1)

    def test_actual_prior_vector_and_cases_signal_preflight(self) -> None:
        class TinyTokenizer:
            def __call__(self, text, add_special_tokens=True):
                del add_special_tokens
                self.tokens = re.findall(r"[A-Za-z_][A-Za-z_0-9]*|\d+|\S", text)
                return {"input_ids": list(range(len(self.tokens)))}

            def convert_ids_to_tokens(self, ids):
                return [self.tokens[index] for index in ids]

        class TinyRunner:
            tokenizer = TinyTokenizer()

            @staticmethod
            def _build_prompt(code_snippet, *, instruction, language, answer_prefix=""):
                return f"{instruction}\n\n```{language}\n{code_snippet}\n```{answer_prefix}"

        sample = runner.Sample("demo", Path("o"), Path("x"), "solve", "solve")
        condition = runner.ConditionInput(
            "obfuscated_codesteer",
            "obfuscated",
            Path("x"),
            JAVA,
            "solve",
            runner.build_base_instruction(sample, target_method="solve"),
            {},
            True,
        )
        preflight = runner.codesteer_prior_preflight(TinyRunner(), condition)
        self.assertFalse(preflight["algorithm_fallback_detected"])
        self.assertGreater(preflight["algorithm_vs_fallback_l1"], 0.0)
        self.assertTrue(preflight["case_signal_active"])
        self.assertEqual(preflight["parsed_case_ids"], ["c001"])

    def test_plain_and_codesteer_debug_guards(self) -> None:
        plain = runner.ConditionInput(
            "obfuscated_plain", "obfuscated", Path("x"), JAVA, "solve", "prompt", {}, False
        )
        runner.validate_steering_debug(plain, {"enabled": False, "steer_calls": 0})
        steered = runner.ConditionInput(
            "obfuscated_codesteer", "obfuscated", Path("x"), JAVA, "solve", "prompt", {}, True
        )
        runner.validate_steering_debug(
            steered,
            {
                "enabled": True,
                "steer_calls": 10,
                "recency_mix": True,
                "recency_rho": 0.2,
                "recency_window": 64,
                "head_subset_mode": "none",
                "level_call_counts": {
                    "l1_calls": 0,
                    "l2_calls": 10,
                    "l4_calls": 0,
                    "l5_calls": 0,
                },
            },
        )
        with self.assertRaises(RuntimeError):
            runner.validate_steering_debug(plain, {"enabled": True, "steer_calls": 1})


if __name__ == "__main__":
    unittest.main()
