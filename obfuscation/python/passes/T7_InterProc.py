from __future__ import annotations

import ast

from ...core.pass_base import ObfuscationPass, PassContext
from ..frontend.parse import parse_source
from ..frontend.print import print_source


class _InterProc(ast.NodeTransformer):
    def __init__(self, ctx: PassContext, tier: str, rate: float):
        self.ctx = ctx
        self.tier = tier
        self.rate = rate
        self.changes = 0
        self.helpers: list[str] = []

    def visit_FunctionDef(self, node: ast.FunctionDef):
        self.generic_visit(node)
        if node.name.startswith("_"):
            return node
        if not self.ctx.rng.weighted_bool(self.rate):
            return node

        for stmt in node.body:
            if isinstance(stmt, ast.Return) and stmt.value is not None:
                v = stmt.value
                helper_name = f"_obf_inter_{node.name}_{self.changes}"
                if isinstance(v, ast.Name):
                    helper = f"def {helper_name}(x):\n    return x\n"
                    stmt.value = ast.Call(func=ast.Name(helper_name, ast.Load()), args=[ast.Name(v.id, ast.Load())], keywords=[])
                    self.helpers.append(helper)
                    self.changes += 1
                    return node
                if isinstance(v, ast.Constant) and isinstance(v.value, (int, bool, str)):
                    helper = f"def {helper_name}():\n    return {v.value!r}\n"
                    stmt.value = ast.Call(func=ast.Name(helper_name, ast.Load()), args=[], keywords=[])
                    self.helpers.append(helper)
                    self.changes += 1
                    return node
        return node


class T7InterProcPass(ObfuscationPass):
    name = "T7"
    applies_to_lang = {"python"}

    def apply(self, source: str, ctx: PassContext):
        setting = ctx.pass_settings.get(self.name, {})
        tier = setting.get("tier", "easy")
        rate = float(setting.get("target_rate", 0.2))

        tree = parse_source(source)
        t = _InterProc(ctx, tier, rate)
        out_tree = t.visit(tree)
        ast.fix_missing_locations(out_tree)
        helpers = 0
        for i, helper in enumerate(t.helpers):
            if ctx.helpers.add(f"py_inter_{i}_{ctx.program_id}", helper.strip()):
                helpers += 1
        if t.changes == 0:
            return source, False, "no_outline_candidates", 0, 0
        return print_source(out_tree), True, f"interproc:{t.changes}", t.changes, helpers
