#!/usr/bin/env python3
"""Post-hoc aggregate restricted to exact DeepMind dataset I/O pairs.

This is a secondary view of the frozen, already verified study.  It never
changes the original aggregate.  A case is retained only when its input has a
frozen dataset reference, has no synthetic provenance, and the deterministic
program oracle is byte-identical to the dataset's stored expected output.
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
MANIFEST = HERE / "frozen_model_eligible_t130" / "inference_manifest.json"
BASE_AUDITOR = HERE / "aggregate_study.py"
BASE_PACKAGE = HERE / "results" / "aggregate" / "final_152_t130" / "aggregate_study.json"
DEFAULT_OUTPUT = HERE / "results" / "aggregate" / "final_152_t130_exact_dataset_io"

MANIFEST_SHA256 = "93160336e3177a900594a016f27a41aa0946bf61c4f363e2bfaf502f48c8ca02"
BASE_AUDITOR_SHA256 = "2e39f15fe383aac275b930ce942e4599547555087144d29a7246a159971126e2"
BASE_PACKAGE_SHA256 = "ea51211df88721413ce2358bee5aa14aa2c621321c650a8e5a3a0f32b60a5986"
CONDITIONS = ("original_plain", "obfuscated_plain", "obfuscated_codesteer")


class FilterError(RuntimeError):
    pass


def require(value: bool, message: str) -> None:
    if not value:
        raise FilterError(message)


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
        raise FilterError(f"invalid JSON {path}: {exc}") from exc


def canonical_json(value: Any) -> str:
    return json.dumps(value, ensure_ascii=False, indent=2, sort_keys=True, default=str) + "\n"


def load_base_auditor() -> Any:
    require(sha256_file(BASE_AUDITOR) == BASE_AUDITOR_SHA256, "base auditor SHA-256 differs")
    spec = importlib.util.spec_from_file_location("_exact_dataset_base_auditor", BASE_AUDITOR)
    require(spec is not None and spec.loader is not None, "cannot import base auditor")
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module
    try:
        spec.loader.exec_module(module)
    except BaseException:
        sys.modules.pop(spec.name, None)
        raise
    return module


def retained_case(program: Mapping[str, Any], position: int) -> bool:
    cases = {int(item["pack_position"]): item for item in program["cases"]}
    metadata = {int(item["selection_position"]): item for item in program["source_case_metadata"]}
    require(set(cases) == set(range(1, 7)), f"case positions differ for {program['id']}")
    require(set(metadata) == set(range(1, 7)), f"metadata positions differ for {program['id']}")
    case = cases[position]
    meta = metadata[position]
    require(case["source_case_id"] == meta["case_id"],
            f"source-case identity differs for {program['id']} position {position}")
    require(case["stdin_sha256"] == meta["input_sha256"],
            f"input hash differs for {program['id']} position {position}")
    require(case["oracle_stdout_sha256"] == meta["oracle_stdout_sha256"],
            f"oracle hash differs for {program['id']} position {position}")
    refs = meta.get("dataset_references") or []
    if not refs or meta.get("synthetic_provenance") is not None:
        return False
    if meta.get("oracle_equals_dataset_expected_stdout") is not True:
        return False
    require(meta.get("dataset_oracle_conflict") is False,
            f"dataset/oracle conflict for retained case {program['id']} position {position}")
    require(meta.get("dataset_expected_stdout_sha256") == meta.get("oracle_stdout_sha256"),
            f"dataset/oracle SHA differs for retained case {program['id']} position {position}")
    return True


def score_path(program_id: str, condition: str) -> Path:
    matches = list((HERE / "results" / "study").glob(
        f"shard_*/runs/{program_id}/trial_001/{condition}/score.json"
    ))
    require(len(matches) == 1,
            f"expected one score for {program_id}/{condition}, found {len(matches)}")
    return matches[0]


def filtered_score(program: Mapping[str, Any], condition: str, positions: set[int]) -> dict[str, Any]:
    payload = read_json(score_path(str(program["id"]), condition))
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
    return {
        "label_count": len(kept),
        "correct_label_count": sum(int(bool(row["correct"])) for row in kept),
        "valid_prediction_count": sum(int(bool(row.get("valid_prediction"))) for row in kept),
        "parse_status": payload.get("parse_status"),
    }


def build_summary() -> dict[str, Any]:
    require(sha256_file(MANIFEST) == MANIFEST_SHA256, "manifest SHA-256 differs")
    require(sha256_file(BASE_PACKAGE) == BASE_PACKAGE_SHA256, "base aggregate SHA-256 differs")
    auditor = load_base_auditor()
    live_base = auditor.audit_study()
    frozen_base = read_json(BASE_PACKAGE)
    require(live_base == frozen_base, "live base audit differs from immutable aggregate")
    require(live_base.get("audit_status") == "passed", "base audit did not pass")

    manifest = read_json(MANIFEST)
    programs = manifest.get("programs")
    require(isinstance(programs, list) and len(programs) == 152, "manifest program count differs")
    base_programs = live_base.get("paired_program_summaries")
    require(isinstance(base_programs, dict) and len(base_programs) == 152,
            "base paired-program summaries differ")

    all_case_count = 0
    dataset_referenced_count = 0
    synthetic_count = 0
    exact_case_count = 0
    positions_by_program: dict[str, set[int]] = {}
    distribution: dict[int, int] = {}
    selection_tiers: dict[str, int] = {}
    exact_selection_tiers: dict[str, int] = {}

    for program in programs:
        program_id = str(program["id"])
        require(program_id in base_programs, f"program absent from base audit: {program_id}")
        metadata = program["source_case_metadata"]
        require(len(metadata) == 6, f"metadata count differs for {program_id}")
        for item in metadata:
            all_case_count += 1
            if item.get("dataset_references"):
                dataset_referenced_count += 1
            if item.get("synthetic_provenance") is not None:
                synthetic_count += 1
            tier = str(item.get("selection_tier"))
            selection_tiers[tier] = selection_tiers.get(tier, 0) + 1
        kept = {position for position in range(1, 7) if retained_case(program, position)}
        positions_by_program[program_id] = kept
        exact_case_count += len(kept)
        distribution[len(kept)] = distribution.get(len(kept), 0) + 1
        meta_by_position = {int(item["selection_position"]): item for item in metadata}
        for position in kept:
            tier = str(meta_by_position[position].get("selection_tier"))
            exact_selection_tiers[tier] = exact_selection_tiers.get(tier, 0) + 1

    require(all_case_count == 912, "selected case count differs")
    require(dataset_referenced_count == 912, "not every selected input has a dataset reference")
    require(synthetic_count == 0, "synthetic case unexpectedly present")
    require(exact_case_count == 661, "exact dataset-I/O case count differs")

    condition_rows: dict[str, dict[str, Any]] = {}
    per_program: dict[str, dict[str, Any]] = {}
    complete_program_ids: list[str] = []
    for program in programs:
        program_id = str(program["id"])
        availability = base_programs[program_id]
        if all(availability[condition]["availability"] == "observed" for condition in CONDITIONS):
            complete_program_ids.append(program_id)

    for condition in CONDITIONS:
        correct = labels = valid = observed_programs = contributing_programs = 0
        parse_status_counts: dict[str, int] = {}
        for program in programs:
            program_id = str(program["id"])
            cell = base_programs[program_id][condition]
            if cell["availability"] != "observed":
                continue
            observed_programs += 1
            kept = positions_by_program[program_id]
            if kept:
                contributing_programs += 1
            filtered = filtered_score(program, condition, kept)
            labels += filtered["label_count"]
            correct += filtered["correct_label_count"]
            valid += filtered["valid_prediction_count"]
            status = str(filtered["parse_status"])
            parse_status_counts[status] = parse_status_counts.get(status, 0) + 1
            per_program.setdefault(program_id, {})[condition] = filtered
        condition_rows[condition] = {
            "observed_program_count": observed_programs,
            "contributing_program_count": contributing_programs,
            "retained_label_count": labels,
            "correct_label_count": correct,
            "accuracy": (correct / labels) if labels else None,
            "accuracy_percent": (100.0 * correct / labels) if labels else None,
            "valid_prediction_count": valid,
            "parse_status_counts_over_observed_completions": parse_status_counts,
        }

    complete_set = set(complete_program_ids)
    paired: dict[str, dict[str, Any]] = {}
    for condition in CONDITIONS:
        correct = labels = contributing_programs = 0
        for program in programs:
            program_id = str(program["id"])
            if program_id not in complete_set:
                continue
            cell = per_program[program_id][condition]
            labels += int(cell["label_count"])
            correct += int(cell["correct_label_count"])
            if int(cell["label_count"]) > 0:
                contributing_programs += 1
        paired[condition] = {
            "complete_cluster_program_count": len(complete_program_ids),
            "contributing_program_count": contributing_programs,
            "retained_label_count": labels,
            "correct_label_count": correct,
            "accuracy": (correct / labels) if labels else None,
            "accuracy_percent": (100.0 * correct / labels) if labels else None,
        }

    original = paired["original_plain"]["correct_label_count"]
    obfuscated = paired["obfuscated_plain"]["correct_label_count"]
    steered = paired["obfuscated_codesteer"]["correct_label_count"]
    denominator = original - obfuscated
    numerator = steered - obfuscated
    signed_ratio = None if denominator == 0 else numerator / denominator
    restoration = signed_ratio if denominator > 0 else None

    return {
        "schema_version": "expanded-java-300-600-exact-dataset-io-posthoc-v1",
        "audit_status": "passed",
        "base_audit_reverified": True,
        "base_aggregate_sha256": BASE_PACKAGE_SHA256,
        "base_auditor_sha256": BASE_AUDITOR_SHA256,
        "manifest_sha256": MANIFEST_SHA256,
        "model_id": live_base["model_id"],
        "model_snapshot_commit": live_base["model_snapshot_commit"],
        "filter": {
            "name": "exact_original_dataset_io_pair",
            "requirements": [
                "nonempty frozen dataset_references",
                "synthetic_provenance is null",
                "oracle_equals_dataset_expected_stdout is true",
                "dataset_expected_stdout_sha256 equals oracle_stdout_sha256",
                "dataset_oracle_conflict is false",
            ],
            "selected_case_count_before": all_case_count,
            "dataset_referenced_input_count": dataset_referenced_count,
            "synthetic_case_count": synthetic_count,
            "retained_exact_io_pair_count": exact_case_count,
            "excluded_output_difference_count": all_case_count - exact_case_count,
            "retained_case_count_distribution_per_program": {
                str(key): distribution[key] for key in sorted(distribution)
            },
            "selection_tiers_before": selection_tiers,
            "selection_tiers_retained": exact_selection_tiers,
        },
        "condition_specific": condition_rows,
        "paired_complete_case": {
            "complete_cluster_program_count": len(complete_program_ids),
            "contributing_program_count": sum(
                1 for program_id in complete_program_ids if positions_by_program[program_id]
            ),
            "retained_case_count_per_condition": sum(
                len(positions_by_program[program_id]) for program_id in complete_program_ids
            ),
            "conditions": paired,
            "excluded_resource_skip_program_ids": sorted(set(base_programs) - complete_set),
        },
        "steering_gain_percentage_points": 100.0 * (
            paired["obfuscated_codesteer"]["accuracy"]
            - paired["obfuscated_plain"]["accuracy"]
        ),
        "restoration": {
            "formula": "(steered_correct - obfuscated_correct) / (original_correct - obfuscated_correct)",
            "numerator_correct_labels": numerator,
            "denominator_correct_labels": denominator,
            "defined": restoration is not None,
            "ratio": restoration,
            "ratio_percent": None if restoration is None else 100.0 * restoration,
            "signed_algebraic_ratio": signed_ratio,
            "signed_algebraic_ratio_percent": None if signed_ratio is None else 100.0 * signed_ratio,
            "undefined_reason": (
                None if restoration is not None
                else "no positive obfuscation loss exists in the filtered complete-case cohort"
            ),
            "analysis_unit": "retained exact dataset-I/O cases within complete three-condition program clusters",
        },
    }


def markdown(summary: Mapping[str, Any]) -> str:
    labels = {
        "original_plain": "Original",
        "obfuscated_plain": "Obfuscated",
        "obfuscated_codesteer": "Obfuscated + CodeSteer L2",
    }
    lines = [
        "# Exact original-dataset I/O post-hoc aggregate",
        "",
        "This secondary view retains only cases whose frozen dataset input is non-synthetic and whose program oracle is byte-identical to the dataset's stored expected output.",
        "",
        "| Condition | Observed programs | Contributing programs | Correct / retained cases | Accuracy |",
        "|---|---:|---:|---:|---:|",
    ]
    for condition in CONDITIONS:
        row = summary["condition_specific"][condition]
        lines.append(
            f"| {labels[condition]} | {row['observed_program_count']} | "
            f"{row['contributing_program_count']} | {row['correct_label_count']} / "
            f"{row['retained_label_count']} | {row['accuracy_percent']:.6f}% |"
        )
    paired = summary["paired_complete_case"]
    lines.extend([
        "",
        f"The filter retained {summary['filter']['retained_exact_io_pair_count']} of "
        f"{summary['filter']['selected_case_count_before']} selected cases. All selected inputs had "
        "dataset references and none were synthetic; excluded cases differed only because the program-derived oracle output was not byte-identical to the stored dataset output.",
        "",
        f"Paired analysis uses {paired['retained_case_count_per_condition']} retained cases from "
        f"{paired['contributing_program_count']} contributing programs ({paired['complete_cluster_program_count']} "
        "complete clusters before removing zero-retained-case programs).",
        "",
        f"Steering gain: {summary['steering_gain_percentage_points']:.6f} percentage points.",
        "",
    ])
    restoration = summary["restoration"]
    if restoration["defined"]:
        lines.append(
            f"Restoration ratio: {restoration['numerator_correct_labels']} / "
            f"{restoration['denominator_correct_labels']} = {restoration['ratio_percent']:.6f}%."
        )
    else:
        lines.append(
            "Restoration ratio is not applicable because the filtered cohort has no positive "
            "obfuscation loss to restore."
        )
        if restoration["signed_algebraic_ratio_percent"] is not None:
            lines.append(
                f"The signed algebraic formula is {restoration['signed_algebraic_ratio_percent']:.6f}%, "
                "but it must not be interpreted as restoration."
            )
    lines.extend([
        "",
        "This is a post-hoc filtered view; it does not alter the frozen prompts, model outputs, scores, or primary 912-case aggregate.",
        "",
    ])
    return "\n".join(lines)


def write_package(output: Path, summary: Mapping[str, Any]) -> None:
    require(not output.exists(), f"output already exists: {output}")
    output.parent.mkdir(parents=True, exist_ok=True)
    temporary = output.with_name(f".{output.name}.tmp-{os.getpid()}")
    require(not temporary.exists(), f"temporary output exists: {temporary}")
    temporary.mkdir()
    json_path = temporary / "aggregate_exact_dataset_io.json"
    md_path = temporary / "aggregate_exact_dataset_io.md"
    json_path.write_text(canonical_json(summary), encoding="utf-8")
    md_path.write_text(markdown(summary), encoding="utf-8")
    sums = (
        f"{sha256_file(json_path)}  {json_path.name}\n"
        f"{sha256_file(md_path)}  {md_path.name}\n"
    )
    (temporary / "SHA256SUMS").write_text(sums, encoding="utf-8")
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
    output = args.output if args.output.is_absolute() else (HERE / args.output)
    write_package(output.resolve(strict=False), summary)
    print(f"[aggregate-complete] {output.resolve(strict=True)}")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except FilterError as exc:
        print(f"REFUSED: {exc}", file=__import__("sys").stderr)
        raise SystemExit(2)
