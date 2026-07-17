#!/usr/bin/env python3
"""Strictly reproduce the reported Prompt-Steering Table 2 rows."""

from __future__ import annotations

import argparse
import csv
import gzip
import hashlib
import json
import math
from collections import defaultdict
from pathlib import Path
from typing import Any, Iterable, Sequence


HERE = Path(__file__).resolve().parent
DEFAULT_RESULTS = HERE / "results" / "prompt_steering_trials.jsonl.gz"
DEFAULT_MANIFEST = HERE / "results" / "table2_manifest.json"
DEFAULT_TABLE = HERE / "results" / "table2_prompt_steering.csv"
DEFAULT_SUMMARY = HERE / "results" / "evaluation_summary.json"


class EvaluationError(ValueError):
    pass


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def read_json(path: Path) -> dict[str, Any]:
    return json.loads(path.read_text(encoding="utf-8"))


def read_archive(path: Path) -> tuple[dict[str, Any], list[dict[str, Any]]]:
    opener = gzip.open if path.suffix == ".gz" else open
    metadata: dict[str, Any] | None = None
    records: list[dict[str, Any]] = []
    with opener(path, "rt", encoding="utf-8") as handle:
        for line_number, line in enumerate(handle, start=1):
            if not line.strip():
                continue
            try:
                item = json.loads(line)
            except json.JSONDecodeError as exc:
                raise EvaluationError(f"Invalid JSON at {path}:{line_number}: {exc}") from exc
            record_type = item.get("record_type")
            if record_type == "metadata":
                if metadata is not None or records:
                    raise EvaluationError("Archive metadata must be the first and only metadata record")
                metadata = item
            elif record_type == "trial":
                records.append(item)
            else:
                raise EvaluationError(f"Unknown record_type at {path}:{line_number}: {record_type!r}")
    if metadata is None:
        raise EvaluationError("Archive metadata is missing")
    if int(metadata.get("trial_records", -1)) != len(records):
        raise EvaluationError(
            f"Archive record count mismatch: metadata={metadata.get('trial_records')} actual={len(records)}"
        )
    return metadata, records


def _case_map(record: dict[str, Any]) -> dict[str, tuple[str, str, bool]]:
    out: dict[str, tuple[str, str, bool]] = {}
    for case in record.get("per_case_scores") or []:
        case_id = str(case.get("case_id", ""))
        if not case_id or case_id in out:
            raise EvaluationError(f"Missing or duplicate case_id in {record.get('unit_id')}")
        expected = str(case.get("expected", ""))
        predicted = str(case.get("predicted", ""))
        correct = bool(case.get("correct", False))
        if expected not in {"T", "F"}:
            raise EvaluationError(f"Invalid expected label {expected!r} in {record.get('unit_id')}")
        if correct != (predicted == expected):
            raise EvaluationError(f"Inconsistent correctness for {record.get('unit_id')}/{case_id}")
        out[case_id] = (expected, predicted, correct)
    if not out:
        raise EvaluationError(f"No case scores for {record.get('unit_id')}")
    return out


def restoration(value: float, original: float, obfuscated: float) -> float:
    if math.isclose(original, obfuscated, rel_tol=0.0, abs_tol=0.0):
        raise EvaluationError("Restoration ratio denominator is zero")
    return 100.0 * (value - obfuscated) / (original - obfuscated)


def evaluate_records(
    records: Iterable[dict[str, Any]], manifest: dict[str, Any]
) -> tuple[list[dict[str, Any]], dict[str, Any]]:
    rows = {
        (str(row["model_label"]), str(row["dataset"])): row
        for row in manifest.get("rows") or []
    }
    if not rows:
        raise EvaluationError("Manifest has no rows")
    protocol = manifest["protocol"]
    expected_trials = tuple(range(1, int(protocol["trials_per_unit"]) + 1))

    grouped: dict[
        tuple[str, str], dict[str, dict[int, tuple[dict[str, Any], dict[str, tuple[str, str, bool]]]]]
    ] = defaultdict(lambda: defaultdict(dict))
    record_count = 0
    for record in records:
        record_count += 1
        key = (str(record.get("model_label", "")), str(record.get("dataset", "")))
        if key not in rows:
            raise EvaluationError(f"Unexpected model/dataset row: {key}")
        row = rows[key]
        unit_id = str(record.get("unit_id", ""))
        trial = int(record.get("trial_id", -1))
        generation = record.get("generation_params") or {}
        prompt = record.get("prompt_steering") or {}
        checks = {
            "model": record.get("model") == row["model_name"],
            "unit_id": bool(unit_id),
            "run_index": record.get("run_index") == trial,
            "trial": trial in expected_trials,
            "source_sha256": len(str(record.get("source_sha256", ""))) == 64,
            "prompt_mode": prompt.get("mode") == protocol["prompt_mode"],
            "prompt_mechanism": prompt.get("mechanism") == protocol["prompt_mechanism"],
            "temperature": float(generation.get("temperature", -1)) == float(protocol["temperature"]),
            "top_p": float(generation.get("top_p", -1)) == float(protocol["top_p"]),
            "do_sample": generation.get("do_sample") is protocol["do_sample"],
            "base_seed": generation.get("base_seed") == protocol["base_seed"],
            "seed": isinstance(generation.get("seed"), int),
            "prompt_text": bool(str(record.get("prompt_text", ""))),
            "generated_completion": bool(str(record.get("generated_completion", "")).strip()),
        }
        failed = [name for name, passed in checks.items() if not passed]
        if failed:
            raise EvaluationError(f"Invalid record {key}/{unit_id}/trial{trial}: {', '.join(failed)}")
        if trial in grouped[key][unit_id]:
            raise EvaluationError(f"Duplicate trial {trial} for {key}/{unit_id}")
        grouped[key][unit_id][trial] = (record, _case_map(record))

    output_rows: list[dict[str, Any]] = []
    summary_rows: list[dict[str, Any]] = []
    for key, expected in rows.items():
        units = grouped.get(key, {})
        if len(units) != int(expected["expected_units"]):
            raise EvaluationError(
                f"Unit count mismatch for {key}: {len(units)}/{expected['expected_units']}"
            )
        correct_at_k = [0, 0, 0]
        total_at_k = [0, 0, 0]
        for unit_id, trials in units.items():
            if tuple(sorted(trials)) != expected_trials:
                raise EvaluationError(
                    f"Trial set mismatch for {key}/{unit_id}: {sorted(trials)} != {list(expected_trials)}"
                )
            reference_record, reference_cases = trials[expected_trials[0]]
            reference_expected = {
                case_id: values[0] for case_id, values in reference_cases.items()
            }
            reference_source = reference_record["source_sha256"]
            reference_prompt = reference_record["prompt_text"]
            seeds: set[int] = set()
            for trial in expected_trials:
                record, cases = trials[trial]
                if record["source_sha256"] != reference_source:
                    raise EvaluationError(f"Source drift for {key}/{unit_id}")
                if record["prompt_text"] != reference_prompt:
                    raise EvaluationError(f"Prompt drift for {key}/{unit_id}")
                current_expected = {case_id: values[0] for case_id, values in cases.items()}
                if current_expected != reference_expected:
                    raise EvaluationError(f"Case-set or oracle drift for {key}/{unit_id}")
                seeds.add(int((record.get("generation_params") or {})["seed"]))
            if len(seeds) != len(expected_trials):
                raise EvaluationError(f"Duplicate generation seed for {key}/{unit_id}")

            case_ids = sorted(reference_cases)
            for index in range(3):
                attempts = expected_trials[: index + 1]
                total_at_k[index] += len(case_ids)
                correct_at_k[index] += sum(
                    any(trials[trial][1][case_id][2] for trial in attempts)
                    for case_id in case_ids
                )

        if total_at_k != [int(expected["case_total"])] * 3:
            raise EvaluationError(f"Case totals mismatch for {key}: {total_at_k}")
        if correct_at_k != [int(value) for value in expected["pass_correct"]]:
            raise EvaluationError(
                f"Correct counts mismatch for {key}: {correct_at_k} != {expected['pass_correct']}"
            )
        percentages = [
            100.0 * correct_at_k[index] / total_at_k[index] for index in range(3)
        ]
        formatted = [f"{value:.2f}" for value in percentages]
        expected_formatted = [f"{float(value):.2f}" for value in expected["pass_percent"]]
        if formatted != expected_formatted:
            raise EvaluationError(
                f"Rounded percentages mismatch for {key}: {formatted} != {expected_formatted}"
            )
        ratios = [
            restoration(
                percentages[index],
                float(expected["original_percent"][index]),
                float(expected["obfuscated_percent"][index]),
            )
            for index in range(3)
        ]
        output_rows.append(
            {
                "model_label": key[0],
                "model": expected["model"],
                "dataset": key[1],
                "completed_units": len(units),
                "prompt_p1": formatted[0],
                "prompt_p2": formatted[1],
                "prompt_p3": formatted[2],
                "prompt_rr1": f"{ratios[0]:.2f}",
                "prompt_rr2": f"{ratios[1]:.2f}",
                "prompt_rr3": f"{ratios[2]:.2f}",
                "cases_p1": total_at_k[0],
                "cases_p2": total_at_k[1],
                "cases_p3": total_at_k[2],
            }
        )
        summary_rows.append(
            {
                "model_label": key[0],
                "model": expected["model"],
                "dataset": key[1],
                "units": len(units),
                "pass_correct": correct_at_k,
                "case_total": total_at_k,
                "pass_percent_exact": percentages,
                "pass_percent_rounded": formatted,
                "restoration_ratio": ratios,
            }
        )

    summary = {
        "schema_version": 1,
        "ok": True,
        "trial_records": record_count,
        "rows": summary_rows,
    }
    return output_rows, summary


def write_csv(path: Path, rows: Sequence[dict[str, Any]]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary = path.with_suffix(path.suffix + ".tmp")
    with temporary.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(rows[0]))
        writer.writeheader()
        writer.writerows(rows)
    temporary.replace(path)


def write_json(path: Path, payload: dict[str, Any]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary = path.with_suffix(path.suffix + ".tmp")
    temporary.write_text(json.dumps(payload, indent=2) + "\n", encoding="utf-8")
    temporary.replace(path)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--results", type=Path, default=DEFAULT_RESULTS)
    parser.add_argument("--manifest", type=Path, default=DEFAULT_MANIFEST)
    parser.add_argument("--output", type=Path, default=DEFAULT_TABLE)
    parser.add_argument("--summary", type=Path, default=DEFAULT_SUMMARY)
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    manifest_path = args.manifest.resolve()
    manifest = read_json(manifest_path)
    metadata, records = read_archive(args.results.resolve())
    if metadata.get("manifest_sha256") != sha256_file(manifest_path):
        raise EvaluationError("Result archive was exported from a different manifest")
    if metadata.get("run_tag") != manifest.get("run_tag"):
        raise EvaluationError("Result archive run tag does not match the manifest")
    rows, summary = evaluate_records(records, manifest)
    summary["archive_sha256"] = sha256_file(args.results.resolve())
    summary["manifest_sha256"] = sha256_file(manifest_path)
    write_csv(args.output.resolve(), rows)
    write_json(args.summary.resolve(), summary)
    print(f"Verified {summary['trial_records']} trial records across {len(rows)} rows")
    print(f"Wrote {args.output.resolve()}")
    print(f"Wrote {args.summary.resolve()}")


if __name__ == "__main__":
    main()
