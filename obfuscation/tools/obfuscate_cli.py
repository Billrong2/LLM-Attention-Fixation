from __future__ import annotations

import argparse
import json
from pathlib import Path

from ..core.metadata import write_metadata
from ..core.pipeline import obfuscate_program
from ..harness.equiv import verify_equivalence
from .dataset_generate import generate_dataset


def _normalize_level_profile(level: str | None, profile: str) -> tuple[str, str]:
    if profile.lower().startswith("level"):
        return profile.lower(), "safe"
    return (level or "level3").lower(), profile


def _cmd_run(args: argparse.Namespace) -> int:
    level, profile = _normalize_level_profile(args.level, args.profile)
    source = Path(args.input).read_text(encoding="utf-8")
    result = obfuscate_program(
        source=source,
        language=args.lang,
        profile=profile,
        seed=args.seed,
        mode=args.mode,
        level=level,
        technique=args.technique,
        difficulty=args.difficulty,
        program_id=Path(args.input).stem,
        config_root=Path(args.config_root),
    )

    out_path = Path(args.output)
    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text(result.source, encoding="utf-8")

    if args.meta:
        write_metadata(Path(args.meta), result.metadata)

    print(json.dumps({"out": str(out_path), "metrics": result.metadata.metrics, "passes": result.metadata.passes_applied}, indent=2))
    return 0


def _cmd_equiv(args: argparse.Namespace) -> int:
    level, profile = _normalize_level_profile(args.level, args.profile)
    source = Path(args.input).read_text(encoding="utf-8")
    result = obfuscate_program(
        source=source,
        language=args.lang,
        profile=profile,
        seed=args.seed,
        mode=args.mode,
        level=level,
        technique=args.technique,
        difficulty=args.difficulty,
        program_id=Path(args.input).stem,
        config_root=Path(args.config_root),
    )
    vr = verify_equivalence(
        original_path=Path(args.input),
        obfuscated_source=result.source,
        language=args.lang,
        timeout_sec=args.timeout_sec,
        javac_path=args.javac_path,
        java_path=args.java_path,
    )
    result.metadata.equivalence = {
        "stdout_match": vr.stdout_match,
        "stderr_match": vr.stderr_match,
        "exit_match": vr.exit_match,
        "details": vr.details,
    }

    if args.output:
        out_path = Path(args.output)
        out_path.parent.mkdir(parents=True, exist_ok=True)
        out_path.write_text(result.source, encoding="utf-8")

    if args.meta:
        write_metadata(Path(args.meta), result.metadata)

    payload = {
        "ok": vr.ok,
        "details": vr.details,
        "stdout_match": vr.stdout_match,
        "stderr_match": vr.stderr_match,
        "exit_match": vr.exit_match,
    }
    print(json.dumps(payload, indent=2, sort_keys=True))
    return 0 if vr.ok else 1


def _cmd_dataset(args: argparse.Namespace) -> int:
    report = generate_dataset(
        language=args.lang,
        input_dir=Path(args.input_dir),
        out_root=Path(args.out_root),
        profile=args.profile,
        levels=[x.strip().lower() for x in args.levels.split(",") if x.strip()],
        techniques=[x.strip() for x in args.techniques.split(",") if x.strip()],
        difficulties=[x.strip() for x in args.difficulties.split(",") if x.strip()],
        seeds=_parse_seed_spec(args.seeds),
        mode=args.mode,
        timeout_sec=args.timeout_sec,
        config_root=Path(args.config_root),
        clean=(args.clean == "on"),
        strict=(args.strict == "on"),
        javac_path=args.javac_path,
        java_path=args.java_path,
        class_rename_policy=args.class_rename_policy,
        method_coverage_policy=args.method_coverage_policy,
        equiv_policy=args.equiv_policy,
    )
    print(json.dumps(report, indent=2, sort_keys=True))
    return 0


def _parse_seed_spec(spec: str) -> list[int]:
    if ":" in spec:
        a, b = spec.split(":", 1)
        return list(range(int(a), int(b) + 1))
    return [int(x) for x in spec.split(",") if x.strip()]


def build_parser() -> argparse.ArgumentParser:
    ap = argparse.ArgumentParser(prog="obfuscate", description="Deterministic source-to-source obfuscation")
    sub = ap.add_subparsers(dest="cmd", required=True)

    run = sub.add_parser("run")
    run.add_argument("--lang", choices=["java", "python"], required=True)
    run.add_argument("--input", required=True)
    run.add_argument("--output", required=True)
    run.add_argument("--meta")
    run.add_argument("--mode", choices=["level", "technique"], default="level")
    run.add_argument("--level", default="level3")
    run.add_argument("--profile", default="safe")
    run.add_argument("--technique")
    run.add_argument("--difficulty", choices=["easy", "med", "hard"], default="med")
    run.add_argument("--seed", type=int, default=1337)
    run.add_argument("--config-root", default="eyetracking/obfuscation")
    run.set_defaults(fn=_cmd_run)

    eq = sub.add_parser("equiv")
    eq.add_argument("--lang", choices=["java", "python"], required=True)
    eq.add_argument("--input", required=True)
    eq.add_argument("--output")
    eq.add_argument("--meta")
    eq.add_argument("--mode", choices=["level", "technique"], default="level")
    eq.add_argument("--level", default="level3")
    eq.add_argument("--profile", default="safe")
    eq.add_argument("--technique")
    eq.add_argument("--difficulty", choices=["easy", "med", "hard"], default="med")
    eq.add_argument("--seed", type=int, default=1337)
    eq.add_argument("--timeout-sec", type=int, default=12)
    eq.add_argument("--javac-path", default="/people/cs/x/xxr230000/jdks/jdk-17.0.11+9/bin/javac")
    eq.add_argument("--java-path", default="/people/cs/x/xxr230000/jdks/jdk-17.0.11+9/bin/java")
    eq.add_argument("--config-root", default="eyetracking/obfuscation")
    eq.set_defaults(fn=_cmd_equiv)

    ds = sub.add_parser("dataset")
    ds.add_argument("--lang", choices=["java", "python"], required=True)
    ds.add_argument("--input-dir", required=True)
    ds.add_argument("--out-root", default="eyetracking/obfuscation/source")
    ds.add_argument("--profile", default="safe")
    ds.add_argument("--mode", choices=["level", "technique", "both"], default="both")
    ds.add_argument("--levels", default="level0,level1,level2,level3,level4,level5")
    ds.add_argument("--techniques", default="T1,T2,T3,T4,T5,T6,T7,T8")
    ds.add_argument("--difficulties", default="easy,med,hard")
    ds.add_argument("--seeds", default="1:1")
    ds.add_argument("--timeout-sec", type=int, default=12)
    ds.add_argument("--strict", choices=["on", "off"], default="on")
    ds.add_argument("--clean", choices=["on", "off"], default="on")
    ds.add_argument("--config-root", default="eyetracking/obfuscation")
    ds.add_argument("--javac-path", default="/people/cs/x/xxr230000/jdks/jdk-17.0.11+9/bin/javac")
    ds.add_argument("--java-path", default="/people/cs/x/xxr230000/jdks/jdk-17.0.11+9/bin/java")
    ds.add_argument("--class-rename-policy", choices=["hard_only", "never", "always"], default="hard_only")
    ds.add_argument("--method-coverage-policy", choices=["force_all", "best_effort"], default="force_all")
    ds.add_argument("--equiv-policy", choices=["exact"], default="exact")
    ds.set_defaults(fn=_cmd_dataset)

    return ap


def main() -> None:
    parser = build_parser()
    args = parser.parse_args()
    raise SystemExit(args.fn(args))


if __name__ == "__main__":
    main()
