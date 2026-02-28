from __future__ import annotations

import os
import re
import subprocess
import sys
import tempfile
from dataclasses import dataclass
from pathlib import Path


DEFAULT_JAVAC = "/people/cs/x/xxr230000/jdks/jdk-17.0.11+9/bin/javac"
DEFAULT_JAVA = "/people/cs/x/xxr230000/jdks/jdk-17.0.11+9/bin/java"


@dataclass
class RunResult:
    stdout: str
    stderr: str
    exit_code: int
    timeout: bool = False


def _class_name(source: str, path: Path) -> str:
    m = re.search(r"\bpublic\s+class\s+([A-Za-z_][A-Za-z0-9_]*)", source)
    if m:
        return m.group(1)
    m = re.search(r"\bclass\s+([A-Za-z_][A-Za-z0-9_]*)", source)
    if m:
        return m.group(1)
    return path.stem


def run_python(path: Path, timeout_sec: int = 12) -> RunResult:
    env = os.environ.copy()
    env["PYTHONHASHSEED"] = "0"
    try:
        proc = subprocess.run(
            [sys.executable, str(path)],
            capture_output=True,
            text=True,
            timeout=timeout_sec,
            env=env,
        )
        return RunResult(proc.stdout, proc.stderr, proc.returncode, timeout=False)
    except subprocess.TimeoutExpired as exc:
        return RunResult(exc.stdout or "", exc.stderr or "", 124, timeout=True)


def run_java(path: Path, timeout_sec: int = 12, javac_path: str = DEFAULT_JAVAC, java_path: str = DEFAULT_JAVA) -> RunResult:
    source = path.read_text(encoding="utf-8")
    cls = _class_name(source, path)
    with tempfile.TemporaryDirectory(prefix="obf_java_run_") as td:
        td_path = Path(td)
        compile_proc = subprocess.run(
            [javac_path, "-d", str(td_path), str(path)],
            capture_output=True,
            text=True,
        )
        if compile_proc.returncode != 0:
            return RunResult("", compile_proc.stderr, compile_proc.returncode, timeout=False)
        try:
            run_proc = subprocess.run(
                [java_path, "-cp", str(td_path), cls],
                capture_output=True,
                text=True,
                timeout=timeout_sec,
            )
            return RunResult(run_proc.stdout, run_proc.stderr, run_proc.returncode, timeout=False)
        except subprocess.TimeoutExpired as exc:
            return RunResult(exc.stdout or "", exc.stderr or "", 124, timeout=True)


def run_program(path: Path, language: str, timeout_sec: int = 12, javac_path: str = DEFAULT_JAVAC, java_path: str = DEFAULT_JAVA) -> RunResult:
    if language == "python":
        return run_python(path, timeout_sec=timeout_sec)
    if language == "java":
        return run_java(path, timeout_sec=timeout_sec, javac_path=javac_path, java_path=java_path)
    raise ValueError(f"Unsupported language: {language}")
