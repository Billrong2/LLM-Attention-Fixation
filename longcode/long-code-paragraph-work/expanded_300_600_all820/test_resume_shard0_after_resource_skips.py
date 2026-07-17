from __future__ import annotations

import importlib.util
import unittest
from pathlib import Path
from types import SimpleNamespace


HERE = Path(__file__).resolve().parent
SPEC = importlib.util.spec_from_file_location(
    "resume_shard0_after_resource_skips",
    HERE / "resume_shard0_after_resource_skips.py",
)
assert SPEC is not None and SPEC.loader is not None
resume = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(resume)


class ResumeSkipTests(unittest.TestCase):
    def test_registered_contract_validates_without_inference(self) -> None:
        payloads = resume.validate_registered_markers()
        self.assertEqual(set(payloads), set(resume.MARKER_SHA256))
        argv = resume.registered_runner_argv()
        self.assertIn("--gpu-id", argv)
        self.assertIn("--program-ids", argv)
        self.assertIn("--output-root", argv)

    def test_only_two_exact_paths_and_fingerprints_are_consumed(self) -> None:
        delegated: list[tuple[Path, str]] = []

        def original(path: Path, fingerprint: str) -> bool:
            delegated.append((path, fingerprint))
            return False

        fake = SimpleNamespace(record_complete=original)
        payloads = resume.validate_registered_markers()
        consumed, saved = resume.install_skip_predicate(fake, payloads)
        self.assertIs(saved, original)

        unrelated = resume.SHARD_ROOT / "runs" / "other" / "trial_001" / "original_plain" / "record.json"
        self.assertFalse(fake.record_complete(unrelated, "a" * 64))
        self.assertEqual(delegated, [(unrelated, "a" * 64)])
        self.assertEqual(consumed, set())

        with self.assertRaises(resume.ResumeError):
            fake.record_complete(resume.canonical_record("obfuscated_plain"), "b" * 64)
        self.assertEqual(consumed, set())

        for condition, fingerprint in resume.FINGERPRINTS.items():
            self.assertTrue(fake.record_complete(resume.canonical_record(condition), fingerprint))
        resume.validate_postcondition(consumed)

    def test_check_only_leaves_index_and_markers_unchanged(self) -> None:
        index = resume.SHARD_ROOT / "results_index.json"
        before_index = resume.sha256_file(index)
        before_markers = {
            condition: resume.sha256_file(resume.marker_dir(condition) / "resource_skip.json")
            for condition in resume.MARKER_SHA256
        }
        resume.check_only()
        self.assertEqual(resume.sha256_file(index), before_index)
        self.assertEqual(
            {
                condition: resume.sha256_file(resume.marker_dir(condition) / "resource_skip.json")
                for condition in resume.MARKER_SHA256
            },
            before_markers,
        )


if __name__ == "__main__":
    unittest.main()
