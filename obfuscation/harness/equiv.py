from __future__ import annotations

import tempfile
from dataclasses import dataclass
from pathlib import Path

from .runners import DEFAULT_JAVA, DEFAULT_JAVAC, RunResult, run_program


@dataclass
class VerifyResult:
    stdout_match: bool
    stderr_match: bool
    exit_match: bool
    details: str
    original: RunResult
    obfuscated: RunResult

    @property
    def ok(self) -> bool:
        return self.stdout_match and self.stderr_match and self.exit_match


def verify_equivalence(
    original_path: Path,
    obfuscated_source: str,
    language: str,
    timeout_sec: int = 12,
    javac_path: str = DEFAULT_JAVAC,
    java_path: str = DEFAULT_JAVA,
) -> VerifyResult:
    orig = run_program(original_path, language, timeout_sec=timeout_sec, javac_path=javac_path, java_path=java_path)
    suffix = ".java" if language == "java" else ".py"
    with tempfile.TemporaryDirectory(prefix="obf_equiv_") as td:
        obf_path = Path(td) / (original_path.stem + suffix)
        obf_path.write_text(obfuscated_source, encoding="utf-8")
        obf = run_program(obf_path, language, timeout_sec=timeout_sec, javac_path=javac_path, java_path=java_path)

    stdout_match = orig.stdout == obf.stdout
    stderr_match = orig.stderr == obf.stderr
    exit_match = orig.exit_code == obf.exit_code

    details = []
    if not stdout_match:
        details.append("stdout_mismatch")
    if not stderr_match:
        details.append("stderr_mismatch")
    if not exit_match:
        details.append("exitcode_mismatch")
    if orig.timeout or obf.timeout:
        details.append("timeout")

    return VerifyResult(
        stdout_match=stdout_match,
        stderr_match=stderr_match,
        exit_match=exit_match,
        details=",".join(details) if details else "ok",
        original=orig,
        obfuscated=obf,
    )
