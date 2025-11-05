# main.py

from __future__ import annotations

import os
from pathlib import Path
import re
import json
from typing import Any, Dict, List, Optional, Sequence, Tuple

import numpy as np
from models import llama70b
from util import utity
from render.util import AttentionRenderer, RenderConfig


def _canonicalize_model_output(text: str) -> tuple[str, bool]:
    """
    Normalize model output to remove common formatting artifacts while preserving content.

    Returns a tuple of (normalized_output, format_found).
    """
    if not text:
        return "", False

    stripped = text.strip()
    fence_pattern = re.compile(r"```(?:\w+)?\s*\n?(.*?)\n?```", re.DOTALL)
    candidates = [m.group(1).strip() for m in fence_pattern.finditer(stripped)]
    for candidate in reversed(candidates):
        lowered = candidate.lower()
        if not candidate:
            continue
        if "<your answer>" in lowered:
            continue
        if lowered.startswith("class "):
            continue
        return candidate.strip(), True

    return stripped.strip(), False


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

    reading_end_candidate = lower.find("answer:")
    if reading_end_candidate == -1:
        reading_end_candidate = lower.find("explanation")
    if reading_end_candidate == -1:
        reading_end_candidate = lower.find("```text")
    if reading_end_candidate == -1:
        reading_end_candidate = len(completion)

    answer_start = -1
    search_pos = reading_end_candidate
    while search_pos < len(lower):
        idx = lower.find("```", search_pos)
        if idx == -1:
            break
        lang_token = lower[idx : idx + 8]
        if "```java" in lang_token:
            search_pos = idx + 3
            continue
        answer_start = idx
        break
    if answer_start == -1:
        answer_start = lower.find("```text")
    if answer_start == -1:
        answer_start = len(completion)

    answer_end = -1
    if answer_start < len(completion):
        answer_end = lower.find("```", answer_start + 3)
        if answer_end != -1:
            answer_end += 3
    if answer_end == -1:
        answer_end = len(completion)

    reading_range = (0, max(0, min(answer_start, reading_end_candidate)))
    answer_range = (answer_start, answer_end)
    reasoning_range = (answer_end, len(completion))

    token_spans = _compute_generated_token_spans(
        tokenizer,
        result.get("token_ids_all", []),
        result.get("prompt_length_tokens", 0),
    )

    phase_by_step: Dict[int, str] = {}
    for idx, (start_char, end_char) in enumerate(token_spans):
        phase = "reading"
        if answer_range[0] < answer_range[1] and start_char >= answer_range[0] and start_char < answer_range[1]:
            phase = "answering"
        elif reasoning_range[0] < reasoning_range[1] and start_char >= reasoning_range[0]:
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


def main():
    # 1) Build/run the model (only HF token may come from env)
    llama = llama70b()
    llama.login_hf()                  # optional; uses HUGGINGFACE_TOKEN if present
    llama.config(key_scope="prompt")  # IMPORTANT for prompt-aligned attention
    llama.build()

    # 2) Build our image renderer
    renderer = AttentionRenderer(tokenizer=llama.tokenizer, config=RenderConfig(pool="all_layers_mean"))
    # code_set = []
    # for snippet in os.listdir("./Source"):
    #     code_set.append(open(f"./Source/{snippet}", 'r').read())
    # for code in code_set():

    output_root = Path('attn_viz')
    output_root.mkdir(parents=True, exist_ok=True)

    source_dir = Path(__file__).resolve().parent / "Source"
    snippet_paths = sorted(p for p in source_dir.iterdir() if p.is_file())
    if not snippet_paths:
        print(f"No code snippets found under {source_dir.resolve()}")
        llama.free()
        return
    instruction = (
        "Simulate the execution of the Java program provided below and reproduce exactly what would appear on standard output. "
        "Return only the raw console output characters, preserving line breaks and spacing. "
        "Do not add explanations, commentary, or formatting such as code fences or quotes. "
        "If the program prints nothing, respond with an empty string."
    )
    runs_per_snippet = 20
    for snippet_path in snippet_paths:
        code = snippet_path.read_text(encoding="utf-8")
        snippet_name = snippet_path.stem
        snippet_root = output_root / snippet_name
        snippet_root.mkdir(parents=True, exist_ok=True)
        fixation_vocab: list[dict[str, object]] = [] # Type Hint
        vocab_path = Path(__file__).resolve().parent / "fixation_dump" / snippet_name / "vocabulary.json"
        if vocab_path.is_file():
            try:
                fixation_vocab = json.loads(vocab_path.read_text(encoding="utf-8"))
            except Exception as exc:
                print(f"[{snippet_name}] Warning: failed to load fixation vocabulary ({exc}); continuing without it.")
        try:
            actual_output = utity.run_java_program(code, snippet_name)
        except Exception as exc:
            llama.free()
            raise RuntimeError(f"Failed to execute {snippet_path.name}: {exc}") from exc
        actual_output_str = actual_output if actual_output is not None else ""
        run_idx = 1
        actual_output_clean = actual_output_str.strip()
        while run_idx <= runs_per_snippet:
            result = llama.run_llama(code, instruction=instruction, language="java")
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
    llama.free()

if __name__ == "__main__":
    main()
