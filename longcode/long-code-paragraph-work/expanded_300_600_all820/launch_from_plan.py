#!/usr/bin/env python3
"""Validate and optionally launch the four registered tmux shard commands."""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import subprocess
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Mapping, Sequence


HERE = Path(__file__).resolve().parent
DEFAULT_PLAN = HERE / "launch_plan.json"


class LaunchError(RuntimeError):
    pass


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def local(path: Path, *, existing: bool) -> Path:
    candidate = path.expanduser()
    candidate = candidate if candidate.is_absolute() else HERE / candidate
    resolved = candidate.resolve(strict=existing)
    try:
        resolved.relative_to(HERE.resolve(strict=True))
    except ValueError as exc:
        raise LaunchError(f"path escapes expansion namespace: {resolved}") from exc
    return resolved


def load_plan(path: Path) -> tuple[Path, dict[str, Any]]:
    plan_path = local(path, existing=True)
    value = json.loads(plan_path.read_text(encoding="utf-8"))
    if not isinstance(value, dict) or value.get("schema_version") != "expanded-java-300-600-launch-plan-v1":
        raise LaunchError("invalid launch plan")
    manifest = Path(str(value.get("manifest_path"))).resolve(strict=True)
    if sha256_file(manifest) != value.get("manifest_sha256"):
        raise LaunchError("launch-plan manifest binding is stale")
    if value.get("launches_performed_by_planner") != 0:
        raise LaunchError("planner unexpectedly performed launches")
    return plan_path, value


def tmux_sessions() -> set[str]:
    run = subprocess.run(
        ["tmux", "list-sessions", "-F", "#{session_name}"],
        stdout=subprocess.PIPE,
        stderr=subprocess.DEVNULL,
        text=True,
        check=False,
    )
    return set(run.stdout.splitlines()) if run.returncode == 0 else set()


def atomic_json(path: Path, value: Mapping[str, Any]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary = path.with_name(f".{path.name}.tmp-{os.getpid()}")
    temporary.write_text(json.dumps(value, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    os.replace(temporary, path)


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--plan", type=Path, default=DEFAULT_PLAN)
    parser.add_argument(
        "--mode", choices=("preflight-screen", "preflight", "study"), required=True
    )
    parser.add_argument("--execute", action="store_true", help="without this flag, print only")
    args = parser.parse_args(argv)
    plan_path, plan = load_plan(args.plan)
    shards = plan.get("shards")
    if not isinstance(shards, list) or not shards:
        raise LaunchError("plan has no shards")
    if args.mode == "study":
        missing = [
            str(Path(str(row["preflight_output_root"])) / "preflight_summary.json")
            for row in shards
            if not (Path(str(row["preflight_output_root"])) / "preflight_summary.json").is_file()
        ]
        if missing:
            raise LaunchError(f"all shard preflights must pass before study launch: {missing}")
        plan_sha = sha256_file(plan_path)
        invalid: list[str] = []
        for row in shards:
            summary_path = Path(str(row["preflight_output_root"])) / "preflight_summary.json"
            summary = json.loads(summary_path.read_text(encoding="utf-8"))
            required = {
                "status": "passed",
                "manifest_sha256": plan["manifest_sha256"],
                "plan_sha256": plan_sha,
                "program_ids": row["program_ids"],
                "generation": plan["generation"],
                "study_generation_count": 0,
            }
            if any(summary.get(key) != value for key, value in required.items()):
                invalid.append(str(summary_path))
        if invalid:
            raise LaunchError(f"stale or failed shard preflights: {invalid}")
    commands = []
    for row in shards:
        plan_mode = "preflight" if args.mode == "preflight-screen" else args.mode
        argv = list(row[f"{plan_mode}_argv"])
        session = str(row[f"{plan_mode}_tmux_session"])
        if args.mode == "preflight-screen":
            try:
                index = argv.index("--model-preflight-only")
            except ValueError as exc:
                raise LaunchError("preflight argv lacks its registered mode flag") from exc
            argv[index] = "--model-preflight-screen"
            session = session.replace("-preflight-", "-preflight-screen-")
        commands.append(
            {
                "shard_index": row["shard_index"],
                "session": session,
                "argv": argv,
            }
        )
    print(json.dumps({"mode": args.mode, "execute": args.execute, "commands": commands}, indent=2))
    if not args.execute:
        return 0
    existing = tmux_sessions()
    collisions = [row["session"] for row in commands if row["session"] in existing]
    if collisions:
        raise LaunchError(f"tmux session collision: {collisions}")
    status_root = HERE / "launch_status" / args.mode
    for row in commands:
        run = subprocess.run(
            ["tmux", "new-session", "-d", "-s", str(row["session"]), *map(str, row["argv"])],
            check=False,
        )
        if run.returncode != 0:
            raise LaunchError(f"tmux launch failed for shard {row['shard_index']}")
        atomic_json(
            status_root / f"shard_{row['shard_index']}.json",
            {
                "status": "launched",
                "mode": args.mode,
                "session": row["session"],
                "argv": row["argv"],
                "plan_path": str(plan_path),
                "plan_sha256": sha256_file(plan_path),
                "launched_utc": datetime.now(timezone.utc).isoformat(),
            },
        )
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (LaunchError, FileNotFoundError, ValueError, TypeError) as exc:
        raise SystemExit(f"ERROR: {exc}")
