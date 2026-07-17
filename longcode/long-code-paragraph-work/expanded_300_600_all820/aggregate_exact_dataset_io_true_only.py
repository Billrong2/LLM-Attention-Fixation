#!/usr/bin/env python3
"""Post-hoc true-case recall over exact original-dataset I/O pairs.

Only frozen cases with exact dataset input/output provenance and expected label
T are retained.  Mutated F candidates are excluded.  The result is therefore
true-positive recall, not overall accuracy or Pass@1.
"""

from __future__ import annotations

import argparse
import hashlib
import importlib.util
import json
import os
import sys
from pathlib import Path
from typing import Any, Mapping, Sequence


HERE = Path(__file__).resolve().parent
EXACT_AUDITOR = HERE / "aggregate_exact_dataset_io.py"
EXACT_PACKAGE = (
    HERE / "results" / "aggregate" / "final_152_t130_exact_dataset_io"
    / "aggregate_exact_dataset_io.json"
)
PRIMARY_PACKAGE = HERE / "results" / "aggregate" / "final_152_t130" / "aggregate_study.json"
DEFAULT_OUTPUT = HERE / "results" / "aggregate" / "final_152_t130_exact_dataset_io_true_only"

EXACT_AUDITOR_SHA256 = "fa6f2ef2eff9955556a12a255347c6f6a07e4c4d750ecdd1b0990b8418e87f94"
EXACT_PACKAGE_SHA256 = "c693d572d59b7ead624a40ced334587c37748bbe4ae9bc44c6aa396bfc51c5b8"
PRIMARY_PACKAGE_SHA256 = "ea51211df88721413ce2358bee5aa14aa2c621321c650a8e5a3a0f32b60a5986"
CONDITIONS = ("original_plain", "obfuscated_plain", "obfuscated_codesteer")


class TrueOnlyError(RuntimeError):
    pass


def require(value: bool, message: str) -> None:
    if not value:
        raise TrueOnlyError(message)


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def read_json(path: Path) -> Any:
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except (OSError, UnicodeError, json.JSONDecodeError) as exc:
        raise TrueOnlyError(f"invalid JSON {path}: {exc}") from exc


def canonical_json(value: Any) -> str:
    return json.dumps(value, ensure_ascii=False, indent=2, sort_keys=True, default=str) + "\n"


def load_exact_auditor() -> Any:
    require(sha256_file(EXACT_AUDITOR) == EXACT_AUDITOR_SHA256,
            "exact-dataset auditor SHA-256 differs")
    spec = importlib.util.spec_from_file_location("_true_only_exact_auditor", EXACT_AUDITOR)
    require(spec is not None and spec.loader is not None, "cannot import exact-dataset auditor")
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module
    try:
        spec.loader.exec_module(module)
    except BaseException:
        sys.modules.pop(spec.name, None)
        raise
    return module


def true_positions(exact: Any, program: Mapping[str, Any]) -> set[int]:
    cases = {int(item["pack_position"]): item for item in program["cases"]}
    positions = {
        position
        for position in range(1, 7)
        if exact.retained_case(program, position) and bool(cases[position]["label"])
    }
    return positions


def true_score(exact: Any, program: Mapping[str, Any], condition: str,
               positions: set[int]) -> dict[str, Any]:
    payload = read_json(exact.score_path(str(program["id"]), condition))
    rows = payload.get("label_scores")
    require(isinstance(rows, list) and len(rows) == 6,
            f"score rows differ for {program['id']}/{condition}")
    cases = {int(item["pack_position"]): item for item in program["cases"]}
    by_position: dict[int, Mapping[str, Any]] = {}
    for row in rows:
        position = int(row.get("pack_position", 0))
        require(position in cases and position not in by_position,
                f"score position differs for {program['id']}/{condition}")
        require(row.get("case_id") == cases[position]["id"],
                f"score case ID differs for {program['id']}/{condition}/{position}")
        expected = "T" if bool(cases[position]["label"]) else "F"
        require(row.get("expected_label") == expected,
                f"expected label differs for {program['id']}/{condition}/{position}")
        require(isinstance(row.get("correct"), bool),
                f"correct flag differs for {program['id']}/{condition}/{position}")
        by_position[position] = row
    kept = [by_position[position] for position in sorted(positions)]
    require(all(row["expected_label"] == "T" for row in kept),
            f"non-T row retained for {program['id']}/{condition}")
    return {
        "true_case_count": len(kept),
        "correct_true_count": sum(int(bool(row["correct"])) for row in kept),
        "valid_prediction_count": sum(int(bool(row.get("valid_prediction"))) for row in kept),
    }


def build_summary() -> dict[str, Any]:
    require(sha256_file(EXACT_PACKAGE) == EXACT_PACKAGE_SHA256,
            "exact-dataset package SHA-256 differs")
    require(sha256_file(PRIMARY_PACKAGE) == PRIMARY_PACKAGE_SHA256,
            "primary package SHA-256 differs")
    exact = load_exact_auditor()
    exact_live = exact.build_summary()
    exact_frozen = read_json(EXACT_PACKAGE)
    require(exact_live == exact_frozen, "live exact-dataset audit differs from package")
    primary = read_json(PRIMARY_PACKAGE)
    require(primary.get("audit_status") == "passed", "primary audit did not pass")

    manifest = read_json(exact.MANIFEST)
    programs = manifest.get("programs")
    require(isinstance(programs, list) and len(programs) == 152, "manifest programs differ")
    primary_programs = primary.get("paired_program_summaries")
    require(isinstance(primary_programs, dict) and len(primary_programs) == 152,
            "primary paired summaries differ")

    positions_by_program: dict[str, set[int]] = {}
    true_case_count = 0
    distribution: dict[int, int] = {}
    for program in programs:
        program_id = str(program["id"])
        positions = true_positions(exact, program)
        positions_by_program[program_id] = positions
        true_case_count += len(positions)
        distribution[len(positions)] = distribution.get(len(positions), 0) + 1
    require(true_case_count == 333, "exact-dataset T-case count differs")
    require(exact_live["filter"]["retained_exact_io_pair_count"] == 661,
            "exact-dataset retained count differs")

    condition_specific: dict[str, dict[str, Any]] = {}
    per_program: dict[str, dict[str, dict[str, Any]]] = {}
    complete_program_ids = [
        str(program["id"])
        for program in programs
        if all(
            primary_programs[str(program["id"])][condition]["availability"] == "observed"
            for condition in CONDITIONS
        )
    ]

    for condition in CONDITIONS:
        correct = total = valid = observed_programs = contributing_programs = 0
        for program in programs:
            program_id = str(program["id"])
            if primary_programs[program_id][condition]["availability"] != "observed":
                continue
            observed_programs += 1
            positions = positions_by_program[program_id]
            if positions:
                contributing_programs += 1
            cell = true_score(exact, program, condition, positions)
            per_program.setdefault(program_id, {})[condition] = cell
            correct += cell["correct_true_count"]
            total += cell["true_case_count"]
            valid += cell["valid_prediction_count"]
        condition_specific[condition] = {
            "observed_program_count": observed_programs,
            "contributing_program_count": contributing_programs,
            "true_case_count": total,
            "correct_true_count": correct,
            "true_case_recall": (correct / total) if total else None,
            "true_case_recall_percent": (100.0 * correct / total) if total else None,
            "valid_prediction_count": valid,
        }

    complete_set = set(complete_program_ids)
    paired: dict[str, dict[str, Any]] = {}
    for condition in CONDITIONS:
        correct = total = contributing_programs = 0
        for program in programs:
            program_id = str(program["id"])
            if program_id not in complete_set:
                continue
            cell = per_program[program_id][condition]
            correct += cell["correct_true_count"]
            total += cell["true_case_count"]
            if cell["true_case_count"]:
                contributing_programs += 1
        paired[condition] = {
            "complete_cluster_program_count": len(complete_program_ids),
            "contributing_program_count": contributing_programs,
            "true_case_count": total,
            "correct_true_count": correct,
            "true_case_recall": (correct / total) if total else None,
            "true_case_recall_percent": (100.0 * correct / total) if total else None,
        }

    original = paired["original_plain"]["correct_true_count"]
    obfuscated = paired["obfuscated_plain"]["correct_true_count"]
    steered = paired["obfuscated_codesteer"]["correct_true_count"]
    denominator = original - obfuscated
    numerator = steered - obfuscated
    signed_ratio = None if denominator == 0 else numerator / denominator
    restoration = signed_ratio if denominator > 0 else None

    return {
        "schema_version": "expanded-java-300-600-exact-dataset-io-true-only-v1",
        "audit_status": "passed",
        "metric_name": "true_case_recall",
        "metric_warning": (
            "F cases are deliberately excluded; this is sensitivity/recall on correct proposed "
            "outputs, not overall accuracy, balanced accuracy, specificity, or Pass@1"
        ),
        "model_id": primary["model_id"],
        "model_snapshot_commit": primary["model_snapshot_commit"],
        "primary_aggregate_sha256": PRIMARY_PACKAGE_SHA256,
        "exact_dataset_aggregate_sha256": EXACT_PACKAGE_SHA256,
        "exact_dataset_auditor_sha256": EXACT_AUDITOR_SHA256,
        "filter": {
            "exact_dataset_io_case_count": 661,
            "retained_true_case_count": true_case_count,
            "excluded_false_case_count": 661 - true_case_count,
            "requirements": [
                "passes exact original-dataset I/O filter",
                "frozen expected label is T",
            ],
            "true_case_count_distribution_per_program": {
                str(key): distribution[key] for key in sorted(distribution)
            },
        },
        "condition_specific": condition_specific,
        "paired_complete_case": {
            "complete_cluster_program_count": len(complete_program_ids),
            "contributing_program_count": sum(
                1 for program_id in complete_program_ids if positions_by_program[program_id]
            ),
            "true_case_count_per_condition": sum(
                len(positions_by_program[program_id]) for program_id in complete_program_ids
            ),
            "conditions": paired,
            "excluded_resource_skip_program_ids": sorted(set(primary_programs) - complete_set),
        },
        "steering_gain_over_obfuscated_percentage_points": 100.0 * (
            paired["obfuscated_codesteer"]["true_case_recall"]
            - paired["obfuscated_plain"]["true_case_recall"]
        ),
        "restoration": {
            "formula": "(steered_T_correct - obfuscated_T_correct) / (original_T_correct - obfuscated_T_correct)",
            "numerator_correct_true_cases": numerator,
            "denominator_correct_true_cases": denominator,
            "defined": restoration is not None,
            "ratio": restoration,
            "ratio_percent": None if restoration is None else 100.0 * restoration,
            "signed_algebraic_ratio": signed_ratio,
            "signed_algebraic_ratio_percent": None if signed_ratio is None else 100.0 * signed_ratio,
            "undefined_reason": (
                None if restoration is not None
                else "no positive obfuscation loss exists for T-case recall"
            ),
        },
    }


def markdown(summary: Mapping[str, Any]) -> str:
    labels = {
        "original_plain": "Original",
        "obfuscated_plain": "Obfuscated",
        "obfuscated_codesteer": "Obfuscated + CodeSteer L2",
    }
    lines = [
        "# Exact original-dataset I/O: T-only recall",
        "",
        "Only exact dataset I/O cases with frozen expected label T are counted. All mutated F cases are excluded.",
        "",
        "| Condition | Observed programs | Contributing programs | Correct T / T cases | T-case recall |",
        "|---|---:|---:|---:|---:|",
    ]
    for condition in CONDITIONS:
        row = summary["condition_specific"][condition]
        lines.append(
            f"| {labels[condition]} | {row['observed_program_count']} | "
            f"{row['contributing_program_count']} | {row['correct_true_count']} / "
            f"{row['true_case_count']} | {row['true_case_recall_percent']:.6f}% |"
        )
    paired = summary["paired_complete_case"]
    lines.extend([
        "",
        f"Paired analysis uses {paired['true_case_count_per_condition']} T cases from "
        f"{paired['contributing_program_count']} contributing programs.",
        "",
        f"Steering gain over obfuscated: {summary['steering_gain_over_obfuscated_percentage_points']:.6f} percentage points.",
        "",
    ])
    restoration = summary["restoration"]
    if restoration["defined"]:
        lines.append(f"T-recall restoration ratio: {restoration['ratio_percent']:.6f}%.")
    else:
        lines.append("T-recall restoration ratio is not applicable because no positive obfuscation loss exists.")
        if restoration["signed_algebraic_ratio_percent"] is not None:
            lines.append(
                f"The signed algebraic value is {restoration['signed_algebraic_ratio_percent']:.6f}%, "
                "but it is not restoration."
            )
    lines.extend([
        "",
        "This T-only result must be reported as true-case recall/sensitivity. It is not overall accuracy or Pass@1 because all F cases were removed.",
        "",
    ])
    return "\n".join(lines)


def write_package(output: Path, summary: Mapping[str, Any]) -> None:
    require(not output.exists(), f"output already exists: {output}")
    output.parent.mkdir(parents=True, exist_ok=True)
    temporary = output.with_name(f".{output.name}.tmp-{os.getpid()}")
    require(not temporary.exists(), f"temporary output exists: {temporary}")
    temporary.mkdir()
    json_path = temporary / "aggregate_exact_dataset_io_true_only.json"
    md_path = temporary / "aggregate_exact_dataset_io_true_only.md"
    json_path.write_text(canonical_json(summary), encoding="utf-8")
    md_path.write_text(markdown(summary), encoding="utf-8")
    (temporary / "SHA256SUMS").write_text(
        f"{sha256_file(json_path)}  {json_path.name}\n"
        f"{sha256_file(md_path)}  {md_path.name}\n",
        encoding="utf-8",
    )
    os.replace(temporary, output)


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--check-only", action="store_true")
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    args = parser.parse_args(argv)
    summary = build_summary()
    if args.check_only:
        print(canonical_json(summary), end="")
        return 0
    output = args.output if args.output.is_absolute() else HERE / args.output
    write_package(output.resolve(strict=False), summary)
    print(f"[aggregate-complete] {output.resolve(strict=True)}")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except TrueOnlyError as exc:
        print(f"REFUSED: {exc}", file=sys.stderr)
        raise SystemExit(2)
