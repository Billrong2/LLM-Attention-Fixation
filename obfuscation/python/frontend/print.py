from __future__ import annotations

import ast


def print_source(tree: ast.AST) -> str:
    return ast.unparse(tree) + "\n"


def inject_helpers(source: str, helpers_block: str) -> str:
    if not helpers_block.strip():
        return source
    lines = source.splitlines()
    insert_at = 0
    for i, line in enumerate(lines):
        s = line.strip()
        if s.startswith("import ") or s.startswith("from "):
            insert_at = i + 1
            continue
        if s == "" and insert_at == i:
            insert_at = i + 1
            continue
        break
    out = lines[:insert_at] + ["", helpers_block, ""] + lines[insert_at:]
    return "\n".join(out).rstrip() + "\n"
