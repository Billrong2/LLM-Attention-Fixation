#!/usr/bin/env python3
"""Split a candidate manifest into deterministic disjoint T5-preparation shards."""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import shlex
from pathlib import Path
from typing import Any, Mapping, Sequence


HERE = Path(__file__).resolve().parent
PROMPT_ROOT = HERE.parents[1]


class SplitError(RuntimeError):
    pass


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def atomic_json(path: Path, value: Any) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary = path.with_name(f".{path.name}.tmp-{os.getpid()}")
    temporary.write_text(json.dumps(value, indent=2, sort_keys=True, ensure_ascii=False) + "\n", encoding="utf-8")
    os.replace(temporary, path)


def under_prompt(path: Path, label: str, *, existing: bool) -> Path:
    resolved = path.expanduser().resolve(strict=existing)
    try:
        resolved.relative_to(PROMPT_ROOT.resolve(strict=True))
    except ValueError as exc:
        raise SplitError(f"{label} must remain inside PromptSteering: {resolved}") from exc
    return resolved


def local(path: Path, label: str) -> Path:
    candidate = path.expanduser()
    candidate = candidate if candidate.is_absolute() else HERE / candidate
    resolved = candidate.resolve(strict=False)
    try:
        resolved.relative_to(HERE.resolve(strict=True))
    except ValueError as exc:
        raise SplitError(f"{label} must remain below {HERE}: {resolved}") from exc
    return resolved


def source_path(row: Mapping[str, Any], root: Path) -> Path:
    value = row.get("original_path") or row.get("source_path")
    if not isinstance(value, str):
        raise SplitError(f"{row.get('id')} lacks original_path")
    raw = Path(value).expanduser()
    path = (raw if raw.is_absolute() else root / raw).resolve(strict=True)
    try:
        path.relative_to(PROMPT_ROOT.resolve(strict=True))
    except ValueError as exc:
        raise SplitError(f"candidate source escapes PromptSteering: {path}") from exc
    return path


def identity(row: Mapping[str, Any]) -> tuple[int, int, str]:
    provenance = row.get("provenance") or {}
    return (
        int(provenance.get("row_index", 10**9)),
        int(provenance.get("solution_index", 10**9)),
        str(row.get("id") or ""),
    )


def build(
    manifest_path: Path,
    output_root: Path,
    prepared_root: Path,
    shard_count: int,
    selector_policy: str,
    warning_policy: str,
) -> dict[str, Any]:
    if shard_count < 1:
        raise SplitError("shard count must be positive")
    manifest = under_prompt(manifest_path, "candidate manifest", existing=True)
    payload = json.loads(manifest.read_text(encoding="utf-8"))
    rows = payload.get("samples") if isinstance(payload, Mapping) else None
    if not isinstance(rows, list) or not rows:
        raise SplitError("candidate manifest has no samples")
    identifiers = [str(row.get("id") or "") for row in rows if isinstance(row, Mapping)]
    if len(identifiers) != len(rows) or any(not value for value in identifiers) or len(set(identifiers)) != len(rows):
        raise SplitError("candidate IDs are invalid or duplicated")
    destination = local(output_root, "preparation shard root")
    prepared = local(prepared_root, "prepared-output root")
    if destination.exists() or prepared.exists():
        raise SplitError("shard input/output root already exists")
    shards: list[list[Mapping[str, Any]]] = [[] for _ in range(shard_count)]
    totals = [0] * shard_count
    ranked = sorted(rows, key=lambda row: (-source_path(row, manifest.parent).stat().st_size, identity(row)))
    for row in ranked:
        index = min(range(shard_count), key=lambda value: (totals[value], len(shards[value]), value))
        shards[index].append(row)
        totals[index] += source_path(row, manifest.parent).stat().st_size
    script = HERE / "prepare_obfuscations.py"
    commands: list[dict[str, Any]] = []
    for index, members in enumerate(shards):
        shard_dir = destination / f"shard_{index:03d}"
        normalized: list[dict[str, Any]] = []
        for row_any in sorted(members, key=identity):
            row = dict(row_any)
            row["original_path"] = str(source_path(row, manifest.parent))
            normalized.append(row)
        shard_manifest = shard_dir / "candidate_manifest.json"
        atomic_json(
            shard_manifest,
            {
                "schema_version": "expanded-preparation-input-shard-v1",
                "source_manifest": str(manifest),
                "source_manifest_sha256": sha256_file(manifest),
                "shard_index": index,
                "shard_count": shard_count,
                "sample_count": len(normalized),
                "samples": normalized,
            },
        )
        shard_output = prepared / f"shard_{index:03d}"
        argv = [
            "python3", str(script), "--manifest", str(shard_manifest),
            "--output-root", str(shard_output), "--selector-policy", selector_policy,
            "--compile-warning-policy", warning_policy,
        ]
        commands.append(
            {
                "shard_index": index,
                "candidate_count": len(normalized),
                "source_byte_proxy": totals[index],
                "candidate_ids": [str(row["id"]) for row in normalized],
                "input_manifest": str(shard_manifest),
                "input_manifest_sha256": sha256_file(shard_manifest),
                "output_root": str(shard_output),
                "argv": argv,
                "shell_command": shlex.join(argv),
            }
        )
    return {
        "schema_version": "expanded-preparation-shard-plan-v1",
        "source_manifest": str(manifest),
        "source_manifest_sha256": sha256_file(manifest),
        "candidate_count": len(rows),
        "shard_count": shard_count,
        "partition_rule": "greedy descending source bytes; canonical identity tie-break; no model outcomes",
        "selector_policy": selector_policy,
        "compile_warning_policy": warning_policy,
        "prepared_root": str(prepared),
        "shards": commands,
        "launches_performed": 0,
    }


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--manifest", type=Path, required=True)
    parser.add_argument("--shard-count", type=int, default=16)
    parser.add_argument("--output-root", type=Path, default=Path("preparation_inputs"))
    parser.add_argument("--prepared-root", type=Path, default=Path("prepared_shards"))
    parser.add_argument("--plan", type=Path, default=Path("preparation_plan.json"))
    parser.add_argument("--selector-policy", choices=("strict", "broad"), default="broad")
    parser.add_argument("--compile-warning-policy", choices=("reject", "accept_exit0"), default="accept_exit0")
    args = parser.parse_args(argv)
    plan = build(
        args.manifest,
        args.output_root,
        args.prepared_root,
        args.shard_count,
        args.selector_policy,
        args.compile_warning_policy,
    )
    destination = local(args.plan, "preparation plan")
    atomic_json(destination, plan)
    print(json.dumps({"candidate_count": plan["candidate_count"], "shard_count": plan["shard_count"], "prepared_root": plan["prepared_root"]}, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
