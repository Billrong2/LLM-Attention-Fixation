from __future__ import annotations

import argparse
import csv
import hashlib
import json
import re
import shutil
import tempfile
from datetime import datetime
from pathlib import Path
from typing import Iterable

from ..core.metadata import write_metadata
from ..core.pipeline import obfuscate_program
from ..harness.equiv import VerifyResult
from ..harness.runners import RunResult, run_program

TECHNIQUE_NAME = {
    "T1": "identifier_renaming",
    "T2": "syntax_layout_noise",
    "T3": "literal_constant_hiding",
    "T4": "expression_substitution",
    "T5": "bogus_control_flow",
    "T6": "control_flow_flattening",
    "T7": "inter_procedural_reshaping",
    "T8": "call_indirection",
}


def _iter_inputs(input_dir: Path, language: str) -> list[Path]:
    ext = ".java" if language == "java" else ".py"
    return sorted(p for p in input_dir.glob(f"*{ext}") if p.is_file())


def _seed_range(spec: str) -> list[int]:
    if ":" in spec:
        a, b = spec.split(":", 1)
        return list(range(int(a), int(b) + 1))
    return [int(x) for x in spec.split(",") if x.strip()]


def _find_java_class_name(source: str) -> str | None:
    m = re.search(r"\bpublic\s+class\s+([A-Za-z_][A-Za-z0-9_]*)", source)
    if m:
        return m.group(1)
    m = re.search(r"\bclass\s+([A-Za-z_][A-Za-z0-9_]*)", source)
    return m.group(1) if m else None


def _build_obfuscated_class_name(original: str, seed: int, technique: str | None, difficulty: str | None) -> str:
    h = hashlib.sha1(f"{original}|{seed}|{technique}|{difficulty}".encode("utf-8")).hexdigest()[:8]
    return f"C_{h}"


def _should_rename_class(policy: str, difficulty: str | None) -> bool:
    p = policy.lower()
    if p == "never":
        return False
    if p == "always":
        return True
    return (difficulty or "").lower() == "hard"


def _apply_java_class_rename(
    source: str,
    seed: int,
    technique: str | None,
    difficulty: str | None,
) -> tuple[str, str | None, bool, str]:
    old = _find_java_class_name(source)
    if not old:
        return source, None, False, "rename_skipped_no_class"
    new = _build_obfuscated_class_name(old, seed, technique, difficulty)
    if new == old:
        return source, old, False, "rename_skipped_same_name"

    out = source
    out, n1 = re.subn(
        rf"(\bpublic\s+class\s+){re.escape(old)}(\b)",
        rf"\g<1>{new}\g<2>",
        out,
        count=1,
    )
    if n1 == 0:
        out, n1 = re.subn(
            rf"(\bclass\s+){re.escape(old)}(\b)",
            rf"\g<1>{new}\g<2>",
            out,
            count=1,
        )
    if n1 == 0:
        return source, old, False, "rename_failed_class_decl"

    # Rename all class symbol references (types, constructors, same-file uses).
    out = re.sub(rf"\b{re.escape(old)}\b", new, out)
    return out, new, True, "renamed"


def _java_method_coverage(original_source: str, obfuscated_source: str) -> dict[str, object]:
    from ..java.passes.utils import method_coverage_stats

    return method_coverage_stats(original_source=original_source, transformed_source=obfuscated_source)


def _coverage_ok(coverage: dict[str, object], policy: str) -> tuple[bool, str]:
    if policy != "force_all":
        return True, "ok"
    total = int(coverage.get("method_coverage_total", 0))
    touched = int(coverage.get("method_coverage_touched", 0))
    main_touched = bool(coverage.get("main_touched", False))
    errs: list[str] = []
    if touched < total:
        errs.append("method_coverage_incomplete")
    if total > 0 and not main_touched:
        errs.append("main_not_touched")
    if errs:
        return False, ",".join(errs)
    return True, "ok"


def _merge_details(primary: str, secondary: str) -> str:
    p = [x for x in primary.split(",") if x and x != "ok"]
    s = [x for x in secondary.split(",") if x and x != "ok"]
    merged = list(dict.fromkeys(p + s))
    return ",".join(merged) if merged else "ok"


def _verify_against_baseline(
    original: Path,
    obfuscated_source: str,
    language: str,
    baseline_cache: dict[str, RunResult],
    timeout_sec: int,
    javac_path: str,
    java_path: str,
) -> VerifyResult:
    key = str(original.resolve())
    if key not in baseline_cache:
        baseline_cache[key] = run_program(
            original,
            language,
            timeout_sec=timeout_sec,
            javac_path=javac_path,
            java_path=java_path,
        )
    orig = baseline_cache[key]

    suffix = ".java" if language == "java" else ".py"
    with tempfile.TemporaryDirectory(prefix="obf_equiv_cached_") as td:
        stem = original.stem
        if language == "java":
            stem = _find_java_class_name(obfuscated_source) or original.stem
        obf_path = Path(td) / f"{stem}{suffix}"
        obf_path.write_text(obfuscated_source, encoding="utf-8")
        obf = run_program(
            obf_path,
            language,
            timeout_sec=timeout_sec,
            javac_path=javac_path,
            java_path=java_path,
        )

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


def _out_path(
    out_root: Path,
    language: str,
    technique: str,
    difficulty: str,
    seed: int,
    include_seed_dir: bool,
    program: Path,
    out_stem: str,
) -> Path:
    ext = program.suffix
    tname = TECHNIQUE_NAME.get(technique, technique.lower())
    base = out_root / language / program.stem / tname / difficulty.lower()
    if include_seed_dir:
        base = base / f"seed_{seed}"
    return base / f"{out_stem}{ext}"


def _find_fixing_pass(
    original: Path,
    language: str,
    profile: str,
    mode: str,
    level: str | None,
    technique: str | None,
    difficulty: str | None,
    seed: int,
    config_root: Path,
    timeout_sec: int,
    disabled: set[str],
    javac_path: str,
    java_path: str,
    applied_pass_names: list[str],
    baseline_cache: dict[str, RunResult],
    method_coverage_policy: str,
) -> str | None:
    original_source = original.read_text(encoding="utf-8")
    for p in applied_pass_names:
        if p in disabled:
            continue
        cand = set(disabled)
        cand.add(p)
        attempt = obfuscate_program(
            source=original_source,
            language=language,
            profile=profile,
            seed=seed,
            mode=mode,
            level=level,
            technique=technique,
            difficulty=difficulty,
            program_id=original.stem,
            config_root=config_root,
            disabled_passes=cand,
            method_coverage_policy=method_coverage_policy,
        )
        vr = _verify_against_baseline(
            original=original,
            obfuscated_source=attempt.source,
            language=language,
            baseline_cache=baseline_cache,
            timeout_sec=timeout_sec,
            javac_path=javac_path,
            java_path=java_path,
        )
        if not vr.ok:
            continue
        if language == "java":
            coverage = _java_method_coverage(original_source=original_source, obfuscated_source=attempt.source)
            coverage_ok, _ = _coverage_ok(coverage, method_coverage_policy)
            if not coverage_ok:
                continue
        return p
    return None


def _mode_iter(levels: Iterable[str], techniques: Iterable[str], difficulties: Iterable[str], mode: str):
    if mode in {"level", "both"}:
        for lv in levels:
            yield ("level", lv, None, None)
    if mode in {"technique", "both"}:
        for t in techniques:
            for d in difficulties:
                yield ("technique", None, t, d)


def _fail_category(details: str) -> str:
    if details == "ok":
        return "ok"
    if "method_coverage_incomplete" in details:
        return "method_coverage_incomplete"
    if "main_not_touched" in details:
        return "main_not_touched"
    if "stdout_mismatch" in details:
        return "stdout_mismatch"
    if "stderr_mismatch" in details:
        return "stderr_mismatch"
    if "exitcode_mismatch" in details:
        return "exitcode_mismatch"
    if "timeout" in details:
        return "timeout"
    return "other"


def generate_dataset(
    language: str,
    input_dir: Path,
    out_root: Path,
    profile: str,
    levels: list[str],
    techniques: list[str],
    difficulties: list[str],
    seeds: list[int],
    mode: str,
    timeout_sec: int,
    config_root: Path,
    clean: bool,
    strict: bool,
    javac_path: str,
    java_path: str,
    class_rename_policy: str = "hard_only",
    method_coverage_policy: str = "force_all",
    equiv_policy: str = "exact",
) -> dict:
    if language == "java" and mode != "technique":
        raise RuntimeError("Java dataset flow is technique-only. Use --mode technique.")
    if equiv_policy != "exact":
        raise RuntimeError("Only --equiv-policy exact is supported in strict dataset generation.")

    if clean and out_root.exists():
        shutil.rmtree(out_root)
    out_root.mkdir(parents=True, exist_ok=True)

    inputs = _iter_inputs(input_dir, language)
    if not inputs:
        raise RuntimeError(f"No input files found in {input_dir} for language={language}")

    rows_details: list[dict] = []
    fail_count_inline = 0
    fail_count_post = 0
    baseline_cache: dict[str, RunResult] = {}
    include_seed_dir = len(seeds) > 1

    for mode_kind, level, technique, difficulty in _mode_iter(levels, techniques, difficulties, mode):
        for seed in seeds:
            for prog in inputs:
                label = (
                    f"mode={mode_kind} level={level or '-'} technique={technique or '-'} "
                    f"difficulty={difficulty or '-'} seed={seed} program={prog.stem}"
                )
                print(f"[obfuscation] start {label}", flush=True)
                original_source = prog.read_text(encoding="utf-8")
                disabled: set[str] = set()
                class_rename_disabled = False

                last_result = None
                last_source = ""
                last_vr = None
                last_cov: dict[str, object] = {}
                last_class_renamed = False
                last_original_class = _find_java_class_name(original_source) if language == "java" else None
                last_obfuscated_class = last_original_class
                last_details = "not_run"

                for _attempt in range(4):
                    result = obfuscate_program(
                        source=original_source,
                        language=language,
                        profile=profile,
                        seed=seed,
                        mode=mode_kind,
                        level=level,
                        technique=technique,
                        difficulty=difficulty,
                        program_id=prog.stem,
                        config_root=config_root,
                        disabled_passes=disabled,
                        method_coverage_policy=method_coverage_policy,
                    )

                    candidate_source = result.source
                    class_renamed = False
                    obf_class = last_original_class

                    if (
                        language == "java"
                        and mode_kind == "technique"
                        and _should_rename_class(class_rename_policy, difficulty)
                        and not class_rename_disabled
                    ):
                        renamed_source, renamed_class, renamed, _rename_reason = _apply_java_class_rename(
                            source=candidate_source,
                            seed=seed,
                            technique=technique,
                            difficulty=difficulty,
                        )
                        if renamed:
                            candidate_source = renamed_source
                            obf_class = renamed_class or obf_class
                            class_renamed = True

                    vr = _verify_against_baseline(
                        original=prog,
                        obfuscated_source=candidate_source,
                        language=language,
                        baseline_cache=baseline_cache,
                        timeout_sec=timeout_sec,
                        javac_path=javac_path,
                        java_path=java_path,
                    )

                    coverage: dict[str, object] = {}
                    coverage_ok = True
                    coverage_details = "ok"
                    if language == "java":
                        coverage = _java_method_coverage(original_source=original_source, obfuscated_source=candidate_source)
                        coverage_ok, coverage_details = _coverage_ok(coverage, method_coverage_policy)

                    merged_details = _merge_details(vr.details, coverage_details)
                    ok = vr.ok and coverage_ok

                    last_result = result
                    last_source = candidate_source
                    last_vr = vr
                    last_cov = coverage
                    last_class_renamed = class_renamed
                    last_obfuscated_class = obf_class
                    last_details = merged_details

                    if ok:
                        break

                    # If class rename caused failure, retry once with rename disabled.
                    if language == "java" and class_renamed:
                        vr_plain = _verify_against_baseline(
                            original=prog,
                            obfuscated_source=result.source,
                            language=language,
                            baseline_cache=baseline_cache,
                            timeout_sec=timeout_sec,
                            javac_path=javac_path,
                            java_path=java_path,
                        )
                        plain_cov = _java_method_coverage(original_source=original_source, obfuscated_source=result.source)
                        plain_cov_ok, plain_cov_details = _coverage_ok(plain_cov, method_coverage_policy)
                        if vr_plain.ok and plain_cov_ok:
                            class_rename_disabled = True
                            last_source = result.source
                            last_vr = vr_plain
                            last_cov = plain_cov
                            last_class_renamed = False
                            last_obfuscated_class = last_original_class
                            last_details = _merge_details(vr_plain.details, plain_cov_details)
                            continue

                    applied = [p["name"] for p in result.metadata.passes_applied if p.get("applied")]
                    culprit = _find_fixing_pass(
                        original=prog,
                        language=language,
                        profile=profile,
                        mode=mode_kind,
                        level=level,
                        technique=technique,
                        difficulty=difficulty,
                        seed=seed,
                        config_root=config_root,
                        timeout_sec=timeout_sec,
                        disabled=disabled,
                        javac_path=javac_path,
                        java_path=java_path,
                        applied_pass_names=applied,
                        baseline_cache=baseline_cache,
                        method_coverage_policy=method_coverage_policy,
                    )
                    if culprit is None and applied:
                        culprit = applied[0]
                    if culprit is None:
                        break
                    if (
                        language == "java"
                        and mode_kind == "technique"
                        and method_coverage_policy == "force_all"
                        and culprit == (technique or "")
                    ):
                        # Keep the selected technique active in force-all mode; do not "succeed" via disabling it.
                        break
                    disabled.add(culprit)

                assert last_result is not None and last_vr is not None
                last_result.metadata.equivalence = {
                    "stdout_match": last_vr.stdout_match,
                    "stderr_match": last_vr.stderr_match,
                    "exit_match": last_vr.exit_match,
                    "details": last_details,
                }
                last_result.metadata.original_class_name = last_original_class
                last_result.metadata.obfuscated_class_name = last_obfuscated_class
                last_result.metadata.class_renamed = bool(last_class_renamed)
                last_result.metadata.method_coverage_total = int(last_cov.get("method_coverage_total", 0))
                last_result.metadata.method_coverage_touched = int(last_cov.get("method_coverage_touched", 0))
                last_result.metadata.main_touched = bool(last_cov.get("main_touched", False))
                last_result.metadata.untouched_methods = [str(x) for x in last_cov.get("untouched_methods", [])]

                out_stem = prog.stem
                if language == "java":
                    out_stem = last_obfuscated_class or prog.stem
                if mode_kind != "technique":
                    raise RuntimeError("Only technique mode output is supported by this dataset flow.")
                out_path = _out_path(
                    out_root=out_root,
                    language=language,
                    technique=technique or "unknown",
                    difficulty=difficulty or "med",
                    seed=seed,
                    include_seed_dir=include_seed_dir,
                    program=prog,
                    out_stem=out_stem,
                )
                out_path.parent.mkdir(parents=True, exist_ok=True)
                out_path.write_text(last_source, encoding="utf-8")
                write_metadata(out_path.with_suffix(out_path.suffix + ".meta.json"), last_result.metadata)

                ok = (
                    last_vr.stdout_match
                    and last_vr.stderr_match
                    and last_vr.exit_match
                    and _coverage_ok(last_cov, method_coverage_policy)[0]
                )
                if not ok:
                    fail_count_inline += 1

                rows_details.append(
                    {
                        "program_id": prog.stem,
                        "language": language,
                        "mode": mode_kind,
                        "level": level or "",
                        "technique": technique or "",
                        "difficulty": difficulty or "",
                        "seed": seed,
                        "out_path": str(out_path),
                        "original_path": str(prog),
                        "ok": ok,
                        "details": last_details,
                        "fail_category": _fail_category(last_details),
                        "disabled_for_retry": ";".join(sorted(disabled)),
                        "class_renamed": bool(last_class_renamed),
                        "original_class_name": last_original_class or "",
                        "obfuscated_class_name": last_obfuscated_class or "",
                        "method_coverage_total": int(last_cov.get("method_coverage_total", 0)),
                        "method_coverage_touched": int(last_cov.get("method_coverage_touched", 0)),
                        "main_touched": bool(last_cov.get("main_touched", False)),
                        "untouched_methods": ";".join(str(x) for x in last_cov.get("untouched_methods", [])),
                        "equiv_policy": equiv_policy,
                    }
                )
                print(
                    f"[obfuscation] done  {label} ok={ok} disabled={';'.join(sorted(disabled)) or '-'}",
                    flush=True,
                )

    # Post-generation full sweep over on-disk artifacts.
    for row in rows_details:
        original = Path(row["original_path"])
        source = Path(row["out_path"]).read_text(encoding="utf-8")
        vr = _verify_against_baseline(
            original=original,
            obfuscated_source=source,
            language=language,
            baseline_cache=baseline_cache,
            timeout_sec=timeout_sec,
            javac_path=javac_path,
            java_path=java_path,
        )
        post_details = vr.details
        post_ok = vr.ok
        if language == "java":
            cov = _java_method_coverage(original_source=original.read_text(encoding="utf-8"), obfuscated_source=source)
            cov_ok, cov_details = _coverage_ok(cov, method_coverage_policy)
            post_ok = post_ok and cov_ok
            post_details = _merge_details(post_details, cov_details)
        row["post_ok"] = post_ok
        row["post_details"] = post_details
        row["post_fail_category"] = _fail_category(post_details)
        if not post_ok:
            fail_count_post += 1

    reports_dir = config_root / "reports"
    reports_dir.mkdir(parents=True, exist_ok=True)
    ts = datetime.now().strftime("%Y%m%d-%H%M%S")

    details_csv = reports_dir / f"verify_details_{ts}.csv"
    with details_csv.open("w", encoding="utf-8", newline="") as f:
        w = csv.DictWriter(f, fieldnames=list(rows_details[0].keys()))
        w.writeheader()
        w.writerows(rows_details)

    summary_map: dict[tuple[str, str, str, str], dict] = {}
    for r in rows_details:
        key = (r["mode"], r["level"], r["technique"], r["difficulty"])
        slot = summary_map.setdefault(
            key,
            {
                "mode": r["mode"],
                "level": r["level"],
                "technique": r["technique"],
                "difficulty": r["difficulty"],
                "total": 0,
                "ok": 0,
                "failed": 0,
                "post_failed": 0,
                "class_renamed_count": 0,
            },
        )
        slot["total"] += 1
        slot["ok"] += 1 if r["ok"] else 0
        slot["failed"] += 0 if r["ok"] else 1
        slot["post_failed"] += 0 if r.get("post_ok") else 1
        slot["class_renamed_count"] += 1 if r.get("class_renamed") else 0

    summary_rows = list(summary_map.values())
    summary_csv = reports_dir / f"verify_summary_{ts}.csv"
    with summary_csv.open("w", encoding="utf-8", newline="") as f:
        w = csv.DictWriter(f, fieldnames=list(summary_rows[0].keys()))
        w.writeheader()
        w.writerows(summary_rows)

    failure_clusters: dict[str, int] = {}
    for r in rows_details:
        if r.get("post_ok"):
            continue
        key = f"{r['technique']}|{r['difficulty']}|{r['program_id']}|{r.get('post_fail_category', 'other')}"
        failure_clusters[key] = failure_clusters.get(key, 0) + 1

    fail_count_total = fail_count_inline + fail_count_post
    report_json = reports_dir / f"verify_{ts}.json"
    report = {
        "language": language,
        "profile": profile,
        "mode": mode,
        "levels": levels,
        "techniques": techniques,
        "difficulties": difficulties,
        "seeds": seeds,
        "strict": strict,
        "class_rename_policy": class_rename_policy,
        "method_coverage_policy": method_coverage_policy,
        "equiv_policy": equiv_policy,
        "fail_count_inline": fail_count_inline,
        "fail_count_post": fail_count_post,
        "fail_count_total": fail_count_total,
        "details_csv": str(details_csv),
        "summary_csv": str(summary_csv),
        "failure_clusters": failure_clusters,
    }
    report_json.write_text(json.dumps(report, indent=2, sort_keys=True), encoding="utf-8")

    if strict and fail_count_total > 0:
        raise RuntimeError(f"Verification failures: {fail_count_total}. See {report_json}")
    return report


def main() -> None:
    ap = argparse.ArgumentParser(description="Generate deterministic obfuscation datasets with equivalence checks.")
    ap.add_argument("--lang", choices=["java", "python"], required=True)
    ap.add_argument("--input-dir", required=True)
    ap.add_argument("--out-root", default="eyetracking/obfuscation/source")
    ap.add_argument("--profile", default="safe")
    ap.add_argument("--mode", choices=["level", "technique", "both"], default="both")
    ap.add_argument("--levels", default="level0,level1,level2,level3,level4,level5")
    ap.add_argument("--techniques", default="T1,T2,T3,T4,T5,T6,T7,T8")
    ap.add_argument("--difficulties", default="easy,med,hard")
    ap.add_argument("--seeds", default="1:1")
    ap.add_argument("--timeout-sec", type=int, default=12)
    ap.add_argument("--strict", choices=["on", "off"], default="on")
    ap.add_argument("--clean", choices=["on", "off"], default="on")
    ap.add_argument("--config-root", default="eyetracking/obfuscation")
    ap.add_argument("--javac-path", default="/people/cs/x/xxr230000/jdks/jdk-17.0.11+9/bin/javac")
    ap.add_argument("--java-path", default="/people/cs/x/xxr230000/jdks/jdk-17.0.11+9/bin/java")
    ap.add_argument("--class-rename-policy", choices=["hard_only", "never", "always"], default="hard_only")
    ap.add_argument("--method-coverage-policy", choices=["force_all", "best_effort"], default="force_all")
    ap.add_argument("--equiv-policy", choices=["exact"], default="exact")
    args = ap.parse_args()

    report = generate_dataset(
        language=args.lang,
        input_dir=Path(args.input_dir),
        out_root=Path(args.out_root),
        profile=args.profile,
        levels=[x.strip().lower() for x in args.levels.split(",") if x.strip()],
        techniques=[x.strip() for x in args.techniques.split(",") if x.strip()],
        difficulties=[x.strip() for x in args.difficulties.split(",") if x.strip()],
        seeds=_seed_range(args.seeds),
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


if __name__ == "__main__":
    main()
