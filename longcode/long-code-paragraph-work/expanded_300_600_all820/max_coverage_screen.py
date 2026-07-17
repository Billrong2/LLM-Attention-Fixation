#!/usr/bin/env python3
"""Outcome-blind maximum-coverage CPU screen for all 820 Java entries.

This is deliberately separate from ``extract_and_validate.py``.  It gives each
entry six distinct inputs by taking strict-bounded dataset cases first, then
the smallest remaining dataset inputs.  The ten CF1569B entries with only five
distinct dataset inputs receive the same fixed, valid synthetic sixth input.

The original program is compiled with JDK 17 and run twice on every input.  A
program's repeated, byte-identical stdout becomes the oracle.  Dataset-output
equality and compiler/runtime diagnostics are retained as evidence; they are
not acceptance requirements.  No model is imported or executed here.
"""

from __future__ import annotations

import argparse
import hashlib
import importlib.util
import json
import os
import shutil
import subprocess
import sys
import tempfile
import time
from collections import Counter
from pathlib import Path
from typing import Any, Iterable, Mapping, Sequence

import pyarrow.parquet as pq


sys.dont_write_bytecode = True
HERE = Path(__file__).resolve().parent
PROMPT_ROOT = HERE.parents[1]
UPSTREAM_PREPARER = PROMPT_ROOT / "long-code-sample-work" / "prepare_long_code_variants.py"
DATASET = PROMPT_ROOT / "long-code-sample-work" / "codecontests-valid-802411c3.parquet"
DATASET_ID = "deepmind/code_contests"
DATASET_REVISION = "802411c3010cb00d1b05bad57ca77365a3c699d6"
DATASET_SHA256 = "02e8c1ccedae716f1e43cc813fcb7823c3db666ea92638820aba80e8cef451ab"
JAVA_HOME = Path("/people/cs/x/xxr230000/jdks/jdk-17.0.11+9")
JAVA_LANGUAGE_CODE = 4
EXPECTED_ENTRY_COUNT = 820
EXPECTED_UNIQUE_SOURCE_COUNT = 813
EXPECTED_PROBLEM_COUNT = 98
MIN_LOC = 300
MAX_LOC = 600
CASES_PER_ENTRY = 6
REPEAT_RUNS = 2
STRICT_BOUNDS = {
    "min_input_bytes": 20,
    "max_input_bytes": 4096,
    "max_output_bytes": 300,
    "max_output_lines": 20,
}
SUITES = ("private_tests", "generated_tests", "public_tests")
SUITE_RANK = {suite: rank for rank, suite in enumerate(SUITES)}
SYNTHETIC_CASE = {
    "id": "cf1569b-three-type2-cycle-v1",
    "input": "1\n3\n222\n",
    "problem_row_index": 99,
    "cf_contest_id": 1569,
    "cf_index": "B",
    "problem_name": "1569_B. Chess Tournament",
    "validity": (
        "One test case, n=3, and all players have type-2 expectations; a "
        "directed three-cycle is a valid outcome in which every player wins once."
    ),
}
SCHEMA_VERSION = "expanded-java-300-600-max-coverage-v1"


class ScreenError(RuntimeError):
    pass


def sha256_bytes(value: bytes) -> str:
    return hashlib.sha256(value).hexdigest()


def sha256_text(value: str) -> str:
    return sha256_bytes(value.encode("utf-8"))


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def atomic_json(path: Path, value: Any) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary = path.with_name(f".{path.name}.tmp-{os.getpid()}")
    temporary.write_text(
        json.dumps(value, ensure_ascii=False, indent=2, sort_keys=True) + "\n",
        encoding="utf-8",
    )
    os.replace(temporary, path)


def local_path(path: Path, label: str, *, must_exist: bool = False) -> Path:
    candidate = path.expanduser()
    candidate = candidate if candidate.is_absolute() else HERE / candidate
    resolved = candidate.resolve(strict=must_exist)
    try:
        resolved.relative_to(HERE.resolve(strict=True))
    except ValueError as exc:
        raise ScreenError(f"{label} must remain below {HERE}: {resolved}") from exc
    return resolved


def load_preparer() -> Any:
    spec = importlib.util.spec_from_file_location("_max_coverage_preparer", UPSTREAM_PREPARER)
    if spec is None or spec.loader is None:
        raise ScreenError(f"cannot import CodeSteer helpers: {UPSTREAM_PREPARER}")
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module
    spec.loader.exec_module(module)
    return module


def entry_id(row_index: int, solution_index: int) -> str:
    return f"cc-valid-r{row_index:03d}-s{solution_index:04d}"


def iter_entries(rows: Sequence[Mapping[str, Any]]) -> Iterable[tuple[int, int, Mapping[str, Any], str]]:
    for row_index, row in enumerate(rows):
        solutions = row.get("solutions") or {}
        for solution_index, (language, source) in enumerate(
            zip(solutions.get("language") or [], solutions.get("solution") or [])
        ):
            if language != JAVA_LANGUAGE_CODE or not isinstance(source, str):
                continue
            if MIN_LOC <= len(source.splitlines()) <= MAX_LOC:
                yield row_index, solution_index, row, source


def is_strict_bounded(stdin: str, stdout: str) -> bool:
    input_size = len(stdin.encode("utf-8"))
    output_size = len(stdout.encode("utf-8"))
    return bool(
        STRICT_BOUNDS["min_input_bytes"] <= input_size <= STRICT_BOUNDS["max_input_bytes"]
        and output_size <= STRICT_BOUNDS["max_output_bytes"]
        and len(stdout.splitlines()) <= STRICT_BOUNDS["max_output_lines"]
    )


def dataset_case_groups(row: Mapping[str, Any]) -> list[dict[str, Any]]:
    """Return one deterministic representative per stdin plus all oracle evidence."""
    grouped: dict[str, list[dict[str, Any]]] = {}
    for suite in SUITES:
        tests = row.get(suite) or {}
        for index, (stdin, stdout) in enumerate(
            zip(tests.get("input") or [], tests.get("output") or [])
        ):
            if not isinstance(stdin, str) or not isinstance(stdout, str) or stdout == "":
                continue
            input_hash = sha256_text(stdin)
            grouped.setdefault(input_hash, []).append(
                {
                    "suite": suite,
                    "index": index,
                    "input": stdin,
                    "dataset_expected_stdout": stdout,
                    "input_sha256": input_hash,
                    "dataset_expected_stdout_sha256": sha256_text(stdout),
                    "input_bytes": len(stdin.encode("utf-8")),
                    "dataset_expected_stdout_bytes": len(stdout.encode("utf-8")),
                    "strict_bounded": is_strict_bounded(stdin, stdout),
                }
            )

    result: list[dict[str, Any]] = []
    for input_hash, references in grouped.items():
        references.sort(key=lambda ref: (SUITE_RANK[ref["suite"]], ref["index"], ref["dataset_expected_stdout_sha256"]))
        representative = dict(references[0])
        representative["dataset_references"] = [
            {
                key: ref[key]
                for key in (
                    "suite",
                    "index",
                    "dataset_expected_stdout_sha256",
                    "dataset_expected_stdout_bytes",
                    "strict_bounded",
                )
            }
            for ref in references
        ]
        expected_hashes = sorted({ref["dataset_expected_stdout_sha256"] for ref in references})
        representative["dataset_expected_stdout_hashes"] = expected_hashes
        representative["dataset_oracle_conflict"] = len(expected_hashes) > 1
        representative["input_sha256"] = input_hash
        result.append(representative)
    return result


def select_six_inputs(row_index: int, row: Mapping[str, Any]) -> list[dict[str, Any]]:
    """Select bounded first, then smallest relaxed inputs, then fixed CF1569B input."""
    groups = dataset_case_groups(row)
    bounded = sorted(
        (case for case in groups if case["strict_bounded"]),
        key=lambda case: (
            SUITE_RANK[case["suite"]],
            abs(case["input_bytes"] - 256),
            -case["input_bytes"],
            case["dataset_expected_stdout_bytes"],
            case["index"],
            case["input_sha256"],
        ),
    )
    selected: list[dict[str, Any]] = []
    selected_hashes: set[str] = set()
    for case in bounded:
        if len(selected) == CASES_PER_ENTRY:
            break
        record = dict(case)
        record["selection_tier"] = "strict_bounded_dataset"
        selected.append(record)
        selected_hashes.add(record["input_sha256"])

    relaxed = sorted(
        (case for case in groups if case["input_sha256"] not in selected_hashes),
        key=lambda case: (
            case["input_bytes"],
            case["dataset_expected_stdout_bytes"],
            SUITE_RANK[case["suite"]],
            case["index"],
            case["input_sha256"],
        ),
    )
    for case in relaxed:
        if len(selected) == CASES_PER_ENTRY:
            break
        record = dict(case)
        record["selection_tier"] = "smallest_relaxed_dataset_supplement"
        selected.append(record)
        selected_hashes.add(record["input_sha256"])

    if len(selected) < CASES_PER_ENTRY:
        identity = (
            row_index,
            row.get("cf_contest_id"),
            row.get("cf_index"),
            row.get("name"),
            len(selected),
        )
        required = (
            SYNTHETIC_CASE["problem_row_index"],
            SYNTHETIC_CASE["cf_contest_id"],
            SYNTHETIC_CASE["cf_index"],
            SYNTHETIC_CASE["problem_name"],
            5,
        )
        if identity != required:
            raise ScreenError(f"unexpected dataset-case shortage: observed {identity}, expected {required}")
        synthetic_input = str(SYNTHETIC_CASE["input"])
        synthetic_hash = sha256_text(synthetic_input)
        if synthetic_hash in selected_hashes:
            raise ScreenError("registered synthetic input duplicates a dataset input")
        selected.append(
            {
                "suite": "synthetic",
                "index": 0,
                "input": synthetic_input,
                "dataset_expected_stdout": None,
                "input_sha256": synthetic_hash,
                "dataset_expected_stdout_sha256": None,
                "input_bytes": len(synthetic_input.encode("utf-8")),
                "dataset_expected_stdout_bytes": None,
                "strict_bounded": False,
                "dataset_references": [],
                "dataset_expected_stdout_hashes": [],
                "dataset_oracle_conflict": False,
                "selection_tier": "fixed_valid_synthetic_supplement",
                "synthetic_provenance": dict(SYNTHETIC_CASE),
            }
        )

    if len(selected) != CASES_PER_ENTRY or len({case["input_sha256"] for case in selected}) != CASES_PER_ENTRY:
        raise ScreenError("selection did not produce exactly six distinct inputs")
    for position, case in enumerate(selected, 1):
        case["selection_position"] = position
    return selected


def clean_env(temp: Path) -> dict[str, str]:
    environment = os.environ.copy()
    for key in ("JAVA_TOOL_OPTIONS", "JDK_JAVA_OPTIONS", "_JAVA_OPTIONS", "CLASSPATH"):
        environment.pop(key, None)
    environment.update(
        {
            "LC_ALL": "C",
            "LANG": "C",
            "HOME": str(temp),
            "TMPDIR": str(temp),
            "TMP": str(temp),
            "TEMP": str(temp),
        }
    )
    return environment


def render_diagnostic(value: bytes) -> dict[str, Any]:
    return {
        "text": value.decode("utf-8", "replace"),
        "bytes": len(value),
        "sha256": sha256_bytes(value),
        "present": bool(value),
    }


def compile_and_derive_oracles(
    *,
    source: str,
    java_entry: Mapping[str, str],
    cases: Sequence[Mapping[str, Any]],
    scratch_root: Path,
    compile_timeout: float,
    run_timeout: float,
) -> tuple[list[dict[str, Any]], str | None, dict[str, Any]]:
    javac = JAVA_HOME / "bin" / "javac"
    java = JAVA_HOME / "bin" / "java"
    with tempfile.TemporaryDirectory(prefix="max-coverage-", dir=scratch_root) as raw:
        temp = Path(raw)
        source_path = temp / f"{java_entry['compile_class']}.java"
        classes = temp / "classes"
        classes.mkdir()
        source_path.write_text(source, encoding="utf-8")
        environment = clean_env(temp)
        compile_command = [
            str(javac),
            "-encoding",
            "UTF-8",
            f"-J-Djava.io.tmpdir={temp}",
            f"-J-Duser.home={temp}",
            "-J-XX:-UsePerfData",
            "-d",
            str(classes),
            str(source_path),
        ]
        started = time.monotonic()
        try:
            compiled = subprocess.run(
                compile_command,
                cwd=temp,
                env=environment,
                stdin=subprocess.DEVNULL,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                timeout=compile_timeout,
                check=False,
            )
            compile_timed_out = False
            compile_stdout = compiled.stdout
            compile_stderr = compiled.stderr
            compile_exit_code: int | None = compiled.returncode
        except subprocess.TimeoutExpired as exc:
            compile_timed_out = True
            compile_stdout = exc.stdout or b""
            compile_stderr = exc.stderr or b""
            compile_exit_code = None
        evidence: dict[str, Any] = {
            "jdk_home": str(JAVA_HOME),
            "compile": {
                "timed_out": compile_timed_out,
                "exit_code": compile_exit_code,
                "duration_seconds": round(time.monotonic() - started, 6),
                "stdout": render_diagnostic(compile_stdout),
                "stderr": render_diagnostic(compile_stderr),
                "diagnostics_are_evidence_not_rejection": True,
            },
            "repeat_runs_per_case": REPEAT_RUNS,
            "cases": [],
        }
        if compile_timed_out:
            return [], "compile_timeout", evidence
        if compile_exit_code != 0:
            return [], "compile_nonzero", evidence

        validated: list[dict[str, Any]] = []
        for case in cases:
            runs: list[dict[str, Any]] = []
            raw_stdouts: list[bytes] = []
            for repeat_index in range(REPEAT_RUNS):
                command = [
                    str(java),
                    "-Dfile.encoding=UTF-8",
                    f"-Djava.io.tmpdir={temp}",
                    f"-Duser.home={temp}",
                    "-XX:-UsePerfData",
                    "-cp",
                    str(classes),
                    java_entry["main_class"],
                ]
                started = time.monotonic()
                try:
                    executed = subprocess.run(
                        command,
                        cwd=temp,
                        env=environment,
                        input=str(case["input"]).encode("utf-8"),
                        stdout=subprocess.PIPE,
                        stderr=subprocess.PIPE,
                        timeout=run_timeout,
                        check=False,
                    )
                    timed_out = False
                    exit_code: int | None = executed.returncode
                    stdout = executed.stdout
                    stderr = executed.stderr
                except subprocess.TimeoutExpired as exc:
                    timed_out = True
                    exit_code = None
                    stdout = exc.stdout or b""
                    stderr = exc.stderr or b""
                runs.append(
                    {
                        "repeat_index": repeat_index,
                        "timed_out": timed_out,
                        "exit_code": exit_code,
                        "duration_seconds": round(time.monotonic() - started, 6),
                        "stdout_bytes": len(stdout),
                        "stdout_sha256": sha256_bytes(stdout),
                        "stderr": render_diagnostic(stderr),
                        "stderr_is_evidence_not_rejection": True,
                    }
                )
                raw_stdouts.append(stdout)
                if timed_out:
                    evidence["cases"].append({"selection_position": case["selection_position"], "runs": runs})
                    return [], f"runtime_timeout_case_{case['selection_position']:03d}", evidence
                if exit_code != 0:
                    evidence["cases"].append({"selection_position": case["selection_position"], "runs": runs})
                    return [], f"runtime_nonzero_case_{case['selection_position']:03d}", evidence
            deterministic = len(set(raw_stdouts)) == 1
            case_evidence = {
                "selection_position": case["selection_position"],
                "input_sha256": case["input_sha256"],
                "deterministic_stdout": deterministic,
                "runs": runs,
            }
            evidence["cases"].append(case_evidence)
            if not deterministic:
                return [], f"nondeterministic_stdout_case_{case['selection_position']:03d}", evidence
            oracle_bytes = raw_stdouts[0]
            oracle_text = oracle_bytes.decode("utf-8", "replace")
            record = dict(case)
            record["oracle_stdout"] = oracle_text
            record["oracle_stdout_sha256"] = sha256_bytes(oracle_bytes)
            record["oracle_stdout_bytes"] = len(oracle_bytes)
            dataset_stdout = case.get("dataset_expected_stdout")
            record["oracle_equals_dataset_expected_stdout"] = (
                oracle_bytes == str(dataset_stdout).encode("utf-8") if dataset_stdout is not None else None
            )
            validated.append(record)
        return validated, None, evidence


def write_candidate(
    *,
    output: Path,
    row_index: int,
    solution_index: int,
    row: Mapping[str, Any],
    source: str,
    java_entry: Mapping[str, str],
    selector: Mapping[str, Any],
    cases: Sequence[Mapping[str, Any]],
) -> dict[str, Any]:
    identifier = entry_id(row_index, solution_index)
    root = output / "candidates" / identifier
    root.mkdir(parents=True, exist_ok=False)
    source_path = root / "original.java"
    source_path.write_text(source, encoding="utf-8")
    io_root = root / "io"
    io_root.mkdir()
    tests: list[dict[str, Any]] = []
    for case in cases:
        position = int(case["selection_position"])
        if case["suite"] == "synthetic":
            suffix = str(SYNTHETIC_CASE["id"])
        else:
            suffix = f"{str(case['suite']).removesuffix('_tests')}-{int(case['index']):03d}"
        case_id = f"case-{position:03d}-{suffix}"
        input_path = io_root / f"{case_id}.in"
        oracle_path = io_root / f"{case_id}.out"
        input_path.write_text(str(case["input"]), encoding="utf-8")
        oracle_path.write_text(str(case["oracle_stdout"]), encoding="utf-8")
        dataset_path: Path | None = None
        if case.get("dataset_expected_stdout") is not None:
            dataset_path = io_root / f"{case_id}.dataset.out"
            dataset_path.write_text(str(case["dataset_expected_stdout"]), encoding="utf-8")
        test = {
            "id": case_id,
            "case_id": case_id,
            "selection_position": position,
            "selection_tier": case["selection_tier"],
            "suite": case["suite"],
            "dataset_test_index": case["index"] if case["suite"] != "synthetic" else None,
            "stdin": case["input"],
            "input": case["input"],
            "expected_stdout": case["oracle_stdout"],
            "oracle_stdout": case["oracle_stdout"],
            "dataset_expected_stdout": case.get("dataset_expected_stdout"),
            "oracle_equals_dataset_expected_stdout": case["oracle_equals_dataset_expected_stdout"],
            "input_sha256": case["input_sha256"],
            "expected_stdout_sha256": case["oracle_stdout_sha256"],
            "oracle_stdout_sha256": case["oracle_stdout_sha256"],
            "dataset_expected_stdout_sha256": case.get("dataset_expected_stdout_sha256"),
            "dataset_expected_stdout_hashes": case.get("dataset_expected_stdout_hashes", []),
            "dataset_oracle_conflict": case.get("dataset_oracle_conflict", False),
            "dataset_references": case.get("dataset_references", []),
            "strict_bounded": case["strict_bounded"],
            "input_path": input_path.relative_to(output).as_posix(),
            "expected_stdout_path": oracle_path.relative_to(output).as_posix(),
            "oracle_stdout_path": oracle_path.relative_to(output).as_posix(),
            "dataset_expected_stdout_path": (
                dataset_path.relative_to(output).as_posix() if dataset_path is not None else None
            ),
            "synthetic_provenance": case.get("synthetic_provenance"),
        }
        tests.append(test)
    provenance = {
        "dataset_id": DATASET_ID,
        "dataset_revision": DATASET_REVISION,
        "split": "valid",
        "row_index": row_index,
        "solution_container": "solutions",
        "solution_index": solution_index,
        "solution_label": "correct human solution",
        "language": "Java",
        "language_code": JAVA_LANGUAGE_CODE,
        "problem_name": row.get("name"),
        "cf_contest_id": row.get("cf_contest_id"),
        "cf_index": row.get("cf_index"),
    }
    record = {
        "id": identifier,
        "original_path": source_path.relative_to(output).as_posix(),
        "source_sha256": sha256_text(source),
        "physical_loc": len(source.splitlines()),
        "main_class": java_entry["main_class"],
        "target_method": selector["selected_method"],
        "tests": tests,
        "cases": tests,
        "provenance": provenance,
        "selector": dict(selector),
        "protocol_extension": {
            "max_coverage_io": True,
            "program_derived_deterministic_oracles": True,
            "broad_codesteer_selector": True,
            "strict_parameter_return_direct_main_eligible": bool(
                selector.get("eligible_parameter_to_return_target")
            ),
        },
    }
    atomic_json(root / "metadata.json", record)
    return record


def append_ledger(path: Path, row: Mapping[str, Any]) -> None:
    with path.open("a", encoding="utf-8") as handle:
        handle.write(json.dumps(row, ensure_ascii=False, sort_keys=True) + "\n")
        handle.flush()
        os.fsync(handle.fileno())


def read_ledger(path: Path) -> dict[str, dict[str, Any]]:
    result: dict[str, dict[str, Any]] = {}
    if not path.is_file():
        return result
    for line_number, line in enumerate(path.read_text(encoding="utf-8").splitlines(), 1):
        if not line.strip():
            continue
        row = json.loads(line)
        identifier = str(row.get("entry_id") or "")
        if not identifier or identifier in result:
            raise ScreenError(f"invalid or duplicate ledger row at line {line_number}: {identifier!r}")
        result[identifier] = row
    return result


def shard_name(shard_index: int, num_shards: int) -> str:
    return f"shard_{shard_index:03d}_of_{num_shards:03d}"


def assigned_entries(
    entries: Sequence[tuple[int, int, Mapping[str, Any], str]],
    num_shards: int,
    shard_index: int,
) -> list[tuple[int, tuple[int, int, Mapping[str, Any], str]]]:
    return [
        (ordinal, entry)
        for ordinal, entry in enumerate(entries, 1)
        if (ordinal - 1) % num_shards == shard_index
    ]


def load_registered_rows(dataset: Path) -> tuple[list[Mapping[str, Any]], list[tuple[int, int, Mapping[str, Any], str]]]:
    dataset = dataset.expanduser().resolve(strict=True)
    observed_hash = sha256_file(dataset)
    if observed_hash != DATASET_SHA256:
        raise ScreenError(f"dataset SHA-256 differs: {observed_hash}")
    rows = pq.read_table(dataset).to_pylist()
    entries = list(iter_entries(rows))
    if len(entries) != EXPECTED_ENTRY_COUNT:
        raise ScreenError(f"expected {EXPECTED_ENTRY_COUNT} entries, found {len(entries)}")
    return rows, entries


def inventory(rows: Sequence[Mapping[str, Any]], entries: Sequence[tuple[int, int, Mapping[str, Any], str]]) -> dict[str, Any]:
    tier_counts: Counter[str] = Counter()
    synthetic_ids: list[str] = []
    supplemented_ids: list[str] = []
    dataset_mismatch_risk_ids: list[str] = []
    for row_index, solution_index, row, _source in entries:
        selected = select_six_inputs(row_index, row)
        tiers = {str(case["selection_tier"]) for case in selected}
        tier_counts.update(str(case["selection_tier"]) for case in selected)
        identifier = entry_id(row_index, solution_index)
        if "smallest_relaxed_dataset_supplement" in tiers:
            supplemented_ids.append(identifier)
        if "fixed_valid_synthetic_supplement" in tiers:
            synthetic_ids.append(identifier)
        if any(case.get("dataset_oracle_conflict") for case in selected):
            dataset_mismatch_risk_ids.append(identifier)
    return {
        "schema_version": f"{SCHEMA_VERSION}-inventory",
        "dataset_id": DATASET_ID,
        "dataset_revision": DATASET_REVISION,
        "dataset_sha256": DATASET_SHA256,
        "loc_range_inclusive": [MIN_LOC, MAX_LOC],
        "entry_count": len(entries),
        "unique_source_text_count": len({source for *_rest, source in entries}),
        "problem_row_count": len({row_index for row_index, *_rest in entries}),
        "cases_per_entry": CASES_PER_ENTRY,
        "selected_case_count": CASES_PER_ENTRY * len(entries),
        "case_selection_tier_counts": dict(sorted(tier_counts.items())),
        "entries_with_relaxed_dataset_supplement": len(supplemented_ids),
        "relaxed_dataset_supplement_entry_ids": supplemented_ids,
        "entries_with_fixed_valid_synthetic_supplement": len(synthetic_ids),
        "fixed_valid_synthetic_supplement_entry_ids": synthetic_ids,
        "fixed_valid_synthetic_case": dict(SYNTHETIC_CASE),
        "selected_entries_with_conflicting_dataset_oracles": len(dataset_mismatch_risk_ids),
        "selection_is_outcome_blind": True,
        "model_inference_performed": False,
    }


def screen_config(args: argparse.Namespace, assigned: Sequence[tuple[int, tuple[int, int, Mapping[str, Any], str]]]) -> dict[str, Any]:
    ids = [entry_id(entry[0], entry[1]) for _ordinal, entry in assigned]
    return {
        "schema_version": f"{SCHEMA_VERSION}-screen-config",
        "dataset_sha256": DATASET_SHA256,
        "selection_policy": "strict_bounded_then_smallest_relaxed_then_registered_cf1569b_synthetic",
        "synthetic_case_input_sha256": sha256_text(str(SYNTHETIC_CASE["input"])),
        "oracle_policy": f"byte_identical_stdout_across_{REPEAT_RUNS}_jdk17_runs",
        "compiler_diagnostics_are_rejection": False,
        "runtime_stderr_is_rejection": False,
        "compile_timeout_seconds": args.compile_timeout_seconds,
        "run_timeout_seconds": args.run_timeout_seconds,
        "num_shards": args.num_shards,
        "shard_index": args.shard_index,
        "shard_name": shard_name(args.shard_index, args.num_shards),
        "assignment_rule": "(global_entry_ordinal - 1) modulo num_shards equals shard_index",
        "global_entry_count": EXPECTED_ENTRY_COUNT,
        "assigned_entry_count": len(assigned),
        "assigned_entry_ids": ids,
        "assigned_entry_ids_sha256": sha256_text("\n".join(ids) + "\n"),
    }


def run_screen(args: argparse.Namespace) -> int:
    rows, entries = load_registered_rows(args.dataset)
    report = inventory(rows, entries)
    output_root = local_path(args.output, "screen output root")
    output = output_root / shard_name(args.shard_index, args.num_shards)
    if output.exists() and args.force:
        shutil.rmtree(output)
    if output.exists() and not args.resume:
        raise ScreenError(f"output exists; pass --resume or --force: {output}")
    output.mkdir(parents=True, exist_ok=True)
    (output / "candidates").mkdir(exist_ok=True)
    scratch = output / ".scratch"
    scratch.mkdir(exist_ok=True)
    ledger_path = output / "entry_ledger.jsonl"
    terminal = read_ledger(ledger_path)
    assigned = assigned_entries(entries, args.num_shards, args.shard_index)
    config = screen_config(args, assigned)
    config_path = output / "screen_config.json"
    if config_path.is_file():
        if json.loads(config_path.read_text(encoding="utf-8")) != config:
            raise ScreenError("screen configuration changed; use a new output or original arguments")
    else:
        if terminal:
            raise ScreenError("cannot adopt a ledger without its frozen screen_config.json")
        atomic_json(config_path, config)
    assigned_ids = set(config["assigned_entry_ids"])
    if not set(terminal).issubset(assigned_ids):
        raise ScreenError("ledger contains entries not assigned to this shard")

    helper = load_preparer()
    selector_api = helper.import_codesteer_selector()
    accepted: dict[str, dict[str, Any]] = {}
    for identifier, ledger in terminal.items():
        if ledger.get("status") != "accepted":
            continue
        metadata_path = output / str(ledger["candidate_metadata_path"])
        if not metadata_path.is_file():
            raise ScreenError(f"accepted ledger row lacks metadata: {identifier}")
        accepted[identifier] = json.loads(metadata_path.read_text(encoding="utf-8"))

    for ordinal, (row_index, solution_index, row, source) in assigned:
        identifier = entry_id(row_index, solution_index)
        if identifier in terminal:
            continue
        print(f"[max-coverage] {ordinal}/{EXPECTED_ENTRY_COUNT} {identifier}", flush=True)
        candidate_dir = output / "candidates" / identifier
        if candidate_dir.exists():
            shutil.rmtree(candidate_dir)
        selected = select_six_inputs(row_index, row)
        # These are infrastructure invariants.  Failing loudly avoids turning a
        # selector/parser defect into an experimental program rejection.
        try:
            selector = helper.analyze_codesteer_target(source, selector_api)
            java_entry = helper.infer_java_entry(source, None)
        except Exception as exc:
            raise ScreenError(f"{identifier}: static preparation failed: {type(exc).__name__}: {exc}") from exc
        validated, rejection_reason, execution = compile_and_derive_oracles(
            source=source,
            java_entry=java_entry,
            cases=selected,
            scratch_root=scratch,
            compile_timeout=args.compile_timeout_seconds,
            run_timeout=args.run_timeout_seconds,
        )
        base = {
            "entry_id": identifier,
            "entry_ordinal": ordinal,
            "row_index": row_index,
            "solution_index": solution_index,
            "source_sha256": sha256_text(source),
            "physical_loc": len(source.splitlines()),
            "selector_policy": "broad_exact_codesteer_selector_protocol_extension",
            "selector": selector,
            "selection_tiers": [case["selection_tier"] for case in selected],
            "selected_input_sha256": [case["input_sha256"] for case in selected],
            "model_outputs_read": False,
            "cpu_shard_index": args.shard_index,
            "cpu_num_shards": args.num_shards,
            "execution": execution,
        }
        if rejection_reason is not None:
            ledger = {
                **base,
                "status": "rejected",
                "stage": "jdk17_compile_runtime_or_determinism",
                "reasons": [rejection_reason],
            }
        else:
            record = write_candidate(
                output=output,
                row_index=row_index,
                solution_index=solution_index,
                row=row,
                source=source,
                java_entry=java_entry,
                selector=selector,
                cases=validated,
            )
            accepted[identifier] = record
            ledger = {
                **base,
                "status": "accepted",
                "stage": "complete",
                "reasons": [],
                "candidate_metadata_path": f"candidates/{identifier}/metadata.json",
                "validated_case_ids": [case["id"] for case in record["tests"]],
                "dataset_stdout_exact_match_count": sum(
                    case["oracle_equals_dataset_expected_stdout"] is True for case in record["tests"]
                ),
                "dataset_stdout_comparison_count": sum(
                    case["oracle_equals_dataset_expected_stdout"] is not None for case in record["tests"]
                ),
            }
        append_ledger(ledger_path, ledger)
        terminal[identifier] = ledger
        atomic_json(
            output / "progress.json",
            {
                "status": "running",
                "completed": len(terminal),
                "accepted": len(accepted),
                "rejected": len(terminal) - len(accepted),
                "total": len(assigned),
                "global_total": EXPECTED_ENTRY_COUNT,
                "shard_index": args.shard_index,
                "num_shards": args.num_shards,
            },
        )

    shutil.rmtree(scratch)
    terminal = read_ledger(ledger_path)
    if set(terminal) != assigned_ids:
        raise ScreenError(f"terminal ledger covers {len(terminal)}/{len(assigned_ids)} assigned entries")
    samples = [accepted[identifier] for identifier in sorted(accepted)]
    reason_counts: Counter[str] = Counter(
        reason for row in terminal.values() for reason in row.get("reasons", [])
    )
    exact_matches = sum(int(row.get("dataset_stdout_exact_match_count", 0)) for row in terminal.values())
    comparisons = sum(int(row.get("dataset_stdout_comparison_count", 0)) for row in terminal.values())
    manifest = {
        "schema_version": f"{SCHEMA_VERSION}-candidate-pool",
        "selection_scope": "outcome-blind maximum-coverage CPU eligibility; no model inference",
        "dataset": report,
        "configuration": config,
        "entry_count": EXPECTED_ENTRY_COUNT,
        "assigned_entry_count": len(assigned),
        "terminal_ledger_count": len(terminal),
        "accepted_count": len(samples),
        "rejected_count": len(assigned) - len(samples),
        "rejection_reason_counts": dict(sorted(reason_counts.items())),
        "dataset_stdout_exact_match_count": exact_matches,
        "dataset_stdout_comparison_count": comparisons,
        "ledger_path": "entry_ledger.jsonl",
        "samples": samples,
    }
    atomic_json(output / "candidate_manifest.json", manifest)
    summary = {key: manifest[key] for key in (
        "entry_count",
        "assigned_entry_count",
        "terminal_ledger_count",
        "accepted_count",
        "rejected_count",
        "rejection_reason_counts",
        "dataset_stdout_exact_match_count",
        "dataset_stdout_comparison_count",
    )}
    atomic_json(output / "summary.json", summary)
    atomic_json(
        output / "progress.json",
        {
            "status": "complete",
            "completed": len(terminal),
            "accepted": len(samples),
            "rejected": len(assigned) - len(samples),
            "total": len(assigned),
            "global_total": EXPECTED_ENTRY_COUNT,
            "shard_index": args.shard_index,
            "num_shards": args.num_shards,
        },
    )
    print(json.dumps(summary, indent=2, sort_keys=True))
    return 0


def copy_candidate(shard: Path, output: Path, identifier: str) -> dict[str, Any]:
    source = shard / "candidates" / identifier
    destination = output / "candidates" / identifier
    if not source.is_dir():
        raise ScreenError(f"missing accepted candidate directory: {source}")
    shutil.copytree(source, destination)
    metadata = destination / "metadata.json"
    record = json.loads(metadata.read_text(encoding="utf-8"))
    if record.get("id") != identifier:
        raise ScreenError(f"metadata ID mismatch for {identifier}")
    if sha256_file(destination / "original.java") != record.get("source_sha256"):
        raise ScreenError(f"source hash mismatch for {identifier}")
    return record


def run_merge(args: argparse.Namespace) -> int:
    _rows, entries = load_registered_rows(args.dataset)
    shard_root = local_path(args.shard_root, "shard root", must_exist=True)
    output = local_path(args.output, "merged output")
    if output.exists() and args.force:
        shutil.rmtree(output)
    if output.exists():
        raise ScreenError(f"merged output exists; choose a new path or pass --force: {output}")
    output.mkdir(parents=True)
    (output / "candidates").mkdir()
    expected_ids = [entry_id(entry[0], entry[1]) for entry in entries]
    rows_by_id: dict[str, dict[str, Any]] = {}
    records_by_id: dict[str, dict[str, Any]] = {}
    configs: list[dict[str, Any]] = []
    for shard_index in range(args.num_shards):
        shard = shard_root / shard_name(shard_index, args.num_shards)
        config_path = shard / "screen_config.json"
        progress_path = shard / "progress.json"
        if not config_path.is_file() or not progress_path.is_file():
            raise ScreenError(f"shard is incomplete or absent: {shard}")
        config = json.loads(config_path.read_text(encoding="utf-8"))
        progress = json.loads(progress_path.read_text(encoding="utf-8"))
        if config.get("schema_version") != f"{SCHEMA_VERSION}-screen-config":
            raise ScreenError(f"unexpected schema in {shard}")
        if config.get("num_shards") != args.num_shards or config.get("shard_index") != shard_index:
            raise ScreenError(f"shard identity mismatch in {shard}")
        if progress.get("status") != "complete":
            raise ScreenError(f"shard progress is not complete: {shard}")
        shard_rows = read_ledger(shard / "entry_ledger.jsonl")
        assigned_ids = list(config.get("assigned_entry_ids") or [])
        if set(shard_rows) != set(assigned_ids) or len(shard_rows) != len(assigned_ids):
            raise ScreenError(f"ledger/assignment mismatch in {shard}")
        overlap = set(rows_by_id).intersection(shard_rows)
        if overlap:
            raise ScreenError(f"duplicate entries across shards: {sorted(overlap)[:3]}")
        rows_by_id.update(shard_rows)
        configs.append(config)
        for identifier, ledger in shard_rows.items():
            if ledger.get("status") == "accepted":
                records_by_id[identifier] = copy_candidate(shard, output, identifier)
    if set(rows_by_id) != set(expected_ids) or len(rows_by_id) != EXPECTED_ENTRY_COUNT:
        raise ScreenError(f"merged shards cover {len(rows_by_id)}/{EXPECTED_ENTRY_COUNT} entries")
    ordered_rows = sorted(rows_by_id.values(), key=lambda row: int(row["entry_ordinal"]))
    if [row["entry_id"] for row in ordered_rows] != expected_ids:
        raise ScreenError("merged ledger ordering does not equal registered dataset ordering")
    ledger_path = output / "entry_ledger.jsonl"
    with ledger_path.open("w", encoding="utf-8") as handle:
        for row in ordered_rows:
            handle.write(json.dumps(row, ensure_ascii=False, sort_keys=True) + "\n")
    samples = [records_by_id[identifier] for identifier in sorted(records_by_id)]
    reasons: Counter[str] = Counter(reason for row in ordered_rows for reason in row.get("reasons", []))
    summary = {
        "entry_count": EXPECTED_ENTRY_COUNT,
        "terminal_ledger_count": len(ordered_rows),
        "accepted_count": len(samples),
        "rejected_count": EXPECTED_ENTRY_COUNT - len(samples),
        "rejection_reason_counts": dict(sorted(reasons.items())),
        "dataset_stdout_exact_match_count": sum(
            int(row.get("dataset_stdout_exact_match_count", 0)) for row in ordered_rows
        ),
        "dataset_stdout_comparison_count": sum(
            int(row.get("dataset_stdout_comparison_count", 0)) for row in ordered_rows
        ),
    }
    manifest = {
        "schema_version": f"{SCHEMA_VERSION}-merged-candidate-pool",
        "selection_scope": "outcome-blind maximum-coverage CPU eligibility; no model inference",
        "dataset_id": DATASET_ID,
        "dataset_revision": DATASET_REVISION,
        "dataset_sha256": DATASET_SHA256,
        "merge": {
            "num_shards": args.num_shards,
            "shard_root": shard_root.relative_to(HERE).as_posix(),
            "shard_config_sha256": [
                sha256_file(shard_root / shard_name(index, args.num_shards) / "screen_config.json")
                for index in range(args.num_shards)
            ],
            "registered_order_verified": True,
            "disjoint_coverage_verified": True,
        },
        **summary,
        "ledger_path": "entry_ledger.jsonl",
        "samples": samples,
    }
    atomic_json(output / "candidate_manifest.json", manifest)
    atomic_json(output / "summary.json", summary)
    atomic_json(output / "progress.json", {"status": "complete", **summary})
    print(json.dumps(summary, indent=2, sort_keys=True))
    return 0


def run_inventory(args: argparse.Namespace) -> int:
    rows, entries = load_registered_rows(args.dataset)
    report = inventory(rows, entries)
    destination = local_path(args.report, "inventory report")
    atomic_json(destination, report)
    print(json.dumps(report, indent=2, sort_keys=True))
    return 0


def parse_args(argv: Sequence[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    subparsers = parser.add_subparsers(dest="command", required=True)

    inventory_parser = subparsers.add_parser("inventory", help="write the deterministic 820-entry case plan")
    inventory_parser.add_argument("--dataset", type=Path, default=DATASET)
    inventory_parser.add_argument("--report", type=Path, default=Path("reports/max_coverage_inventory.json"))

    screen_parser = subparsers.add_parser("screen", help="compile and validate one deterministic CPU shard")
    screen_parser.add_argument("--dataset", type=Path, default=DATASET)
    screen_parser.add_argument("--output", type=Path, default=Path("candidate_pool_max_coverage_sharded"))
    screen_parser.add_argument("--num-shards", type=int, default=1)
    screen_parser.add_argument("--shard-index", type=int, default=0)
    screen_parser.add_argument("--compile-timeout-seconds", type=float, default=30.0)
    screen_parser.add_argument("--run-timeout-seconds", type=float, default=12.0)
    screen_parser.add_argument("--resume", action="store_true")
    screen_parser.add_argument("--force", action="store_true")

    merge_parser = subparsers.add_parser("merge", help="audit and merge completed CPU shards")
    merge_parser.add_argument("--dataset", type=Path, default=DATASET)
    merge_parser.add_argument("--shard-root", type=Path, default=Path("candidate_pool_max_coverage_sharded"))
    merge_parser.add_argument("--output", type=Path, default=Path("candidate_pool_max_coverage_merged"))
    merge_parser.add_argument("--num-shards", type=int, default=4)
    merge_parser.add_argument("--force", action="store_true")

    args = parser.parse_args(argv)
    if args.command == "screen":
        if args.force and args.resume:
            parser.error("--force and --resume are mutually exclusive")
        if args.num_shards < 1 or not 0 <= args.shard_index < args.num_shards:
            parser.error("require num-shards >= 1 and 0 <= shard-index < num-shards")
        if args.compile_timeout_seconds <= 0 or args.run_timeout_seconds <= 0:
            parser.error("timeouts must be positive")
    if args.command == "merge" and args.num_shards < 1:
        parser.error("--num-shards must be positive")
    return args


def main(argv: Sequence[str] | None = None) -> int:
    args = parse_args(argv)
    if args.command == "inventory":
        return run_inventory(args)
    if args.command == "screen":
        return run_screen(args)
    if args.command == "merge":
        return run_merge(args)
    raise AssertionError(args.command)


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (ScreenError, FileNotFoundError, ValueError, TypeError) as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        raise SystemExit(2)
