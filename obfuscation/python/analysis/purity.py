from __future__ import annotations

import ast


def is_pure_expr(node: ast.AST) -> bool:
    pure_nodes = (
        ast.Constant,
        ast.Name,
        ast.BinOp,
        ast.UnaryOp,
        ast.BoolOp,
        ast.Compare,
        ast.IfExp,
        ast.Tuple,
        ast.List,
    )
    if isinstance(node, ast.Call):
        return False
    if not isinstance(node, pure_nodes):
        return False
    return all(is_pure_expr(child) for child in ast.iter_child_nodes(node))
