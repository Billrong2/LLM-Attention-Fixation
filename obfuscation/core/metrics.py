from __future__ import annotations

import ast
import re
from typing import Any


def _max_ast_depth(node: ast.AST, depth: int = 0) -> int:
    best = depth
    for child in ast.iter_child_nodes(node):
        best = max(best, _max_ast_depth(child, depth + 1))
    return best


def python_metrics(source: str) -> dict[str, Any]:
    try:
        tree = ast.parse(source)
    except Exception:
        return {
            "tokens": len(source.split()),
            "lines": source.count("\n") + 1,
            "ast_nodes": 0,
            "max_ast_depth": 0,
            "cyclomatic_approx": 0,
        }
    nodes = sum(1 for _ in ast.walk(tree))
    match_node = getattr(ast, "Match", tuple())
    branch_nodes = (ast.If, ast.For, ast.While, ast.Try, ast.BoolOp, ast.IfExp) + ((match_node,) if match_node else ())
    cc = 1 + sum(1 for n in ast.walk(tree) if isinstance(n, branch_nodes))
    return {
        "tokens": len(source.split()),
        "lines": source.count("\n") + 1,
        "ast_nodes": nodes,
        "max_ast_depth": _max_ast_depth(tree),
        "cyclomatic_approx": cc,
    }


def java_metrics(source: str) -> dict[str, Any]:
    tokens = len(re.findall(r"[A-Za-z_][A-Za-z0-9_]*|\S", source))
    lines = source.count("\n") + 1
    braces = source.count("{") + source.count("}")
    branches = len(re.findall(r"\b(if|for|while|switch|case|catch)\b", source))
    depth = 0
    best = 0
    for ch in source:
        if ch == "{":
            depth += 1
            best = max(best, depth)
        elif ch == "}":
            depth = max(0, depth - 1)
    return {
        "tokens": tokens,
        "lines": lines,
        "ast_nodes": braces * 2 + tokens,
        "max_ast_depth": best,
        "cyclomatic_approx": 1 + branches,
    }


def calculate_metrics(language: str, source: str) -> dict[str, Any]:
    if language == "python":
        return python_metrics(source)
    if language == "java":
        return java_metrics(source)
    raise ValueError(f"Unsupported language: {language}")


def difficulty_score(metrics: dict[str, Any]) -> float:
    score = 0.0
    score += 0.20 * min(1.0, metrics.get("tokens", 0) / 800.0)
    score += 0.20 * min(1.0, metrics.get("ast_nodes", 0) / 1200.0)
    score += 0.15 * min(1.0, metrics.get("max_ast_depth", 0) / 18.0)
    score += 0.20 * min(1.0, metrics.get("cyclomatic_approx", 0) / 40.0)
    score += 0.25 * min(1.0, metrics.get("helpers_injected", 0) / 20.0)
    return round(score, 4)
