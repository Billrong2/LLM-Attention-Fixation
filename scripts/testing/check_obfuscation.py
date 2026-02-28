#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import subprocess
import sys
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[2]
PARENT_ROOT = PROJECT_ROOT.parent
if str(PARENT_ROOT) not in sys.path:
    sys.path.insert(0, str(PARENT_ROOT))

from eyetracking.obfuscation.engine import obfuscate_code_with_report
from eyetracking.obfuscation.registry import available_passes, PASS_REGISTRY
from eyetracking.obfuscation.types import ObfuscationConfig
from eyetracking.obfuscation.passes.base import ObfuscationPass, PassContext


PY_SNIPPET = """
def add(a, b):
    x = a + 1
    y = b - 1
    print(x + y)
    return x + y
""".strip() + "\n"

JAVA_SNIPPET = """
class Demo {
    public static void main(String[] args) {
        int x = 1;
        int y = 2;
        System.out.println(x + y);
    }
}
""".strip() + "\n"


class _InvalidPass(ObfuscationPass):
    name = "zz_invalid_test"

    def apply(self, code: str, ctx: PassContext):
        del code, ctx
        return "def ???", {"edit_count": 1}


def _assert(cond: bool, message: str) -> None:
    if not cond:
        raise AssertionError(message)


def run_single_passes() -> None:
    for lang, snippet in (("python", PY_SNIPPET), ("java", JAVA_SNIPPET)):
        for p in available_passes():
            cfg = ObfuscationConfig(
                passes=[p],
                profile="safe",
                validate=True,
                emit_metadata=True,
                strict_fail_on_invalid=False,
            )
            res = obfuscate_code_with_report(snippet, lang, cfg)
            _assert(bool(res.pass_reports), f"missing report for pass={p} lang={lang}")
            _assert(res.pass_reports[0].pass_name == p, f"wrong report order for pass={p} lang={lang}")
            _assert(res.final_validation is None or res.final_validation.valid, f"final validation failed for {p} {lang}")


def run_full_pipeline() -> None:
    for lang, snippet in (("python", PY_SNIPPET), ("java", JAVA_SNIPPET)):
        cfg = ObfuscationConfig(profile="safe", validate=True, emit_metadata=True, strict_fail_on_invalid=False)
        res = obfuscate_code_with_report(snippet, lang, cfg)
        _assert(len(res.pass_reports) == len(available_passes()), f"full pipeline did not execute all passes for {lang}")
        _assert(res.final_validation is None or res.final_validation.valid, f"full pipeline invalid for {lang}")
        _assert(res.metadata.metadata_path is not None, f"metadata missing for {lang}")
        payload = json.loads(Path(res.metadata.metadata_path).read_text(encoding="utf-8"))
        _assert("pass_reports" in payload, f"metadata pass_reports missing for {lang}")


def run_determinism() -> None:
    cfg = ObfuscationConfig(profile="safe", seed=1337, validate=True, emit_metadata=False, strict_fail_on_invalid=False)
    a = obfuscate_code_with_report(PY_SNIPPET, "python", cfg)
    b = obfuscate_code_with_report(PY_SNIPPET, "python", cfg)
    _assert(a.code == b.code, "determinism violated for identical config/seed")


def run_validation_rollback() -> None:
    PASS_REGISTRY[_InvalidPass.name] = _InvalidPass
    try:
        cfg = ObfuscationConfig(
            passes=[_InvalidPass.name],
            profile="safe",
            validate=True,
            emit_metadata=False,
            strict_fail_on_invalid=False,
        )
        res = obfuscate_code_with_report(PY_SNIPPET, "python", cfg)
        _assert(res.code == PY_SNIPPET, "rollback did not restore original code")
        _assert(res.pass_reports[0].rolled_back, "invalid pass should be marked rolled_back")
    finally:
        PASS_REGISTRY.pop(_InvalidPass.name, None)


def run_cli_api_parity(python_exe: str) -> None:
    cfg = ObfuscationConfig(
        passes=["identifier_renaming", "api_indirection"],
        profile="safe",
        seed=1337,
        validate=True,
        emit_metadata=False,
        strict_fail_on_invalid=False,
    )
    api_res = obfuscate_code_with_report(PY_SNIPPET, "python", cfg)

    cmd = [
        python_exe,
        "-m",
        "eyetracking.obfuscation.cli",
        "--language",
        "python",
        "--passes",
        "identifier_renaming,api_indirection",
        "--profile",
        "safe",
        "--seed",
        "1337",
        "--validate",
        "on",
        "--emit-metadata",
        "off",
        "--strict-fail-on-invalid",
        "off",
    ]
    proc = subprocess.run(
        cmd,
        input=PY_SNIPPET,
        text=True,
        capture_output=True,
        check=False,
        cwd=str(PARENT_ROOT),
    )
    _assert(proc.returncode == 0, f"CLI failed: {proc.stderr}")
    _assert(proc.stdout == api_res.code or proc.stdout == api_res.code + "\n", "CLI/API output mismatch")


def run_aggressive_no_crash() -> None:
    cfg = ObfuscationConfig(profile="aggressive", validate=True, emit_metadata=False, strict_fail_on_invalid=False)
    res_py = obfuscate_code_with_report(PY_SNIPPET, "python", cfg)
    res_java = obfuscate_code_with_report(JAVA_SNIPPET, "java", cfg)
    _assert(res_py.code.strip() != "", "aggressive python output empty")
    _assert(res_java.code.strip() != "", "aggressive java output empty")


def main() -> None:
    parser = argparse.ArgumentParser(description="Smoke checks for eyetracking.obfuscation module.")
    parser.add_argument(
        "--python",
        default=str((Path.home() / "anaconda3" / "bin" / "python")),
        help="Python executable used for CLI parity check",
    )
    args = parser.parse_args()

    run_single_passes()
    run_full_pipeline()
    run_determinism()
    run_validation_rollback()
    run_cli_api_parity(args.python)
    run_aggressive_no_crash()

    print("[OK] obfuscation smoke checks passed")


if __name__ == "__main__":
    main()
