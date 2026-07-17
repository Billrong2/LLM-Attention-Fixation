#!/usr/bin/env python3
"""Focused regression tests for long-code variant preparation."""

from __future__ import annotations

import unittest

from prepare_long_code_variants import trim_stdout, trimmed_exact_match


class TrimmedExactOutputTests(unittest.TestCase):
    def test_crlf_and_outer_whitespace_are_ignored(self) -> None:
        self.assertEqual(trim_stdout(" \r\nalpha\r\nbeta\r\n "), "alpha\nbeta")
        self.assertTrue(trimmed_exact_match("\r\nalpha\r\nbeta\r\n", "alpha\nbeta\n"))

    def test_internal_newline_change_is_rejected(self) -> None:
        self.assertFalse(trimmed_exact_match("alpha beta\n", "alpha\nbeta\n"))

    def test_internal_space_change_is_rejected(self) -> None:
        self.assertFalse(trimmed_exact_match("alpha  beta\n", "alpha beta\n"))
        self.assertFalse(trimmed_exact_match("alpha\n beta\n", "alpha\nbeta\n"))


if __name__ == "__main__":
    unittest.main()
