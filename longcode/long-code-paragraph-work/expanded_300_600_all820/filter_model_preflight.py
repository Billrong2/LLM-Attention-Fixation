#!/usr/bin/env python3
"""Audit four outcome-free model-preflight shards and filter prepared variants."""

from __future__ import annotations

import argparse
import hashlib
import json
import os
from collections import Counter
from pathlib import Path
from typing import Any, Mapping, Sequence


HERE = Path(__file__).resolve().parent
DEFAULT_PREPARED = HERE / "max_prepared_merged" / "eligible_variants.json"
DEFAULT_FROZEN = HERE / "frozen_max_t130" / "inference_manifest.json"
DEFAULT_PLAN = HERE / "launch_plan_max_t130.json"
DEFAULT_SCREEN_ROOT = HERE / "results" / "preflight"
DEFAULT_OUTPUT = HERE / "max_prepared_model_eligible"

PREPARED_SCHEMA = "long-code-obfuscated-variants-v1"
FROZEN_SCHEMA = "expanded-java-300-600-binary-freeze-v1"
PLAN_SCHEMA = "expanded-java-300-600-launch-plan-v1"
SCREEN_SCHEMA = "expanded-java-300-600-model-preflight-screen-v1"
OUTPUT_SCHEMA = "expanded-model-preflight-filtered-variants-v1"
AUDIT_SCHEMA = "expanded-model-preflight-filter-audit-v1"


class FilterError(RuntimeError):
    """Raised before output is written when an audit invariant fails."""


def json_bytes(value: Any) -> bytes:
    return (json.dumps(value, indent=2, sort_keys=True, ensure_ascii=False) + "\n").encode("utf-8")


def sha256_bytes(value: bytes) -> str:
    return hashlib.sha256(value).hexdigest()


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def sha256_json(value: Any) -> str:
    return hashlib.sha256(
        json.dumps(value, ensure_ascii=False, sort_keys=True, separators=(",", ":")).encode("utf-8")
    ).hexdigest()


def atomic_bytes(path: Path, value: bytes) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary = path.with_name(f".{path.name}.tmp-{os.getpid()}")
    temporary.write_bytes(value)
    os.replace(temporary, path)


def local_file(path: Path, label: str) -> Path:
    candidate = path.expanduser()
    candidate = candidate if candidate.is_absolute() else HERE / candidate
    resolved = candidate.resolve(strict=True)
    try:
        resolved.relative_to(HERE.resolve(strict=True))
    except ValueError as exc:
        raise FilterError(f"{label} must remain below {HERE}: {resolved}") from exc
    if not resolved.is_file():
        raise FilterError(f"{label} is not a file: {resolved}")
    return resolved


def local_output(path: Path) -> Path:
    candidate = path.expanduser()
    candidate = candidate if candidate.is_absolute() else HERE / candidate
    resolved = candidate.resolve(strict=False)
    try:
        resolved.relative_to(HERE.resolve(strict=True))
    except ValueError as exc:
        raise FilterError(f"output must remain below {HERE}: {resolved}") from exc
    if resolved.exists():
        raise FilterError(f"immutable filtered output already exists: {resolved}")
    return resolved


def relative(path: Path) -> str:
    return str(path.relative_to(HERE.resolve(strict=True)))


def load_mapping(path: Path, label: str) -> dict[str, Any]:
    try:
        value = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as exc:
        raise FilterError(f"cannot read {label}: {path}: {exc}") from exc
    if not isinstance(value, dict):
        raise FilterError(f"{label} must contain a JSON object: {path}")
    return value


def require(condition: bool, message: str) -> None:
    if not condition:
        raise FilterError(message)


def ids(rows: Sequence[Any], label: str, *, field: str = "id") -> list[str]:
    result: list[str] = []
    for index, row in enumerate(rows):
        require(isinstance(row, Mapping), f"{label}[{index}] is not an object")
        identifier = row.get(field)
        require(isinstance(identifier, str) and bool(identifier), f"{label}[{index}] has no {field}")
        result.append(identifier)
    require(len(result) == len(set(result)), f"{label} contains duplicate IDs")
    return result


def exact_int(value: Any, expected: int, label: str) -> None:
    # bool is an int subclass; reject it explicitly in count/outcome fields.
    require(type(value) is int and value == expected, f"{label} must be {expected}, got {value!r}")


def normalize_reason(program_id: str, reason: str) -> str:
    prefix = f"{program_id}: "
    return reason[len(prefix) :] if reason.startswith(prefix) else reason


def validate_screen(
    path: Path,
    summary: Mapping[str, Any],
    shard_spec: Mapping[str, Any],
    frozen_sha256: str,
    plan_sha256: str,
    plan_generation: Any,
) -> tuple[list[dict[str, Any]], list[dict[str, Any]], dict[str, Any]]:
    shard_index = shard_spec["shard_index"]
    prefix = f"screen shard {shard_index}"
    require(summary.get("schema_version") == SCREEN_SCHEMA, f"{prefix} schema differs")
    require(summary.get("status") == "screened_complete", f"{prefix} is not screened_complete")
    require(summary.get("shard_index") == shard_index, f"{prefix} index differs")
    require(summary.get("manifest_sha256") == frozen_sha256, f"{prefix} frozen manifest hash differs")
    require(summary.get("plan_sha256") == plan_sha256, f"{prefix} launch plan hash differs")
    require(summary.get("generation") == plan_generation, f"{prefix} generation settings differ")
    exact_int(summary.get("model_outcomes_generated"), 0, f"{prefix} model_outcomes_generated")
    exact_int(summary.get("study_generation_count"), 0, f"{prefix} study_generation_count")

    expected_ids = shard_spec.get("program_ids")
    require(isinstance(expected_ids, list), f"plan shard {shard_index} program_ids is not a list")
    expected = [str(value) for value in expected_ids]
    require(len(expected) == len(set(expected)), f"plan shard {shard_index} contains duplicate IDs")
    require(summary.get("program_ids") == expected, f"{prefix} assignment/order differs from plan")
    exact_int(shard_spec.get("program_count"), len(expected), f"plan shard {shard_index} program_count")
    exact_int(summary.get("program_count"), len(expected), f"{prefix} program_count")

    rows_any = summary.get("rows")
    require(isinstance(rows_any, list), f"{prefix} rows is not a list")
    row_ids = ids(rows_any, f"{prefix} rows", field="program_id")
    require(row_ids == expected, f"{prefix} rows do not preserve the complete assignment/order")
    rows = [dict(row) for row in rows_any]
    for row in rows:
        exact_int(row.get("model_outcomes_generated"), 0, f"{prefix}/{row['program_id']} outcomes")
        require(row.get("status") in {"eligible", "rejected"}, f"{prefix}/{row['program_id']} status is invalid")

    eligible_rows = [row for row in rows if row["status"] == "eligible"]
    rejected_rows = [row for row in rows if row["status"] == "rejected"]
    eligible_ids = [str(row["program_id"]) for row in eligible_rows]
    rejected_ids = [str(row["program_id"]) for row in rejected_rows]
    require(summary.get("eligible_program_ids") == eligible_ids, f"{prefix} eligible ID ledger differs from rows")
    require(summary.get("rejections") == rejected_rows, f"{prefix} rejection ledger differs from rows")
    exact_int(summary.get("eligible_program_count"), len(eligible_rows), f"{prefix} eligible_program_count")
    exact_int(summary.get("rejected_program_count"), len(rejected_rows), f"{prefix} rejected_program_count")
    require(set(eligible_ids).isdisjoint(rejected_ids), f"{prefix} eligible/rejected IDs overlap")
    require(set(eligible_ids) | set(rejected_ids) == set(expected), f"{prefix} terminal partition is incomplete")

    eligible: list[dict[str, Any]] = []
    for row in eligible_rows:
        evidence = row.get("evidence_sha256")
        require(isinstance(evidence, str) and len(evidence) == 64, f"{prefix}/{row['program_id']} lacks evidence hash")
        eligible.append(
            {
                "evidence_sha256": evidence,
                "program_id": str(row["program_id"]),
                "shard_index": shard_index,
            }
        )

    excluded: list[dict[str, Any]] = []
    for row in rejected_rows:
        reason = row.get("reason")
        reason_type = row.get("reason_type")
        require(isinstance(reason, str) and bool(reason), f"{prefix}/{row['program_id']} lacks rejection reason")
        require(isinstance(reason_type, str) and bool(reason_type), f"{prefix}/{row['program_id']} lacks reason type")
        excluded.append(
            {
                "model_outcomes_generated": 0,
                "normalized_reason": normalize_reason(str(row["program_id"]), reason),
                "program_id": str(row["program_id"]),
                "reason": reason,
                "reason_type": reason_type,
                "shard_index": shard_index,
            }
        )

    provenance = summary.get("code_provenance")
    require(isinstance(provenance, dict) and bool(provenance), f"{prefix} lacks code_provenance")
    for source, digest in provenance.items():
        require(isinstance(source, str) and isinstance(digest, str) and len(digest) == 64, f"{prefix} has invalid code provenance")
    require(frozen_sha256 in provenance.values(), f"{prefix} code provenance lacks frozen manifest hash")
    require(plan_sha256 in provenance.values(), f"{prefix} code provenance lacks launch plan hash")
    source_record = {
        "code_provenance": dict(sorted(provenance.items())),
        "eligible_program_count": len(eligible),
        "path": relative(path),
        "program_count": len(expected),
        "rejected_program_count": len(excluded),
        "sha256": sha256_file(path),
        "shard_index": shard_index,
        "status": "screened_complete",
    }
    return eligible, excluded, source_record


def filter_preflight(
    prepared_path: Path,
    frozen_path: Path,
    plan_path: Path,
    screen_paths: Sequence[Path],
    output_path: Path,
) -> dict[str, Any]:
    prepared_file = local_file(prepared_path, "prepared manifest")
    frozen_file = local_file(frozen_path, "frozen manifest")
    plan_file = local_file(plan_path, "launch plan")
    screens = [local_file(path, "preflight screen summary") for path in screen_paths]
    require(len(screens) == 4, f"exactly four preflight screen summaries are required, got {len(screens)}")
    require(len(set(screens)) == 4, "preflight screen summary paths overlap")
    output = local_output(output_path)

    prepared = load_mapping(prepared_file, "prepared manifest")
    frozen = load_mapping(frozen_file, "frozen manifest")
    plan = load_mapping(plan_file, "launch plan")
    require(prepared.get("schema_version") == PREPARED_SCHEMA, "prepared manifest schema differs")
    require(frozen.get("schema_version") == FROZEN_SCHEMA, "frozen manifest schema differs")
    require(plan.get("schema_version") == PLAN_SCHEMA, "launch plan schema differs")

    variants_any = prepared.get("variants")
    programs_any = frozen.get("programs")
    shards_any = plan.get("shards")
    require(isinstance(variants_any, list) and bool(variants_any), "prepared manifest has no variants")
    require(isinstance(programs_any, list) and bool(programs_any), "frozen manifest has no programs")
    require(isinstance(shards_any, list) and len(shards_any) == 4, "launch plan must contain four shards")
    variants = [dict(row) if isinstance(row, Mapping) else row for row in variants_any]
    prepared_ids = ids(variants, "prepared variants")
    frozen_ids = ids(programs_any, "frozen programs")
    exact_int(prepared.get("variant_count"), len(prepared_ids), "prepared variant_count")
    exact_int(frozen.get("program_count"), len(frozen_ids), "frozen program_count")
    require(set(prepared_ids) == set(frozen_ids), "prepared and frozen program cohorts differ")

    prepared_sha256 = sha256_file(prepared_file)
    frozen_sha256 = sha256_file(frozen_file)
    plan_sha256 = sha256_file(plan_file)
    require(frozen.get("source_prepared_manifest_sha256") == prepared_sha256, "frozen source prepared hash differs")
    frozen_source = frozen.get("source_prepared_manifest")
    require(isinstance(frozen_source, str), "frozen manifest lacks source prepared path")
    require(local_file(Path(frozen_source), "frozen source prepared manifest") == prepared_file, "frozen source prepared path differs")
    require(plan.get("manifest_sha256") == frozen_sha256, "launch plan frozen manifest hash differs")
    plan_manifest = plan.get("manifest_path")
    require(isinstance(plan_manifest, str), "launch plan lacks frozen manifest path")
    require(local_file(Path(plan_manifest), "plan frozen manifest") == frozen_file, "launch plan frozen manifest path differs")
    exact_int(plan.get("program_count"), len(frozen_ids), "launch plan program_count")

    shard_specs: dict[int, Mapping[str, Any]] = {}
    planned_ids: set[str] = set()
    for position, shard_any in enumerate(shards_any):
        require(isinstance(shard_any, Mapping), f"launch plan shard {position} is not an object")
        shard_index = shard_any.get("shard_index")
        require(type(shard_index) is int and shard_index >= 0, f"launch plan shard {position} index is invalid")
        require(shard_index not in shard_specs, "launch plan shard indices overlap")
        program_ids_any = shard_any.get("program_ids")
        require(isinstance(program_ids_any, list), f"launch plan shard {shard_index} lacks program IDs")
        shard_ids = [str(value) for value in program_ids_any]
        require(len(shard_ids) == len(set(shard_ids)), f"launch plan shard {shard_index} contains duplicate IDs")
        require(planned_ids.isdisjoint(shard_ids), "launch plan program assignments overlap")
        planned_ids.update(shard_ids)
        shard_specs[shard_index] = shard_any
    require(set(shard_specs) == {0, 1, 2, 3}, f"launch plan shard indices must be 0..3, got {sorted(shard_specs)}")
    require(planned_ids == set(frozen_ids), "launch plan does not cover the frozen cohort exactly")

    summaries_by_shard: dict[int, tuple[Path, dict[str, Any]]] = {}
    for path in screens:
        summary = load_mapping(path, "preflight screen summary")
        shard_index = summary.get("shard_index")
        require(type(shard_index) is int and shard_index in shard_specs, f"unexpected screen shard index: {shard_index!r}")
        require(shard_index not in summaries_by_shard, f"screen shard {shard_index} appears more than once")
        summaries_by_shard[shard_index] = (path, summary)
    require(set(summaries_by_shard) == set(shard_specs), "screen summaries do not cover all plan shards")

    eligible_records: list[dict[str, Any]] = []
    excluded_records: list[dict[str, Any]] = []
    screen_sources: list[dict[str, Any]] = []
    reference_provenance: dict[str, str] | None = None
    protocol_version: str | None = None
    for shard_index in sorted(shard_specs):
        path, summary = summaries_by_shard[shard_index]
        eligible, excluded, source = validate_screen(
            path,
            summary,
            shard_specs[shard_index],
            frozen_sha256,
            plan_sha256,
            plan.get("generation"),
        )
        current_provenance = source["code_provenance"]
        if reference_provenance is None:
            reference_provenance = current_provenance
        require(current_provenance == reference_provenance, "screen shard code provenance differs")
        current_protocol = summary.get("protocol_version")
        require(isinstance(current_protocol, str) and bool(current_protocol), f"screen shard {shard_index} lacks protocol_version")
        if protocol_version is None:
            protocol_version = current_protocol
        require(current_protocol == protocol_version, "screen shard protocol versions differ")
        eligible_records.extend(eligible)
        excluded_records.extend(excluded)
        screen_sources.append(source)

    terminal_ids = [record["program_id"] for record in eligible_records + excluded_records]
    require(len(terminal_ids) == len(set(terminal_ids)), "screen program coverage overlaps across shards")
    require(set(terminal_ids) == set(frozen_ids), "screen program coverage differs from frozen cohort")
    eligible_set = {record["program_id"] for record in eligible_records}
    excluded_set = {record["program_id"] for record in excluded_records}
    require(eligible_set.isdisjoint(excluded_set), "screen eligible and excluded cohorts overlap")
    require(eligible_set | excluded_set == set(frozen_ids), "screen terminal partition is incomplete")

    filtered_variants = [row for row in variants if row["id"] in eligible_set]
    require([row["id"] for row in filtered_variants] == [identifier for identifier in prepared_ids if identifier in eligible_set], "filter changed prepared ordering")
    require(len(filtered_variants) == len(eligible_set), "filtered variants do not match eligible IDs")

    eligible_records.sort(key=lambda row: prepared_ids.index(row["program_id"]))
    excluded_records.sort(key=lambda row: prepared_ids.index(row["program_id"]))
    reason_type_counts = Counter(record["reason_type"] for record in excluded_records)
    normalized_reason_counts = Counter(record["normalized_reason"] for record in excluded_records)
    filtered_payload = {
        "schema_version": OUTPUT_SCHEMA,
        "purpose": "prepared variants passing complete outcome-free Qwen2.5-7B model preflight",
        "selection_stage": "static_execution_and_outcome_free_model_preflight_eligibility_only_no_study_outcomes",
        "source_prepared_manifest": relative(prepared_file),
        "source_prepared_manifest_sha256": prepared_sha256,
        "source_frozen_manifest": relative(frozen_file),
        "source_frozen_manifest_sha256": frozen_sha256,
        "source_launch_plan": relative(plan_file),
        "source_launch_plan_sha256": plan_sha256,
        "model_preflight_filter_audit": "model_preflight_filter_audit.json",
        "source_variant_count": len(prepared_ids),
        "variant_count": len(filtered_variants),
        "variants": filtered_variants,
    }
    filtered_bytes = json_bytes(filtered_payload)
    script_file = Path(__file__).resolve(strict=True)
    audit = {
        "schema_version": AUDIT_SCHEMA,
        "status": "validated_complete_outcome_free_filter",
        "selection_stage": filtered_payload["selection_stage"],
        "protocol_version": protocol_version,
        "counts": {
            "eligible_programs": len(eligible_records),
            "excluded_programs": len(excluded_records),
            "frozen_programs": len(frozen_ids),
            "model_outcomes_generated": 0,
            "plan_shards": len(shard_specs),
            "prepared_variants": len(prepared_ids),
            "screened_programs": len(terminal_ids),
            "study_generations": 0,
        },
        "invariants": {
            "all_program_rows_report_zero_model_outcomes": True,
            "all_screen_summaries_terminal": True,
            "eligible_and_excluded_are_disjoint_complete_partition": True,
            "exactly_four_disjoint_screen_shards": True,
            "frozen_and_prepared_program_ids_match": True,
            "launch_plan_disjointly_covers_frozen_cohort": True,
            "screen_code_provenance_matches_across_shards": True,
            "screen_program_ids_disjointly_cover_frozen_cohort": True,
            "screen_summaries_match_frozen_manifest_sha256": True,
            "screen_summaries_match_launch_plan_sha256": True,
            "no_study_outcomes_read_or_generated": True,
        },
        "source_artifacts": {
            "filter_script": {"path": relative(script_file), "sha256": sha256_file(script_file)},
            "frozen_manifest": {"path": relative(frozen_file), "sha256": frozen_sha256},
            "launch_plan": {"path": relative(plan_file), "sha256": plan_sha256},
            "prepared_manifest": {"path": relative(prepared_file), "sha256": prepared_sha256},
            "screen_summaries": screen_sources,
        },
        "output_artifacts": {
            "eligible_variants": {
                "path": "eligible_variants.json",
                "sha256": sha256_bytes(filtered_bytes),
            },
        },
        "cohort_hashes": {
            "eligible_program_ids_sha256": sha256_json(sorted(eligible_set)),
            "excluded_program_ids_sha256": sha256_json(sorted(excluded_set)),
            "frozen_program_ids_sha256": sha256_json(sorted(frozen_ids)),
            "screened_program_ids_sha256": sha256_json(sorted(terminal_ids)),
        },
        "generation": plan.get("generation"),
        "eligible_program_ids": [record["program_id"] for record in eligible_records],
        "eligible_programs": eligible_records,
        "excluded_program_ids": [record["program_id"] for record in excluded_records],
        "excluded_programs": excluded_records,
        "exclusion_reason_type_counts": dict(sorted(reason_type_counts.items())),
        "exclusion_normalized_reason_counts": dict(sorted(normalized_reason_counts.items())),
    }

    output.mkdir(parents=True)
    try:
        atomic_bytes(output / "eligible_variants.json", filtered_bytes)
        atomic_bytes(output / "model_preflight_filter_audit.json", json_bytes(audit))
    except Exception:
        # Leave no apparently terminal directory if either immutable artifact
        # could not be committed.
        for child in output.iterdir():
            child.unlink()
        output.rmdir()
        raise
    return {
        "audit": str(output / "model_preflight_filter_audit.json"),
        "eligible_program_count": len(eligible_records),
        "excluded_program_count": len(excluded_records),
        "filtered_manifest": str(output / "eligible_variants.json"),
        "filtered_manifest_sha256": sha256_bytes(filtered_bytes),
        "model_outcomes_generated": 0,
        "screened_program_count": len(terminal_ids),
        "status": "validated_complete_outcome_free_filter",
    }


def discover_screens(root: Path) -> list[Path]:
    candidate = root.expanduser()
    candidate = candidate if candidate.is_absolute() else HERE / candidate
    resolved = candidate.resolve(strict=True)
    try:
        resolved.relative_to(HERE.resolve(strict=True))
    except ValueError as exc:
        raise FilterError(f"screen root must remain below {HERE}: {resolved}") from exc
    return sorted(resolved.glob("shard_*/preflight_screen_summary.json"))


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--prepared", type=Path, default=DEFAULT_PREPARED)
    parser.add_argument("--frozen-manifest", type=Path, default=DEFAULT_FROZEN)
    parser.add_argument("--plan", type=Path, default=DEFAULT_PLAN)
    group = parser.add_mutually_exclusive_group()
    group.add_argument("--screen-root", type=Path, default=DEFAULT_SCREEN_ROOT)
    group.add_argument("--screen-summary", type=Path, action="append")
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    args = parser.parse_args(argv)
    screen_paths = args.screen_summary if args.screen_summary is not None else discover_screens(args.screen_root)
    result = filter_preflight(args.prepared, args.frozen_manifest, args.plan, screen_paths, args.output)
    print(json.dumps(result, indent=2, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
