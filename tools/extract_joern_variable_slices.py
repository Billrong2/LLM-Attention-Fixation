#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[1]
if str(PROJECT_ROOT) not in sys.path:
    sys.path.append(str(PROJECT_ROOT))

from steering.joern_slice import extract_joern_variable_slices  # noqa: E402


def main() -> int:
    ap = argparse.ArgumentParser(description="Extract per-variable forward/backward slices using Joern.")
    ap.add_argument("source", type=Path, help="Source file to analyze.")
    ap.add_argument("--language", default=None, help="Optional language hint (e.g. c, cpp, java, python).")
    ap.add_argument("--direction", choices=["backward", "forward"], default="backward")
    ap.add_argument("--joern-cli-dir", type=Path, default=Path("/people/cs/x/xxr230000/bin/joern/joern-cli"))
    ap.add_argument("--cache-dir", type=Path, default=PROJECT_ROOT / ".cache" / "joern_slice")
    ap.add_argument("--slice-depth", type=int, default=20)
    ap.add_argument("--parallelism", type=int, default=1)
    ap.add_argument("--timeout-sec", type=int, default=180)
    ap.add_argument("--include-control", choices=["on", "off"], default="on")
    ap.add_argument("--include-post-dominance", choices=["on", "off"], default="off")
    ap.add_argument("--max-hops", type=int, default=None)
    ap.add_argument("--sink-filter", default=None)
    ap.add_argument("--output", type=Path, default=None)
    args = ap.parse_args()

    source_path = args.source.resolve()
    code_text = source_path.read_text(encoding="utf-8", errors="replace")
    payload = extract_joern_variable_slices(
        code_text=code_text,
        language_hint=args.language,
        source_path=source_path,
        direction=args.direction,
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

    rendered = json.dumps(payload, indent=2)
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(rendered + "\n", encoding="utf-8")
    else:
        print(rendered)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
