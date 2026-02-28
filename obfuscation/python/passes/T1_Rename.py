from __future__ import annotations

import ast

from ...core.pass_base import ObfuscationPass, PassContext
from ..frontend.parse import parse_source
from ..frontend.print import print_source
from .utils import PY_RESERVED


class _RenameTransformer(ast.NodeTransformer):
    def __init__(self, mapping_by_func: dict[str, dict[str, str]]):
        self.mapping_by_func = mapping_by_func
        self.scope_stack: list[str] = []

    def visit_FunctionDef(self, node: ast.FunctionDef):
        self.scope_stack.append(node.name)
        fmap = self.mapping_by_func.get(node.name, {})
        for arg in node.args.args:
            if arg.arg in fmap:
                arg.arg = fmap[arg.arg]
        self.generic_visit(node)
        self.scope_stack.pop()
        return node

    def visit_Name(self, node: ast.Name):
        if not self.scope_stack:
            return node
        fmap = self.mapping_by_func.get(self.scope_stack[-1], {})
        if node.id in fmap:
            node.id = fmap[node.id]
        return node


class T1RenamePass(ObfuscationPass):
    name = "T1"
    applies_to_lang = {"python"}

    def apply(self, source: str, ctx: PassContext):
        setting = ctx.pass_settings.get(self.name, {})
        tier = setting.get("tier", "easy")
        rate = float(setting.get("target_rate", 1.0))

        tree = parse_source(source)
        mapping_by_func: dict[str, dict[str, str]] = {}
        counter = 0

        for node in ast.walk(tree):
            if not isinstance(node, ast.FunctionDef):
                continue
            if node.name.startswith("__"):
                continue
            fmap: dict[str, str] = {}
            for arg in node.args.args:
                if arg.arg in PY_RESERVED or arg.arg in {"self", "cls"}:
                    continue
                if not ctx.rng.weighted_bool(rate):
                    continue
                counter += 1
                if tier == "easy":
                    fmap[arg.arg] = f"v{counter}"
                elif tier == "med":
                    fmap[arg.arg] = f"_o{counter}"
                else:
                    fmap[arg.arg] = f"lI{counter}"

            for inner in ast.walk(node):
                if isinstance(inner, ast.Name) and isinstance(inner.ctx, ast.Store):
                    old = inner.id
                    if old in PY_RESERVED or old in {"self", "cls"}:
                        continue
                    if old in fmap:
                        continue
                    if not ctx.rng.weighted_bool(rate):
                        continue
                    counter += 1
                    if tier == "easy":
                        fmap[old] = f"v{counter}"
                    elif tier == "med":
                        fmap[old] = f"_o{counter}"
                    else:
                        fmap[old] = f"O0{counter}"

            if fmap:
                mapping_by_func[node.name] = fmap

        if not mapping_by_func:
            return source, False, "no_candidates", 0, 0

        out_tree = _RenameTransformer(mapping_by_func).visit(tree)
        ast.fix_missing_locations(out_tree)
        out = print_source(out_tree)
        replaced = sum(len(v) for v in mapping_by_func.values())
        return out, True, f"renamed:{replaced}", replaced, 0
