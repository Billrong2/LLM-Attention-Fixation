from __future__ import annotations

import ast


def parse_source(source: str) -> ast.AST:
    return ast.parse(source)
