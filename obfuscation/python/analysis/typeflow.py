from __future__ import annotations

import ast


class TypeFlow:
    def __init__(self) -> None:
        self.int_like: set[str] = set()


def infer_int_like(tree: ast.AST) -> TypeFlow:
    tf = TypeFlow()
    for node in ast.walk(tree):
        if isinstance(node, ast.Assign) and isinstance(node.targets[0], ast.Name):
            if isinstance(node.value, ast.Constant) and isinstance(node.value.value, int):
                tf.int_like.add(node.targets[0].id)
    return tf
