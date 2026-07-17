#!/usr/bin/env python3
from __future__ import annotations

import argparse
from pathlib import Path


def main() -> None:
    parser = argparse.ArgumentParser(description="Emit a comma-separated shard of dataset snippet names.")
    parser.add_argument("--project-root", type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument("--dataset", choices=["humaneval", "cruxeval"], required=True)
    parser.add_argument("--shard-index", type=int, required=True)
    parser.add_argument("--num-shards", type=int, default=4)
    args = parser.parse_args()

    from prompt_steering_common import collect_original_sources

    snippets = [snippet for snippet, _path in collect_original_sources(project_root=args.project_root, dataset=args.dataset)]
    shard = snippets[int(args.shard_index) :: max(1, int(args.num_shards))]
    print(",".join(shard))


if __name__ == "__main__":
    main()
