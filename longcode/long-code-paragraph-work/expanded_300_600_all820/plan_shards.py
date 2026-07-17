#!/usr/bin/env python3
"""Create an outcome-blind size-balanced GPU plan; never launch a process."""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import shlex
from pathlib import Path
from typing import Any, Mapping, Sequence


HERE = Path(__file__).resolve().parent
DEFAULT_MANIFEST = HERE / "frozen" / "inference_manifest.json"
DEFAULT_PLAN = HERE / "launch_plan.json"


class PlanError(RuntimeError):
    pass


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def local(path: Path, label: str, *, existing: bool) -> Path:
    candidate = path.expanduser()
    candidate = candidate if candidate.is_absolute() else HERE / candidate
    resolved = candidate.resolve(strict=existing)
    try:
        resolved.relative_to(HERE.resolve(strict=True))
    except ValueError as exc:
        raise PlanError(f"{label} must remain below {HERE}: {resolved}") from exc
    return resolved


def weight(row: Mapping[str, Any], manifest_root: Path) -> int:
    original = (manifest_root / str(row["original_path"])).resolve(strict=True)
    obfuscated = (manifest_root / str(row["obfuscated_path"])).resolve(strict=True)
    cases = row.get("cases") or []
    case_bytes = sum(
        len(str(case.get("stdin", "")).encode("utf-8"))
        + len(str(case.get("candidate_stdout", "")).encode("utf-8"))
        for case in cases
    )
    return original.stat().st_size + 2 * obfuscated.stat().st_size + 3 * case_bytes


def _problem_key(row: Mapping[str, Any]) -> str:
    """Keep correlated solutions of one dataset problem on one GPU."""
    provenance = row.get("provenance")
    if isinstance(provenance, Mapping) and provenance.get("row_index") is not None:
        return f"dataset-row-{int(provenance['row_index']):03d}"
    return f"program-{row['id']}"


def partition(rows: Sequence[Mapping[str, Any]], root: Path, shard_count: int) -> list[list[Mapping[str, Any]]]:
    if shard_count < 1:
        raise PlanError("shard count must be positive")
    shards: list[list[Mapping[str, Any]]] = [[] for _ in range(shard_count)]
    totals = [0] * shard_count
    grouped: dict[str, list[Mapping[str, Any]]] = {}
    for row in rows:
        grouped.setdefault(_problem_key(row), []).append(row)
    ranked = sorted(
        grouped.items(),
        key=lambda item: (
            -sum(weight(row, root) for row in item[1]),
            item[0],
        ),
    )
    for _problem, members in ranked:
        index = min(range(shard_count), key=lambda value: (totals[value], len(shards[value]), value))
        ordered = sorted(members, key=lambda row: str(row["id"]))
        shards[index].extend(ordered)
        totals[index] += sum(weight(row, root) for row in ordered)
    return shards


def build(manifest_path: Path, gpu_ids: Sequence[int], plan_path: Path = DEFAULT_PLAN) -> dict[str, Any]:
    manifest = local(manifest_path, "frozen manifest", existing=True)
    anchor = manifest.with_suffix(".sha256")
    fields = anchor.read_text(encoding="utf-8").strip().split()
    digest = sha256_file(manifest)
    if fields != [digest, manifest.name]:
        raise PlanError("manifest anchor differs")
    payload = json.loads(manifest.read_text(encoding="utf-8"))
    programs = payload.get("programs") if isinstance(payload, Mapping) else None
    if not isinstance(programs, list) or len(programs) != payload.get("program_count"):
        raise PlanError("invalid frozen program list")
    if len(gpu_ids) != len(set(gpu_ids)) or any(gpu < 0 for gpu in gpu_ids):
        raise PlanError("GPU IDs must be distinct non-negative integers")
    memberships = partition(programs, manifest.parent, len(gpu_ids))
    runner = HERE / "run_shard.py"
    shards: list[dict[str, Any]] = []
    for index, (gpu, members) in enumerate(zip(gpu_ids, memberships)):
        ids = [str(row["id"]) for row in sorted(members, key=lambda row: str(row["id"]))]
        output = HERE / "results" / "study" / f"shard_{index}"
        preflight = HERE / "results" / "preflight" / f"shard_{index}"
        common = [
            "python3", str(runner), "--manifest", str(manifest),
            "--plan", str(plan_path.resolve(strict=False)),
            "--gpu-id", str(gpu), "--program-ids", ",".join(ids),
        ]
        shards.append(
            {
                "shard_index": index,
                "gpu_id": gpu,
                "program_ids": ids,
                "program_count": len(ids),
                "prompt_byte_proxy": sum(weight(row, manifest.parent) for row in members),
                "generation_count": len(ids) * 3,
                "labels_per_condition": len(ids) * 6,
                "preflight_output_root": str(preflight),
                "preflight_argv": common + ["--model-preflight-only", "--output-root", str(preflight)],
                "preflight_shell_command": shlex.join(common + ["--model-preflight-only", "--output-root", str(preflight)]),
                "study_output_root": str(output),
                "study_argv": common + ["--output-root", str(output)],
                "study_shell_command": shlex.join(common + ["--output-root", str(output)]),
                "preflight_tmux_session": f"expanded-t130-preflight-s{index}",
                "study_tmux_session": f"expanded-t130-study-s{index}",
            }
        )
    return {
        "schema_version": "expanded-java-300-600-launch-plan-v1",
        "manifest_path": str(manifest),
        "manifest_sha256": digest,
        "program_count": len(programs),
        "conditions": payload["conditions"],
        "generation": payload["generation"],
        "total_generation_count": len(programs) * 3,
        "labels_per_condition": len(programs) * 6,
        "total_label_judgments": len(programs) * 18,
        "partition_rule": (
            "group by immutable dataset row, then greedily balance descending group "
            "prompt-byte proxy before model outcomes"
        ),
        "same_dataset_problem_confined_to_one_shard": True,
        "gpu_ids": list(gpu_ids),
        "shards": shards,
        "launches_performed_by_planner": 0,
    }


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--manifest", type=Path, default=DEFAULT_MANIFEST)
    parser.add_argument("--gpu-ids", default="0,1,2,3")
    parser.add_argument("--write", type=Path, default=DEFAULT_PLAN)
    args = parser.parse_args(argv)
    try:
        gpu_ids = [int(value) for value in args.gpu_ids.split(",") if value.strip()]
    except ValueError as exc:
        raise PlanError("--gpu-ids must be comma-separated integers") from exc
    destination = local(args.write, "launch plan", existing=False)
    plan = build(args.manifest, gpu_ids, destination)
    destination.parent.mkdir(parents=True, exist_ok=True)
    temporary = destination.with_name(f".{destination.name}.tmp-{os.getpid()}")
    temporary.write_text(json.dumps(plan, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    os.replace(temporary, destination)
    print(json.dumps({key: plan[key] for key in ("program_count", "total_generation_count", "labels_per_condition", "total_label_judgments")}, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
