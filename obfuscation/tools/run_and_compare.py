from __future__ import annotations

import argparse
import json
from pathlib import Path

from ..harness.equiv import verify_equivalence


def compare_files(
    language: str,
    original: Path,
    obfuscated: Path,
    timeout_sec: int,
    javac_path: str,
    java_path: str,
) -> dict:
    source = obfuscated.read_text(encoding="utf-8")
    vr = verify_equivalence(
        original_path=original,
        obfuscated_source=source,
        language=language,
        timeout_sec=timeout_sec,
        javac_path=javac_path,
        java_path=java_path,
    )
    return {
        "ok": vr.ok,
        "stdout_match": vr.stdout_match,
        "stderr_match": vr.stderr_match,
        "exit_match": vr.exit_match,
        "details": vr.details,
        "original": {"exit": vr.original.exit_code, "stdout": vr.original.stdout, "stderr": vr.original.stderr},
        "obfuscated": {"exit": vr.obfuscated.exit_code, "stdout": vr.obfuscated.stdout, "stderr": vr.obfuscated.stderr},
    }


def main() -> None:
    ap = argparse.ArgumentParser(description="Compare original vs obfuscated runtime behavior.")
    ap.add_argument("--lang", choices=["java", "python"], required=True)
    ap.add_argument("--original", required=True)
    ap.add_argument("--obfuscated", required=True)
    ap.add_argument("--timeout-sec", type=int, default=12)
    ap.add_argument("--javac-path", default="/people/cs/x/xxr230000/jdks/jdk-17.0.11+9/bin/javac")
    ap.add_argument("--java-path", default="/people/cs/x/xxr230000/jdks/jdk-17.0.11+9/bin/java")
    args = ap.parse_args()

    res = compare_files(
        language=args.lang,
        original=Path(args.original),
        obfuscated=Path(args.obfuscated),
        timeout_sec=args.timeout_sec,
        javac_path=args.javac_path,
        java_path=args.java_path,
    )
    print(json.dumps(res, indent=2, sort_keys=True))
    raise SystemExit(0 if res["ok"] else 1)


if __name__ == "__main__":
    main()
