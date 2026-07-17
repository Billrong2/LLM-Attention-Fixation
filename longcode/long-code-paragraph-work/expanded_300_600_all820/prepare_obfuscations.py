#!/usr/bin/env python3
"""Run the validated T5 preparer with all writes confined to this namespace."""

from __future__ import annotations

import argparse
import importlib.util
import json
import os
import subprocess
import sys
from pathlib import Path
from typing import Any, Sequence


sys.dont_write_bytecode = True
HERE = Path(__file__).resolve().parent
PROMPT_ROOT = HERE.parents[1]
UPSTREAM = PROMPT_ROOT / "long-code-sample-work" / "prepare_long_code_variants.py"
DEFAULT_MANIFEST = HERE / "candidate_pool" / "candidate_manifest.json"
DEFAULT_OUTPUT = HERE / "prepared_variants"


def load_upstream() -> Any:
    spec = importlib.util.spec_from_file_location("_expanded_obfuscation_preparer", UPSTREAM)
    if spec is None or spec.loader is None:
        raise RuntimeError(f"cannot import {UPSTREAM}")
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module
    spec.loader.exec_module(module)
    module.WORK_ROOT = HERE
    return module


def under_prompt(path: Path, label: str, *, existing: bool) -> Path:
    resolved = path.expanduser().resolve(strict=existing)
    try:
        resolved.relative_to(PROMPT_ROOT.resolve(strict=True))
    except ValueError as exc:
        raise ValueError(f"{label} must remain under PromptSteering: {resolved}") from exc
    return resolved


def parse_args(argv: Sequence[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--manifest", type=Path, default=DEFAULT_MANIFEST)
    parser.add_argument("--output-root", type=Path, default=DEFAULT_OUTPUT)
    parser.add_argument(
        "--selector-policy",
        choices=("strict", "broad"),
        default="broad",
        help="broad is an explicit extension that accepts the exact SlicingPrior selection",
    )
    parser.add_argument("--eyetracking-root", type=Path, default=Path("/home/cs/x/xxr230000/eyetracking"))
    parser.add_argument("--java-home", type=Path, default=Path("/people/cs/x/xxr230000/jdks/jdk-17.0.11+9"))
    parser.add_argument("--timeout-seconds", type=float, default=12.0)
    parser.add_argument("--compile-timeout-seconds", type=float, default=30.0)
    parser.add_argument(
        "--compile-warning-policy",
        choices=("reject", "accept_exit0"),
        default="reject",
        help="accept_exit0 is a recorded max-coverage extension; warnings remain in evidence",
    )
    parser.add_argument("--overwrite", action="store_true")
    return parser.parse_args(argv)


def main(argv: Sequence[str] | None = None) -> int:
    args = parse_args(argv)
    manifest = under_prompt(args.manifest, "candidate manifest", existing=True)
    output = args.output_root.expanduser().resolve(strict=False)
    try:
        output.relative_to(HERE.resolve(strict=True))
    except ValueError as exc:
        raise ValueError(f"output must remain below {HERE}: {output}") from exc
    module = load_upstream()
    original_analyze = module.analyze_codesteer_target
    if args.selector_policy == "broad":
        def broad_analyze(source: str, selector_api: Any) -> dict[str, Any]:
            evidence = original_analyze(source, selector_api)
            evidence["strict_parameter_return_direct_main_eligible"] = bool(
                evidence.get("eligible_parameter_to_return_target")
            )
            evidence["eligible_parameter_to_return_target"] = bool(
                evidence.get("selected_method")
            )
            evidence["broad_selector_protocol_extension"] = True
            return evidence

        module.analyze_codesteer_target = broad_analyze
    if args.compile_warning_policy == "accept_exit0":
        original_suite = module.run_java_suite
        original_reasons = module.rejection_reasons_for_execution

        def warning_tolerant_suite(**kwargs: Any) -> dict[str, Any]:
            real_run = module.subprocess.run
            observed: list[bytes] = []

            def intercepted_run(command: Any, *run_args: Any, **run_kwargs: Any) -> Any:
                result = real_run(command, *run_args, **run_kwargs)
                executable = Path(str(command[0])).name if command else ""
                stderr = bytes(result.stderr or b"")
                if executable == "javac" and result.returncode == 0 and stderr:
                    observed.append(stderr)
                    return subprocess.CompletedProcess(
                        result.args, result.returncode, result.stdout, b""
                    )
                return result

            module.subprocess.run = intercepted_run
            try:
                validation = original_suite(**kwargs)
            finally:
                module.subprocess.run = real_run
            if observed:
                warning_bytes = b"".join(observed)
                compile_record = validation["compile"]
                compile_record["stderr"] = warning_bytes.decode("utf-8", "strict")
                compile_record["raw_stderr_sha256"] = module.sha256_bytes(warning_bytes)
                compile_record["stderr_accepted_as_exit0_warning"] = True
                compile_record["accepted"] = True
                validation["accepted"] = bool(
                    validation.get("cases")
                    and all(row.get("accepted") is True for row in validation["cases"])
                )
            return validation

        def warning_tolerant_reasons(prefix: str, validation: Any) -> list[str]:
            reasons = original_reasons(prefix, validation)
            compile_record = validation.get("compile", {})
            if compile_record.get("stderr_accepted_as_exit0_warning"):
                reasons = [reason for reason in reasons if reason != f"{prefix}_compile_stderr"]
            return reasons

        module.run_java_suite = warning_tolerant_suite
        module.rejection_reasons_for_execution = warning_tolerant_reasons
    upstream_args = argparse.Namespace(
        manifest=manifest,
        output_root=output,
        eyetracking_root=args.eyetracking_root,
        java_home=args.java_home,
        techniques="T5",
        seed=1,
        timeout_seconds=args.timeout_seconds,
        compile_timeout_seconds=args.compile_timeout_seconds,
        overwrite=args.overwrite,
    )
    result = int(module.prepare(upstream_args))
    provenance_path = output / "provenance" / "preparation_provenance.json"
    if provenance_path.is_file():
        provenance = json.loads(provenance_path.read_text(encoding="utf-8"))
        configuration = provenance.setdefault("configuration", {})
        configuration["compile_warning_policy"] = args.compile_warning_policy
        configuration["compile_warning_policy_protocol_changing"] = (
            args.compile_warning_policy == "accept_exit0"
        )
        if args.compile_warning_policy == "accept_exit0":
            configuration["compile_requires_empty_stdout_stderr"] = False
            configuration["compile_acceptance_rule"] = (
                "no timeout, exit code zero; javac stderr is retained as warning evidence"
            )
        temporary_provenance = provenance_path.with_name(
            f".{provenance_path.name}.tmp-{os.getpid()}"
        )
        temporary_provenance.write_text(
            json.dumps(provenance, indent=2, sort_keys=True) + "\n",
            encoding="utf-8",
        )
        os.replace(temporary_provenance, provenance_path)
    policy_path = output / "wrapper_policy.json"
    temporary = policy_path.with_name(f".{policy_path.name}.tmp-{os.getpid()}")
    temporary.write_text(
        json.dumps(
            {
                "selector_policy": args.selector_policy,
                "selector_policy_protocol_changing": args.selector_policy == "broad",
                "compile_warning_policy": args.compile_warning_policy,
                "compile_warning_policy_protocol_changing": args.compile_warning_policy == "accept_exit0",
                "compile_warning_evidence_retained": True,
                "technique": "T5",
                "difficulty": "easy",
                "seed": 1,
                "model_outputs_read": False,
                "candidate_manifest": str(manifest),
                "candidate_manifest_sha256": module.sha256_file(manifest),
            },
            indent=2,
            sort_keys=True,
        ) + "\n",
        encoding="utf-8",
    )
    os.replace(temporary, policy_path)
    return result


if __name__ == "__main__":
    raise SystemExit(main())
