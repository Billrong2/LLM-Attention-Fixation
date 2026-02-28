from __future__ import annotations

import ast


def cyclomatic_complexity(tree: ast.AST) -> int:
    match_node = getattr(ast, "Match", tuple())
    branch_nodes = (ast.If, ast.For, ast.While, ast.Try, ast.BoolOp, ast.IfExp) + ((match_node,) if match_node else ())
    return 1 + sum(1 for n in ast.walk(tree) if isinstance(n, branch_nodes))
