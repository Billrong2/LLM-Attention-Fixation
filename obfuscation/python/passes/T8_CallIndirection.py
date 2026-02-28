from __future__ import annotations

import ast

from ...core.pass_base import ObfuscationPass, PassContext
from ..frontend.parse import parse_source
from ..frontend.print import print_source
from ..runtime_helpers.dispatch import HELPER


class _CallIndirection(ast.NodeTransformer):
    def __init__(self, ctx: PassContext, rate: float):
        self.ctx = ctx
        self.rate = rate
        self.changes = 0

    def visit_Call(self, node: ast.Call):
        self.generic_visit(node)
        if isinstance(node.func, ast.Name) and node.func.id == "print" and self.ctx.rng.weighted_bool(self.rate):
            self.changes += 1
            return ast.Call(
                func=ast.Name("_obf_dispatch_call", ast.Load()),
                args=[
                    ast.Dict(keys=[ast.Constant(0)], values=[ast.Name("print", ast.Load())]),
                    ast.Constant(0),
                    *node.args,
                ],
                keywords=node.keywords,
            )
        return node


class T8CallIndirectionPass(ObfuscationPass):
    name = "T8"
    applies_to_lang = {"python"}

    def apply(self, source: str, ctx: PassContext):
        setting = ctx.pass_settings.get(self.name, {})
        rate = float(setting.get("target_rate", 0.5))

        tree = parse_source(source)
        t = _CallIndirection(ctx, rate)
        out_tree = t.visit(tree)
        ast.fix_missing_locations(out_tree)

        helpers = 0
        if t.changes > 0 and ctx.helpers.add("py_dispatch", HELPER):
            if ctx.budget.consume_helper(1):
                helpers = 1
        if t.changes == 0:
            return source, False, "no_calls_selected", 0, 0
        return print_source(out_tree), True, f"call_indirection:{t.changes}", t.changes, helpers
