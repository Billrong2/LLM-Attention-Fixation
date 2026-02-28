from __future__ import annotations

import ast

from ...core.pass_base import ObfuscationPass, PassContext
from ..frontend.parse import parse_source
from ..frontend.print import print_source


def _predicate_expr(tier: str) -> ast.expr:
    if tier == "easy":
        src = "((7 * 7) % 3) == 1"
    elif tier == "med":
        src = "(((11 * 11) + 1) % 5) == 2"
    else:
        src = "((((13 * 13) - 3) % 7) + 1) == 6"
    return ast.parse(src, mode="eval").body


class _BogusCF(ast.NodeTransformer):
    def __init__(self, ctx: PassContext, tier: str, rate: float):
        self.ctx = ctx
        self.tier = tier
        self.rate = rate
        self.changes = 0

    def _wrap_block(self, body: list[ast.stmt]) -> list[ast.stmt]:
        out: list[ast.stmt] = []
        for stmt in body:
            if isinstance(stmt, (ast.Assign, ast.AugAssign, ast.Expr)) and self.ctx.rng.weighted_bool(self.rate):
                if isinstance(stmt, ast.Expr) and isinstance(stmt.value, ast.Call):
                    # Do not duplicate external calls.
                    out.append(stmt)
                    continue
                junk = ast.Assign(targets=[ast.Name(id=f"_obf_j{self.changes}", ctx=ast.Store())], value=ast.Constant(0))
                wrapper = ast.If(test=_predicate_expr(self.tier), body=[stmt], orelse=[junk])
                out.append(wrapper)
                self.changes += 1
            else:
                out.append(stmt)
        return out

    def visit_Module(self, node: ast.Module):
        node.body = self._wrap_block([self.visit(s) for s in node.body])
        return node

    def visit_FunctionDef(self, node: ast.FunctionDef):
        node.body = self._wrap_block([self.visit(s) for s in node.body])
        return node


class T5BogusCFPass(ObfuscationPass):
    name = "T5"
    applies_to_lang = {"python"}

    def apply(self, source: str, ctx: PassContext):
        setting = ctx.pass_settings.get(self.name, {})
        tier = setting.get("tier", "easy")
        rate = float(setting.get("target_rate", 0.25))

        tree = parse_source(source)
        t = _BogusCF(ctx, tier, rate)
        out_tree = t.visit(tree)
        ast.fix_missing_locations(out_tree)
        if t.changes == 0:
            return source, False, "no_statements_selected", 0, 0
        return print_source(out_tree), True, f"bogus_cf:{t.changes}", t.changes, 0
