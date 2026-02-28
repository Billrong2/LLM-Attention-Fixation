from __future__ import annotations

import ast

PY_RESERVED = {
    "print", "len", "range", "int", "str", "float", "bool", "list", "dict", "set", "tuple", "sum", "min", "max"
}


def collect_function_nodes(tree: ast.AST) -> list[ast.FunctionDef]:
    return [n for n in ast.walk(tree) if isinstance(n, ast.FunctionDef)]


def is_main_guard(node: ast.AST) -> bool:
    if not isinstance(node, ast.If):
        return False
    test = node.test
    if not isinstance(test, ast.Compare):
        return False
    if not isinstance(test.left, ast.Name) or test.left.id != "__name__":
        return False
    if len(test.comparators) != 1:
        return False
    c = test.comparators[0]
    return isinstance(c, ast.Constant) and c.value == "__main__"
