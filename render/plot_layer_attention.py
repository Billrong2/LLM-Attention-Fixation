#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import re
from pathlib import Path
from typing import Dict, Iterable, List, Optional, Sequence, Tuple

try:
    import matplotlib

    matplotlib.use("Agg")
    import matplotlib.pyplot as plt
except ImportError as exc:  # pragma: no cover - convenience
    raise SystemExit("matplotlib is required for plotting. Install via 'pip install matplotlib'.") from exc


LEVEL_LAYER_RANGES: Dict[int, Sequence[int]] = {
    1: list(range(52, 80)),
    2: list(range(52, 80)),
    3: list(range(40, 64)),
    4: list(range(60, 80)),
    # level 5 operates on logits; no layer-specific steering
}


def _format_level_label(variant: str) -> List[int]:
    if variant.startswith("levels-"):
        return sorted({int(num) for num in re.findall(r"L(\d+)", variant)})
    return []


def _plot_layer_bars(values: Sequence[float], layer_indices: Sequence[int], title: str, outfile: Path) -> None:
    if not layer_indices:
        return
    heights = [values[idx] if 0 <= idx < len(values) else 0.0 for idx in layer_indices]
    if sum(heights) == 0:
        return
    plt.figure(figsize=(max(8.0, len(layer_indices) * 0.35), 4.5))
    xs = list(range(len(layer_indices)))
    plt.bar(xs, heights, color="#2E86AB")
    plt.xticks(xs, layer_indices, rotation=45, ha="right", fontsize=8)
    plt.ylabel("Avg prompt attention mass")
    plt.title(title)
    plt.tight_layout()
    outfile.parent.mkdir(parents=True, exist_ok=True)
    plt.savefig(outfile)
    plt.close()


def _discover_runs(
    snippet_dir: Path,
    variants_filter: Optional[Sequence[str]],
    priors_filter: Optional[Sequence[str]],
) -> Iterable[Tuple[str, str, str, str, Path]]:
    snippet = snippet_dir.name
    for variant_dir in sorted(p for p in snippet_dir.iterdir() if p.is_dir()):
        variant = variant_dir.name
        if variants_filter and variant not in variants_filter:
            continue
        for prior_dir in sorted(p for p in variant_dir.iterdir() if p.is_dir()):
            prior = prior_dir.name
            if priors_filter and prior not in priors_filter:
                continue
            for outcome_dir in sorted(p for p in prior_dir.iterdir() if p.is_dir()):
                outcome = outcome_dir.name
                for run_dir in sorted(p for p in outcome_dir.iterdir() if p.is_dir()):
                    yield snippet, variant, prior, outcome, run_dir


def render_charts_for_run(
    snippet: str,
    variant: str,
    prior: str,
    outcome: str,
    run_dir: Path,
    include_all_layers: bool,
) -> None:
    model_path = run_dir / "model_output.json"
    if not model_path.is_file():
        print(f"[WARN] Missing model_output.json in {run_dir}")
        return
    with model_path.open("r", encoding="utf-8") as fh:
        data = json.load(fh)
    stats = data.get("layer_prompt_stats")
    if not stats:
        print(f"[WARN] layer_prompt_stats missing for {run_dir}")
        return
    values = stats.get("prompt_mass_per_layer") or []
    if not values:
        print(f"[WARN] No per-layer data recorded for {run_dir}")
        return

    base_title = f"{snippet} | {variant} | prior={prior} | {outcome} run {run_dir.name}"
    if include_all_layers or variant == "baseline":
        outfile = run_dir / "layer_attention_all_layers.png"
        _plot_layer_bars(values, list(range(len(values))), f"{base_title} - All layers", outfile)

    levels = _format_level_label(variant)
    for level in levels:
        layer_range = LEVEL_LAYER_RANGES.get(level)
        if not layer_range:
            continue
        outfile = run_dir / f"layer_attention_level{level}.png"
        title = f"{base_title} - Level {level} layers"
        _plot_layer_bars(values, layer_range, title, outfile)


def generate_layer_attention_plots(
    project_root: Path,
    snippets: Optional[Sequence[str]] = None,
    variants: Optional[Sequence[str]] = None,
    priors: Optional[Sequence[str]] = None,
    include_baseline_all: bool = False,
) -> None:
    attn_root = project_root / "attn_viz"
    if not attn_root.exists():
        raise FileNotFoundError(f"No attn_viz directory found at {attn_root}")

    snippet_filter = set(s.strip() for s in snippets) if snippets else None
    variants_filter = [v.strip() for v in variants] if variants else None
    priors_filter = [p.strip() for p in priors] if priors else None
    found = False

    for snippet_dir in sorted(p for p in attn_root.iterdir() if p.is_dir()):
        if snippet_filter and snippet_dir.name not in snippet_filter:
            continue
        for snippet, variant, prior, outcome, run_dir in _discover_runs(
            snippet_dir, variants_filter, priors_filter
        ):
            found = True
            render_charts_for_run(
                snippet,
                variant,
                prior,
                outcome,
                run_dir,
                include_all_layers=include_baseline_all,
            )

    if not found:
        print("[WARN] No runs matched the provided filters.")


def _parse_csv_arg(value: Optional[str]) -> Optional[Sequence[str]]:
    if not value:
        return None
    items = [token.strip() for token in value.split(",") if token.strip()]
    return items or None


def _cli() -> None:
    parser = argparse.ArgumentParser(description="Plot per-layer attention mass for runs in attn_viz.")
    parser.add_argument(
        "--project-root",
        type=Path,
        default=Path(__file__).resolve().parents[1],
        help="Root of the eyetracking project.",
    )
    parser.add_argument("--snippets", type=str, default=None, help="Comma-separated snippets (default: all).")
    parser.add_argument("--variants", type=str, default=None, help="Comma-separated variants (default: all).")
    parser.add_argument("--priors", type=str, default=None, help="Comma-separated priors (default: all).")
    parser.add_argument(
        "--include-baseline-all",
        action="store_true",
        default=False,
        help="Plot all-layer chart for every variant (not just baseline).",
    )
    args = parser.parse_args()
    generate_layer_attention_plots(
        project_root=args.project_root,
        snippets=_parse_csv_arg(args.snippets),
        variants=_parse_csv_arg(args.variants),
        priors=_parse_csv_arg(args.priors),
        include_baseline_all=args.include_baseline_all,
    )


if __name__ == "__main__":
    _cli()
