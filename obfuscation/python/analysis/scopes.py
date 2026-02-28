from __future__ import annotations

import ast
from dataclasses import dataclass, field


@dataclass
class ScopeInfo:
    locals_by_func: dict[str, set[str]] = field(default_factory=dict)
    params_by_func: dict[str, set[str]] = field(default_factory=dict)


def build_scope_info(tree: ast.AST) -> ScopeInfo:
    info = ScopeInfo()
    for node in ast.walk(tree):
        if isinstance(node, ast.FunctionDef):
            locals_ = set()
            params = {a.arg for a in node.args.args}
            for inner in ast.walk(node):
                if isinstance(inner, ast.Name) and isinstance(inner.ctx, ast.Store):
                    locals_.add(inner.id)
            info.locals_by_func[node.name] = locals_
            info.params_by_func[node.name] = params
    return info
