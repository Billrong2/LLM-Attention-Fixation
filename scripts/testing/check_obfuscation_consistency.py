#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import subprocess
import sys
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[2]
if str(PROJECT_ROOT.parent) not in sys.path:
    sys.path.insert(0, str(PROJECT_ROOT.parent))

from eyetracking.obfuscation.verify import verify_obfuscation_dataset
from eyetracking.paths import resolve_eyetracking_source_root


def _assert(cond: bool, msg: str) -> None:
    if not cond:
        raise AssertionError(msg)


def run_subset_generation_check(python_exe: str, report_dir: Path) -> None:
    # Small subset generation+verify (fast): one technique and two snippets.
    cmd = [
        python_exe,
        "-m",
        "eyetracking.obfuscation.dataset",
        "--techniques",
        "1",
        "--overwrite",
        "--verify",
        "on",
        "--strict-verify",
        "on",
        "--verify-timeout-sec",
        "6",
        "--report-dir",
        str(report_dir),
    ]
    proc = subprocess.run(cmd, cwd=str(PROJECT_ROOT.parent), capture_output=True, text=True, check=False)
    _assert(proc.returncode == 0, f"subset generation strict verify failed:\n{proc.stderr}\n{proc.stdout}")


def run_direct_verify(report_dir: Path) -> None:
    source_dir = resolve_eyetracking_source_root(PROJECT_ROOT)
    obf_root = PROJECT_ROOT / "obfuscation" / "source"
    javac_path = "/people/cs/x/xxr230000/jdks/jdk-17.0.11+9/bin/javac"
    java_path = "/people/cs/x/xxr230000/jdks/jdk-17.0.11+9/bin/java"

    # Full verify over all techniques; should pass on current corpus.
    rep = verify_obfuscation_dataset(
        source_dir=source_dir,
        obf_root=obf_root,
        techniques=range(1, 13),
        javac_path=javac_path,
        java_path=java_path,
        timeout_sec=8,
        exact_stdout=True,
        strict_verify=True,
        report_dir=report_dir,
    )
    _assert(rep.total_failures == 0, f"expected clean verification, got failures={rep.total_failures}")

    # Non-strict mode should still return report object even when we inject a temporary mismatch.
    tmp = obf_root / "technique1" / "Ackerman.java"
    backup = tmp.read_text(encoding="utf-8")
    try:
        tampered = backup.replace("System.out.println(5);", "System.out.println(999);")
        tmp.write_text(tampered, encoding="utf-8")

        rep2 = verify_obfuscation_dataset(
            source_dir=source_dir,
            obf_root=obf_root,
            techniques=[1],
            javac_path=javac_path,
            java_path=java_path,
            timeout_sec=8,
            exact_stdout=True,
            strict_verify=False,
            report_dir=report_dir,
        )
        _assert(rep2.total_failures > 0, "expected non-strict report to capture injected mismatch")
    finally:
        tmp.write_text(backup, encoding="utf-8")


def main() -> None:
    parser = argparse.ArgumentParser(description="Regression checks for obfuscation dataset strict verifier")
    parser.add_argument(
        "--python",
        default="/people/cs/x/xxr230000/anaconda3/bin/python",
        help="Python executable used for module-run checks",
    )
    parser.add_argument(
        "--report-dir",
        type=Path,
        default=(PROJECT_ROOT / "obfuscation" / "reports"),
    )
    args = parser.parse_args()

    run_subset_generation_check(args.python, args.report_dir)
    run_direct_verify(args.report_dir)

    print("[OK] obfuscation consistency checks passed")


if __name__ == "__main__":
    main()
