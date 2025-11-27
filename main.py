# main.py

from __future__ import annotations

import argparse
import os
from pathlib import Path
import re
import json
import copy
import shutil
from typing import Any, Dict, List, Optional, Sequence, Tuple

import numpy as np
from models import llama70b
from util import utity
from render.util import AttentionRenderer, RenderConfig
from steering import SteeringConfig


def _canonicalize_model_output(text: str) -> tuple[str, bool]:
    """
    Normalize model output to remove common formatting artifacts while preserving content.

    Returns a tuple of (normalized_output, format_found).
    """
    if not text:
        return "", False

    stripped = text.strip()
    fence_pattern = re.compile(r"```(\w+)?\s*\n?(.*?)\n?```", re.DOTALL)
    matches = list(fence_pattern.finditer(stripped))
    for m in reversed(matches):
        candidate = (m.group(2) or "").strip()
        if not candidate:
            continue
        lowered = candidate.lower()
        if "<your answer>" in lowered:
            continue
        if lowered.startswith("class ") or lowered.startswith("import "):
            continue
        return candidate, True

    # Handle \begin{code} ... ``` or \end{code}
    code_match = re.search(r"\\begin\{code\}(.*?)(?:```|\\end\{code\}|$)", stripped, re.DOTALL)
    if code_match:
        cand = code_match.group(1).strip()
        if cand:
            return cand, True

    # Fallback: take everything after the last fence if present, else try trailing numeric block.
    if matches:
        last_end = matches[-1].end()
        tail = stripped[last_end:].strip()
        if tail:
            return tail, True

    # Trailing numeric/non-alpha block heuristic
    lines = stripped.splitlines()
    collected: List[str] = []
    for line in reversed(lines):
        if line.strip() == "":
            if collected:
                break
            continue
        if re.search(r"[A-Za-z]", line):
            if collected:
                break
            continue
        collected.append(line.strip())
    if collected:
        return "\n".join(reversed(collected)), True

    return stripped, False


def _compute_generated_token_spans(
    tokenizer,
    token_ids_all: Sequence[int],
    prompt_len: int,
) -> List[Tuple[int, int]]:
    generated_ids = token_ids_all[prompt_len:]
    spans: List[Tuple[int, int]] = []
    if not generated_ids:
        return spans

    decoded_prev = ""
    for idx in range(len(generated_ids)):
        current = tokenizer.decode(generated_ids[: idx + 1], skip_special_tokens=True)
        spans.append((len(decoded_prev), len(current)))
        decoded_prev = current
    return spans


def _classify_generation_phases(
    result: Dict[str, Any],
    tokenizer,
) -> Tuple[Dict[int, str], Dict[str, Tuple[int, int]]]:
    completion = result.get("generated_completion", "")
    lower = completion.lower()

    # Identify the likely answer as the *last* non-Java fenced block.
    answer_start = -1
    answer_end = -1
    search_pos = 0
    while True:
        idx = lower.find("```", search_pos)
        if idx == -1:
            break
        lang_token = lower[idx : idx + 8]
        if "```java" in lang_token:
            search_pos = idx + 3
            continue
        answer_start = idx
        end_idx = lower.find("```", idx + 3)
        if end_idx != -1:
            answer_end = end_idx + 3
        search_pos = idx + 3
    if answer_start == -1:
        answer_start = len(completion)
    if answer_end == -1:
        answer_end = len(completion)

    # Explanation flagged by keyword if present.
    expl_start = lower.find("explanation")
    if expl_start == -1 or expl_start >= answer_start:
        expl_start = answer_start

    reading_range = (0, max(0, expl_start))
    reasoning_range = (expl_start, max(expl_start, answer_start))
    answer_range = (answer_start, answer_end)

    token_spans = _compute_generated_token_spans(
        tokenizer,
        result.get("token_ids_all", []),
        result.get("prompt_length_tokens", 0),
    )

    phase_by_step: Dict[int, str] = {}
    for idx, (start_char, end_char) in enumerate(token_spans):
        phase = "reading"
        if answer_range[0] < answer_range[1] and answer_range[0] <= start_char < answer_range[1]:
            phase = "answering"
        elif reasoning_range[0] < reasoning_range[1] and reasoning_range[0] <= start_char < reasoning_range[1]:
            phase = "reasoning"
        phase_by_step[idx] = phase

    phase_ranges = {
        "reading": reading_range,
        "answering": answer_range,
        "reasoning": reasoning_range,
    }
    return phase_by_step, phase_ranges


def _aggregate_phase_prompt_scores(
    result: Dict[str, Any],
    phase_assignments: Dict[int, str],
    pool_name: str,
) -> Tuple[Dict[str, List[float]], Dict[str, int]]:
    prompt_len = result.get("prompt_length_tokens", 0)
    per_step = result.get("pooled_attention_by_generated_token", [])
    aggregators: Dict[str, np.ndarray] = {}
    counts: Dict[str, int] = {}

    for entry in per_step:
        step = entry.get("generated_step")
        if step is None:
            continue
        phase = phase_assignments.get(step)
        if not phase:
            continue
        prompt_scores = entry.get("prompt_scores", {}).get(pool_name)
        if not prompt_scores:
            continue
        if phase not in aggregators:
            aggregators[phase] = np.zeros(prompt_len, dtype=float)
            counts[phase] = 0
        aggregators[phase] += np.asarray(prompt_scores, dtype=float)
        counts[phase] += 1

    for phase in phase_assignments.values():
        aggregators.setdefault(phase, np.zeros(prompt_len, dtype=float))
        counts.setdefault(phase, 0)

    phase_scores: Dict[str, List[float]] = {}
    for phase, arr in aggregators.items():
        count = counts.get(phase, 0)
        if count > 0:
            phase_scores[phase] = (arr / count).tolist()
        else:
            phase_scores[phase] = [0.0] * prompt_len

    return phase_scores, counts


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Eyetracking collection with optional steering.")
    parser.add_argument("--level1", action="store_true")
    parser.add_argument("--level2", action="store_true")
    parser.add_argument("--level3", action="store_true")
    parser.add_argument("--level4", action="store_true")
    parser.add_argument("--level5", action="store_true")
    parser.add_argument("--prior", choices=["human", "ast", "lex", "rand"], default="human")
    parser.add_argument("--n-bins", type=int, default=8)
    parser.add_argument("--binning", choices=["equal_count"], default="equal_count")
    parser.add_argument("--beta-bias", type=float, default=0.0)
    parser.add_argument("--beta-post", type=float, default=0.0)
    parser.add_argument("--lambda-attn", type=float, default=1.0)
    parser.add_argument("--lambda-mlp", type=float, default=1.0)
    parser.add_argument("--alpha-k", type=float, default=0.0)
    parser.add_argument("--alpha-v", type=float, default=0.0)
    parser.add_argument("--beta-ptr", type=float, default=0.0)
    parser.add_argument("--bias-cap", type=float, default=None)
    parser.add_argument("--gamma-min", type=float, default=0.0)
    parser.add_argument("--gamma-max", type=float, default=5.0)
    parser.add_argument("--eta-min", type=float, default=0.0)
    parser.add_argument("--eta-max", type=float, default=5.0)
    parser.add_argument("--human-file", type=Path, default=None)
    parser.add_argument("--lex-window", type=int, default=32)
    parser.add_argument("--rand-seed", type=int, default=None)
    parser.add_argument("--schedule-json", type=Path, default=None)
    parser.add_argument("--runs-per-snippet", type=int, default=20, help="Number of generations per snippet.")
    parser.add_argument("--skip-steering", action="store_true")
    parser.add_argument("--snippet", type=str, default=None, help="Run only this snippet (single name without .java).")
    parser.add_argument(
        "--snippets",
        type=str,
        default=None,
        help="Comma-separated list of snippet names to run. Defaults to all when omitted.",
    )
    return parser.parse_args()


def build_steering_config(args: argparse.Namespace) -> Optional[SteeringConfig]:
    enabled = [
        idx
        for idx, flag in enumerate(
            [args.level1, args.level2, args.level3, args.level4, args.level5], start=1
        )
        if flag
    ]
    if not enabled or args.skip_steering:
        return None
    return SteeringConfig(
        enabled_levels=enabled,
        prior=args.prior,
        n_bins=args.n_bins,
        binning=args.binning,
        beta_bias=args.beta_bias,
        beta_post=args.beta_post,
        lambda_attn=args.lambda_attn,
        lambda_mlp=args.lambda_mlp,
        alpha_k=args.alpha_k,
        alpha_v=args.alpha_v,
        beta_ptr=args.beta_ptr,
        bias_cap=args.bias_cap,
        gamma_min=args.gamma_min,
        gamma_max=args.gamma_max,
        eta_min=args.eta_min,
        eta_max=args.eta_max,
        human_file=args.human_file,
        lex_window=args.lex_window,
        rand_seed=args.rand_seed,
        schedule_json=args.schedule_json,
    )


def _assign_config_fields(target: SteeringConfig, source: SteeringConfig) -> None:
    for key, value in vars(source).items():
        setattr(target, key, copy.deepcopy(value))


def main():
    args = parse_args()
    # 1) Build/run the model (only HF token may come from env)
    llama = llama70b()
    base_steering_config = build_steering_config(args)
    human_prior_override = args.human_file
    active_steering_config: Optional[SteeringConfig] = None
    if base_steering_config:
        active_steering_config = copy.deepcopy(base_steering_config)
        llama.set_steering_config(active_steering_config)
    llama.login_hf()                  # optional; uses HUGGINGFACE_TOKEN if present
    llama.config(key_scope="prompt")  # IMPORTANT for prompt-aligned attention
    llama.build()

    level_label = "baseline"
    prior_label = "none"
    if base_steering_config:
        sorted_levels = "".join(f"L{lvl}" for lvl in sorted(base_steering_config.enabled_levels))
        level_label = f"levels-{sorted_levels}" if sorted_levels else "levels"
        prior_label = base_steering_config.prior

    # 2) Build our image renderer
    renderer = AttentionRenderer(tokenizer=llama.tokenizer, config=RenderConfig(pool="all_layers_mean"))
    # code_set = []
    # for snippet in os.listdir("./Source"):
    #     code_set.append(open(f"./Source/{snippet}", 'r').read())
    # for code in code_set():

    output_root = Path('attn_viz')
    output_root.mkdir(parents=True, exist_ok=True)

    base_dir = Path(__file__).resolve().parent
    source_dir = base_dir / "Source"
    fixation_root = base_dir / "fixation_dump"
    available_fixations = (
        {p.name for p in fixation_root.iterdir() if p.is_dir()} if fixation_root.is_dir() else set()
    )
    requested: set[str] = set()
    if args.snippet:
        requested.add(args.snippet.strip())
    if args.snippets:
        requested.update(s.strip() for s in args.snippets.split(",") if s.strip())

    if requested:
        snippet_paths = []
        for name in sorted(requested):
            candidate = source_dir / f"{name}.java"
            if not candidate.is_file():
                raise FileNotFoundError(f"Snippet '{name}' not found under {source_dir}.")
            if available_fixations and name not in available_fixations:
                print(f"[WARN] Fixation data not found for requested snippet '{name}'.")
            snippet_paths.append(candidate)
    else:
        snippet_paths = []
        for p in sorted(source_dir.iterdir()):
            if not p.is_file():
                continue
            if available_fixations and p.stem not in available_fixations:
                print(f"[WARN] Skipping '{p.stem}' (no fixation data found).")
                continue
            snippet_paths.append(p)
    if not snippet_paths:
        print(f"No code snippets found under {source_dir.resolve()}")
        llama.free()
        return
    instruction = (
        "You will analyze the Java program provided below. "
        "First, explain how you will predict the output for the code snippet. "
        "Then, simulate it as a compiler would and print the exact console output. \n"
    )
    runs_per_snippet = max(1, args.runs_per_snippet)
    for snippet_path in snippet_paths:
        code = snippet_path.read_text(encoding="utf-8")
        snippet_name = snippet_path.stem
        snippet_root = output_root / snippet_name / level_label / prior_label
        snippet_root.mkdir(parents=True, exist_ok=True)
        for outcome in ("EM", "Mismatch"):
            outcome_dir = snippet_root / outcome
            if outcome_dir.exists():
                for child in outcome_dir.iterdir():
                    if child.is_dir():
                        shutil.rmtree(child)
                    else:
                        child.unlink()
            outcome_dir.mkdir(exist_ok=True)
        run_idx = 1
        runs_completed = 0
        fixation_dir = fixation_root / snippet_name
        fixation_vocab: list[dict[str, object]] = [] # Type Hint
        vocab_path = fixation_dir / "vocabulary.json"
        if vocab_path.is_file():
            try:
                fixation_vocab = json.loads(vocab_path.read_text(encoding="utf-8"))
            except Exception as exc:
                print(f"[{snippet_name}] Warning: failed to load fixation vocabulary ({exc}); continuing without it.")
        if base_steering_config:
            current_cfg = copy.deepcopy(base_steering_config)
            if current_cfg.prior == "human":
                if human_prior_override:
                    current_cfg.human_file = human_prior_override
                else:
                    snippet_fix_dir = fixation_dir
                    if not snippet_fix_dir.is_dir():
                        raise FileNotFoundError(
                            f"Human prior selected but no fixation directory found at {snippet_fix_dir} for snippet '{snippet_name}'."
                        )
                    current_cfg.human_file = snippet_fix_dir
            if active_steering_config is None:
                active_steering_config = current_cfg
                llama.set_steering_config(active_steering_config)
            else:
                _assign_config_fields(active_steering_config, current_cfg)
        try:
            actual_output = utity.run_java_program(code, snippet_name)
        except Exception as exc:
            llama.free()
            raise RuntimeError(f"Failed to execute {snippet_path.name}: {exc}") from exc
        actual_output_str = actual_output if actual_output is not None else ""
        actual_output_clean = actual_output_str.strip()
        while runs_completed < runs_per_snippet:
            result = llama.run_llama(
                code,
                instruction=instruction,
                language="java",
                vocab_tokens=fixation_vocab,
            )
            predicted_output_raw = result.get("generated_text", "")
            predicted_output, format_ok = _canonicalize_model_output(predicted_output_raw)

            if not format_ok and not (actual_output_clean == "" and predicted_output == ""):
                print(f"[{snippet_name}] Missing answer section; retrying run {run_idx:03d}.")
                continue

            is_exact_match = predicted_output == actual_output_clean

            result["actual_output"] = actual_output_str
            result["predicted_output"] = predicted_output
            result["predicted_output_raw"] = predicted_output_raw
            result["exact_match"] = is_exact_match
            result["task"] = "output_prediction"

            phase_assignments, phase_ranges = _classify_generation_phases(result, llama.tokenizer)
            phase_prompt_scores, phase_counts = _aggregate_phase_prompt_scores(
                result, phase_assignments, pool_name="all_layers_mean"
            )
            # TODO: Experiment with all 5 settings.
            attn_map = renderer.map_attention_to_source(
                code_snippet=code,
                generation_result=result,
                instruction=instruction,
                pool="all_layers_mean",
                human_vocabulary=fixation_vocab,
            )
            phase_attention_maps = {}
            for phase, prompt_scores in phase_prompt_scores.items():
                if phase_counts.get(phase, 0) == 0:
                    continue
                phase_attention_maps[phase] = renderer.map_attention_from_prompt_scores(
                    code_snippet=code,
                    instruction=instruction,
                    prompt_scores=prompt_scores,
                    pool_name="all_layers_mean",
                    human_vocabulary=fixation_vocab,
                    metadata={
                        "phase": phase,
                        "phase_step_count": phase_counts.get(phase, 0),
                        "phase_char_range": phase_ranges.get(phase),
                    },
                )
            fixation_spans = [
                (token["start"], token["end"])
                for token in attn_map.get("fixation_tokens", [])
                if not token.get("missing")
                and token.get("start", -1) is not None
                and int(token["start"]) >= 0
                and int(token["end"]) > int(token["start"])
            ]
            masked_attn_map = None
            if fixation_spans:
                masked_attn_map = renderer.mask_attention_map(
                    code_snippet=code,
                    attn_map=attn_map,
                    spans=fixation_spans,
                    human_vocabulary=fixation_vocab,
                    note="fixation-aligned span",
                )
            match_dir = snippet_root / ("EM" if is_exact_match else "Mismatch")
            run_dir = match_dir / f"{run_idx}"
            run_dir.mkdir(parents=True, exist_ok=True)
            renderer.save_text_dump(attn_map, str(run_dir / "attention.json"), str(run_dir / "attention.csv"))
            renderer.render_html(code, attn_map, str(run_dir / "attention.html"))
            renderer.render_png(code, attn_map, str(run_dir / "attention_char.png"), score_key="char_attention")
            renderer.render_png(code, attn_map, str(run_dir / "attention_lexical.png"), score_key="lexical_tokens")
            if attn_map.get("fixation_tokens"):
                renderer.render_png(code, attn_map, str(run_dir / "attention_fixation.png"), score_key="fixation_tokens")
            for phase, phase_map in phase_attention_maps.items():
                phase_prefix = f"attention_phase_{phase}"
                renderer.save_text_dump(
                    phase_map,
                    str(run_dir / f"{phase_prefix}.json"),
                    str(run_dir / f"{phase_prefix}.csv"),
                )
                renderer.render_html(code, phase_map, str(run_dir / f"{phase_prefix}.html"))
                renderer.render_png(
                    code,
                    phase_map,
                    str(run_dir / f"{phase_prefix}_char.png"),
                    score_key="char_attention",
                )
                renderer.render_png(
                    code,
                    phase_map,
                    str(run_dir / f"{phase_prefix}_lexical.png"),
                    score_key="lexical_tokens",
                )
                if phase_map.get("fixation_tokens"):
                    renderer.render_png(
                        code,
                        phase_map,
                        str(run_dir / f"{phase_prefix}_fixation.png"),
                        score_key="fixation_tokens",
                    )
            if masked_attn_map:
                renderer.save_text_dump(masked_attn_map, str(run_dir / "attention_algorithm.json"), str(run_dir / "attention_algorithm.csv"))
                renderer.render_html(code, masked_attn_map, str(run_dir / "attention_algorithm.html"))
                renderer.render_png(code, masked_attn_map, str(run_dir / "attention_algorithm_char.png"), score_key="char_attention")
                renderer.render_png(code, masked_attn_map, str(run_dir / "attention_algorithm_lexical.png"), score_key="lexical_tokens")
                if masked_attn_map.get("fixation_tokens"):
                    renderer.render_png(code, masked_attn_map, str(run_dir / "attention_algorithm_fixation.png"), score_key="fixation_tokens")
            llama.save_dump(result, str(run_dir / "model_output.json"))
            (run_dir / "actual_output.txt").write_text(actual_output_str + "\n", encoding="utf-8")
            (run_dir / "predicted_output.txt").write_text(predicted_output + "\n", encoding="utf-8")
            (run_dir / "predicted_output_raw.txt").write_text(predicted_output_raw + "\n", encoding="utf-8")
            status = "EM" if is_exact_match else "Mismatch"
            print(f"[{snippet_name}] {status} saved artifacts for run {run_idx:03d} -> {run_dir}")
            run_idx += 1
            runs_completed += 1
    llama.free()

if __name__ == "__main__":
    main()
