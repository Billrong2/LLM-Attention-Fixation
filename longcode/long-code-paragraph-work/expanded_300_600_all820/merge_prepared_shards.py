#!/usr/bin/env python3
"""Deterministically audit and merge disjoint prepared-variant shards."""

from __future__ import annotations

import argparse
import hashlib
import json
import os
from pathlib import Path
from typing import Any, Iterable, Mapping, Sequence


HERE = Path(__file__).resolve().parent
PROMPT_ROOT = HERE.parents[1]


class MergeError(RuntimeError):
    pass


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


def atomic_json(path: Path, value: Any) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary = path.with_name(f".{path.name}.tmp-{os.getpid()}")
    temporary.write_text(json.dumps(value, indent=2, sort_keys=True, ensure_ascii=False) + "\n", encoding="utf-8")
    os.replace(temporary, path)


def write_jsonl(path: Path, rows: Iterable[Mapping[str, Any]]) -> None:
    path.write_text("".join(json.dumps(row, sort_keys=True, ensure_ascii=False) + "\n" for row in rows), encoding="utf-8")


def local(path: Path, label: str, *, existing: bool) -> Path:
    candidate = path.expanduser()
    candidate = candidate if candidate.is_absolute() else HERE / candidate
    resolved = candidate.resolve(strict=existing)
    try:
        resolved.relative_to(HERE.resolve(strict=True))
    except ValueError as exc:
        raise MergeError(f"{label} must remain below {HERE}: {resolved}") from exc
    return resolved


def absolutize(row_any: Mapping[str, Any], shard: Path) -> dict[str, Any]:
    row = json.loads(json.dumps(row_any))
    path_slots = [
        (row, "original_path"),
        (row, "obfuscated_path"),
        (row, "obfuscation_metadata_path"),
        (row.get("original", {}), "path"),
        (row.get("original", {}), "execution_validation_path"),
        (row.get("obfuscated", {}), "path"),
        (row.get("obfuscated", {}), "metadata_path"),
    ]
    for parent, key in path_slots:
        if not isinstance(parent, dict) or not isinstance(parent.get(key), str):
            continue
        raw = Path(parent[key]).expanduser()
        path = (raw if raw.is_absolute() else shard / raw).resolve(strict=True)
        try:
            path.relative_to(PROMPT_ROOT.resolve(strict=True))
        except ValueError as exc:
            raise MergeError(f"prepared path escapes PromptSteering: {path}") from exc
        parent[key] = str(path)
    return row


def canonical(row: Mapping[str, Any]) -> tuple[int, int, str]:
    provenance = (row.get("candidate_metadata") or {}).get("provenance") or {}
    return int(provenance.get("row_index", 10**9)), int(provenance.get("solution_index", 10**9)), str(row.get("id") or row.get("candidate_id") or "")


def merge(plan_path: Path, output_path: Path) -> dict[str, Any]:
    plan_file = local(plan_path, "preparation plan", existing=True)
    plan = json.loads(plan_file.read_text(encoding="utf-8"))
    if not isinstance(plan, dict) or plan.get("schema_version") != "expanded-preparation-shard-plan-v1":
        raise MergeError("invalid preparation plan")
    output = local(output_path, "merged output", existing=False)
    if output.exists():
        raise MergeError(f"merged output already exists: {output}")
    expected_ids = {identifier for shard in plan["shards"] for identifier in shard["candidate_ids"]}
    if len(expected_ids) != plan["candidate_count"]:
        raise MergeError("preparation plan candidate IDs overlap")
    terminal: set[str] = set()
    eligible: list[dict[str, Any]] = []
    attempts: list[dict[str, Any]] = []
    rejections: list[dict[str, Any]] = []
    policies: list[dict[str, Any]] = []
    source_hashes: dict[str, str] = {}
    for shard_spec in plan["shards"]:
        shard = Path(str(shard_spec["output_root"])).resolve(strict=True)
        for filename in ("summary.json", "eligible_variants.json", "all_variant_attempts.json", "rejections.jsonl", "wrapper_policy.json"):
            if not (shard / filename).is_file():
                raise MergeError(f"incomplete prepared shard: {shard}/{filename}")
        summary = json.loads((shard / "summary.json").read_text(encoding="utf-8"))
        if summary.get("candidate_count") != shard_spec["candidate_count"]:
            raise MergeError(f"prepared shard candidate count differs: {shard}")
        policies.append(json.loads((shard / "wrapper_policy.json").read_text(encoding="utf-8")))
        eligible_raw = json.loads((shard / "eligible_variants.json").read_text(encoding="utf-8"))["variants"]
        attempts_raw = json.loads((shard / "all_variant_attempts.json").read_text(encoding="utf-8"))["variants"]
        rejection_raw = [json.loads(line) for line in (shard / "rejections.jsonl").read_text(encoding="utf-8").splitlines() if line.strip()]
        eligible.extend(absolutize(row, shard) for row in eligible_raw)
        attempts.extend(absolutize(row, shard) if row.get("variant_record_path") or row.get("original_path") else dict(row) for row in attempts_raw)
        for raw in rejection_raw:
            row = dict(raw)
            if isinstance(row.get("variant_record_path"), str):
                path = (shard / row["variant_record_path"]).resolve(strict=True)
                row["variant_record_path"] = str(path)
            rejections.append(row)
        observed = {str(row.get("candidate_id") or "") for row in eligible_raw + rejection_raw}
        expected = set(shard_spec["candidate_ids"])
        if observed != expected:
            raise MergeError(f"shard terminal candidate coverage differs: {shard}")
        if terminal & observed:
            raise MergeError("candidate appears in more than one prepared shard")
        terminal |= observed
        source_hashes[str(shard)] = sha256_file(shard / "eligible_variants.json")
    if terminal != expected_ids:
        raise MergeError("merged terminal coverage differs from preparation plan")
    eligible_ids = [str(row["candidate_id"]) for row in eligible]
    if len(eligible_ids) != len(set(eligible_ids)):
        raise MergeError("eligible candidate IDs overlap")
    policy_core = {
        (row.get("selector_policy"), row.get("compile_warning_policy"), row.get("selector_policy_protocol_changing"), row.get("compile_warning_policy_protocol_changing"))
        for row in policies
    }
    if len(policy_core) != 1:
        raise MergeError("prepared shard policies differ")
    output.mkdir(parents=True)
    eligible.sort(key=canonical)
    attempts.sort(key=canonical)
    rejections.sort(key=lambda row: (str(row.get("candidate_id")), str(row.get("variant_id")), str(row.get("stage"))))
    atomic_json(
        output / "eligible_variants.json",
        {
            "schema_version": "long-code-obfuscated-variants-v1",
            "purpose": "deterministically merged eligible variants from disjoint CPU shards",
            "selection_stage": "static_and_execution_eligibility_only_no_model_outcomes",
            "variant_count": len(eligible),
            "variants": eligible,
        },
    )
    atomic_json(output / "all_variant_attempts.json", {"schema_version": "long-code-obfuscated-variants-v1", "variant_count": len(attempts), "variants": attempts})
    write_jsonl(output / "rejections.jsonl", rejections)
    policy = dict(policies[0])
    policy["candidate_manifest"] = "multiple disjoint manifests registered in merge_audit.json"
    policy["candidate_manifest_sha256"] = None
    atomic_json(output / "wrapper_policy.json", policy)
    summary = {
        "schema_version": "expanded-prepared-merge-v1",
        "candidate_count": len(expected_ids),
        "terminal_candidate_count": len(terminal),
        "eligible_variant_count": len(eligible),
        "rejected_candidate_count": len(expected_ids) - len(eligible),
        "attempted_variant_count": len(attempts),
        "rejection_record_count": len(rejections),
        "model_outputs_read": False,
    }
    atomic_json(output / "summary.json", summary)
    atomic_json(
        output / "merge_audit.json",
        {
            **summary,
            "preparation_plan": str(plan_file),
            "preparation_plan_sha256": sha256_file(plan_file),
            "source_eligible_manifest_sha256": source_hashes,
            "terminal_candidate_ids_sha256": sha256_json(sorted(terminal)),
            "policies": policies,
        },
    )
    return summary


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--plan", type=Path, required=True)
    parser.add_argument("--output", type=Path, default=Path("prepared_merged"))
    args = parser.parse_args(argv)
    print(json.dumps(merge(args.plan, args.output), indent=2, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
