from __future__ import annotations

from typing import Any, Dict, Sequence


PROMPT_SUFFIX_TASKS = {"counterfactual_tf", "trace_prediction"}

ARTIFACT_NAMES = {
    "ast": "Abstract Syntax Tree (AST)",
    "cfg": "Control-Flow Graph (CFG)",
    "slice": "Program Slicing / backward slice",
    "none": "No artifact",
}

MODE_DESCRIPTIONS = {
    "ast": (
        "Focus on concrete Abstract Syntax Tree (AST) nodes in the target method, "
        "including declarations, control nodes, calls, operators, assignments, "
        "literals, and returns."
    ),
    "cfg": (
        "Focus on concrete Control-Flow Graph (CFG) nodes and edges in the target "
        "method, including entry, sequential flow, branch predicates, loop "
        "predicates, body edges, back edges, return, and exit."
    ),
    "slice": (
        "Focus on concrete Program Slicing / backward-slice elements that can "
        "influence the requested observable behavior, including parameters, "
        "definitions, assignments, calls, predicates, return values, and static "
        "data/control dependencies."
    ),
}

STATIC_ONLY_WARNING = (
    "These elements are static only; they do not reveal the correct output, "
    "branch outcomes, or gold execution trace."
)

FORMAT_SUFFIX = "Use these elements only as private reasoning guidance and obey the requested output format exactly."


def artifact_name(mode: str) -> str:
    return ARTIFACT_NAMES.get(mode, "No artifact")


def render_artifact_conditioned_guidance(
    *,
    mode: str,
    prompt_items: Sequence[str],
    task: str,
) -> str:
    artifact = artifact_name(mode)
    lines = [
        f"Prompt-only steering guidance ({artifact}, artifact-conditioned):",
        "Use the following static program-analysis elements as the main reasoning anchors.",
        STATIC_ONLY_WARNING,
        "",
        "Static elements to emphasize:",
    ]
    if prompt_items:
        lines.extend(f"{idx}. {item}" for idx, item in enumerate(prompt_items, start=1))
    else:
        lines.append("1. No parseable structural elements were found; reason from the visible source code.")
    if task in PROMPT_SUFFIX_TASKS:
        lines.extend(["", FORMAT_SUFFIX])
    return "\n".join(lines)


def disabled_prompt_metadata(mode: str, target_method: str = "") -> Dict[str, Any]:
    return {
        "enabled": False,
        "mode": mode,
        "artifact_name": artifact_name(mode),
        "target_method": target_method,
        "parse_status": "disabled",
        "elements": [],
        "prompt_items": [],
    }
