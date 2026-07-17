#!/usr/bin/env python3

import sys
import unittest
from pathlib import Path


HERE = Path(__file__).resolve().parent
if str(HERE) not in sys.path:
    sys.path.insert(0, str(HERE))

import prepare_supplemental_cases as supplemental


class SupplementalCriteriaTests(unittest.TestCase):
    def test_rank_key_is_the_frozen_lexicographic_order(self):
        private = supplemental.SupplementalCandidate(
            "private_tests", 9, "x" * 512, "a\nb\nc\n", 512, 6, 3
        )
        generated = supplemental.SupplementalCandidate(
            "generated_tests", 0, "x" * 80, "z\n", 80, 2, 1
        )
        self.assertLess(private.rank_key, generated.rank_key)

        fewer_lines = supplemental.SupplementalCandidate(
            "generated_tests", 8, "x" * 5, "long output\n", 5, 12, 1
        )
        fewer_bytes = supplemental.SupplementalCandidate(
            "generated_tests", 7, "x" * 80, "a\nb\n", 80, 4, 2
        )
        self.assertLess(fewer_lines.rank_key, fewer_bytes.rank_key)

    def test_tractability_boundaries_are_inclusive(self):
        candidate, audit = supplemental.assess_pair(
            suite="generated_tests",
            dataset_test_index=3,
            stdin="x" * 5,
            expected_stdout="y" * 60,
            frozen_pairs=set(),
        )
        self.assertIsNotNone(candidate)
        self.assertEqual(audit["eligibility"], "tractable")

        candidate, audit = supplemental.assess_pair(
            suite="generated_tests",
            dataset_test_index=4,
            stdin="x" * 512,
            expected_stdout="a\nb\nc\n",
            frozen_pairs=set(),
        )
        self.assertIsNotNone(candidate)
        self.assertEqual(candidate.output_lines, 3)

    def test_ineligible_and_frozen_cases_are_excluded(self):
        candidate, audit = supplemental.assess_pair(
            suite="private_tests",
            dataset_test_index=2,
            stdin="12345",
            expected_stdout="ok\n",
            frozen_pairs={("private_tests", 2)},
        )
        self.assertIsNone(candidate)
        self.assertEqual(audit["eligibility"], "excluded_frozen_case")

        candidate, audit = supplemental.assess_pair(
            suite="generated_tests",
            dataset_test_index=2,
            stdin="1234",
            expected_stdout="a\nb\nc\nd\n",
            frozen_pairs=set(),
        )
        self.assertIsNone(candidate)
        self.assertIn("input_size_outside_5_512_bytes", audit["reasons"])
        self.assertIn("expected_output_over_3_lines", audit["reasons"])

    def test_surrogates_are_not_valid_utf8(self):
        valid, size = supplemental.strict_utf8_size("\ud800")
        self.assertFalse(valid)
        self.assertIsNone(size)


if __name__ == "__main__":
    unittest.main()
