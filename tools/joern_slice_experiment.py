#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import random
import sys
import time
from pathlib import Path
from typing import Any, Dict, List

PROJECT_ROOT = Path(__file__).resolve().parents[1]
if str(PROJECT_ROOT) not in sys.path:
    sys.path.append(str(PROJECT_ROOT))

from steering.joern_slice import extract_joern_variable_slices  # noqa: E402


def _collect_candidates(root: Path, pattern: str) -> List[Path]:
    return sorted(path for path in root.rglob(pattern) if path.is_file())


def _summarize(records: List[Dict[str, Any]]) -> Dict[str, Any]:
    summary: Dict[str, Any] = {
        "total_runs": len(records),
        "ok_runs": 0,
        "failed_runs": 0,
        "by_direction": {},
    }
    grouped: Dict[str, List[Dict[str, Any]]] = {}
    for record in records:
        grouped.setdefault(str(record["direction"]), []).append(record)
    for direction, rows in grouped.items():
        ok = [row for row in rows if row.get("status") == "ok"]
        summary["by_direction"][direction] = {
            "runs": len(rows),
            "ok": len(ok),
            "failed": len(rows) - len(ok),
            "avg_num_variable_slices": (
                sum(float(row.get("num_variable_slices", 0)) for row in ok) / len(ok)
                if ok
                else 0.0
            ),
            "avg_num_selected_variable_slices": (
                sum(float(row.get("num_selected_variable_slices", 0)) for row in ok) / len(ok)
                if ok
                else 0.0
            ),
        }
        summary["ok_runs"] += len(ok)
    summary["failed_runs"] = summary["total_runs"] - summary["ok_runs"]
    return summary


def _write_snapshot(*, output_path: Path, meta: Dict[str, Any], records: List[Dict[str, Any]]) -> None:
    payload = {
        "meta": meta,
        "summary": _summarize(records),
        "records": records,
    }
    output_path.parent.mkdir(parents=True, exist_ok=True)
    tmp_path = output_path.with_suffix(output_path.suffix + ".tmp")
    tmp_path.write_text(json.dumps(payload, indent=2) + "\n", encoding="utf-8")
    tmp_path.replace(output_path)


def main() -> int:
    ap = argparse.ArgumentParser(description="Run Joern forward/backward slice experiments on a random corpus sample.")
    ap.add_argument("--source-root", type=Path, required=True)
    ap.add_argument("--pattern", default="*.java", help="Glob pattern used recursively under source-root.")
    ap.add_argument("--sample-size", type=int, default=50)
    ap.add_argument("--seed", type=int, default=12345)
    ap.add_argument("--language", default=None, help="Optional language hint; otherwise inferred from file extension.")
    ap.add_argument("--directions", default="backward,forward", help="Comma-separated subset of backward,forward.")
    ap.add_argument("--joern-cli-dir", type=Path, default=Path("/people/cs/x/xxr230000/bin/joern/joern-cli"))
    ap.add_argument("--cache-dir", type=Path, default=PROJECT_ROOT / ".cache" / "joern_slice")
    ap.add_argument("--slice-depth", type=int, default=20)
    ap.add_argument("--parallelism", type=int, default=1)
    ap.add_argument("--timeout-sec", type=int, default=180)
    ap.add_argument("--include-control", choices=["on", "off"], default="on")
    ap.add_argument("--include-post-dominance", choices=["on", "off"], default="off")
    ap.add_argument("--max-hops", type=int, default=None)
    ap.add_argument("--sink-filter", default=None)
    ap.add_argument("--output", type=Path, required=True)
    args = ap.parse_args()

    root = args.source_root.resolve()
    candidates = _collect_candidates(root, args.pattern)
    if not candidates:
        raise RuntimeError(f"No files matched pattern {args.pattern!r} under {root}")

    rng = random.Random(int(args.seed))
    if len(candidates) > args.sample_size:
        candidates = sorted(rng.sample(candidates, args.sample_size))

    directions = [item.strip() for item in args.directions.split(",") if item.strip()]
    for direction in directions:
        if direction not in {"backward", "forward"}:
            raise RuntimeError(f"Unsupported direction {direction!r}")

    meta = {
        "source_root": str(root),
        "pattern": args.pattern,
        "requested_sample_size": int(args.sample_size),
        "actual_sample_size": int(len(candidates)),
        "seed": int(args.seed),
        "language_hint": args.language,
        "directions": directions,
    }
    records: List[Dict[str, Any]] = []
    _write_snapshot(output_path=args.output, meta=meta, records=records)
    for source_path in candidates:
        code_text = source_path.read_text(encoding="utf-8", errors="replace")
        for direction in directions:
            started = time.perf_counter()
            record: Dict[str, Any] = {
                "source_path": str(source_path),
                "direction": direction,
                "status": "ok",
            }
            try:
                payload = extract_joern_variable_slices(
                    code_text=code_text,
                    language_hint=args.language,
                    source_path=source_path,
                    direction=direction,
                    joern_cli_dir=args.joern_cli_dir,
                    cache_dir=args.cache_dir,
                    slice_depth=args.slice_depth,
                    parallelism=args.parallelism,
                    timeout_sec=args.timeout_sec,
                    include_control=(args.include_control == "on"),
                    include_post_dominance=(args.include_post_dominance == "on"),
                    max_hops=args.max_hops,
                    sink_filter=args.sink_filter,
                )
                aggregate = payload.get("aggregate_line_scores") or {}
                top_lines = sorted(
                    ((int(line), float(score)) for line, score in aggregate.items()),
                    key=lambda item: (-item[1], item[0]),
                )[:12]
                record.update(
                    {
                        "num_variable_slices": int(payload.get("num_variable_slices", 0)),
                        "num_selected_variable_slices": int(payload.get("num_selected_variable_slices", 0)),
                        "num_graph_nodes": int(payload.get("num_graph_nodes", 0)),
                        "num_graph_edges": int(payload.get("num_graph_edges", 0)),
                        "top_lines": top_lines,
                    }
                )
            except Exception as exc:
                record["status"] = "error"
                record["error_type"] = type(exc).__name__
                record["error"] = str(exc)
            record["elapsed_sec"] = round(time.perf_counter() - started, 4)
            records.append(record)
        _write_snapshot(output_path=args.output, meta=meta, records=records)

    _write_snapshot(output_path=args.output, meta=meta, records=records)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
