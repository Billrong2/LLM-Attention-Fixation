from __future__ import annotations

import ast
import base64

from ...core.pass_base import ObfuscationPass, PassContext
from ..frontend.parse import parse_source
from ..frontend.print import print_source
from ..runtime_helpers.const_decode import HELPER


class _ConstHide(ast.NodeTransformer):
    def __init__(self, ctx: PassContext, tier: str, rate: float):
        self.ctx = ctx
        self.tier = tier
        self.rate = rate
        self.changes = 0
        self._docstring_nodes: set[int] = set()

    def _mark_docstrings(self, body: list[ast.stmt]) -> None:
        if body and isinstance(body[0], ast.Expr) and isinstance(body[0].value, ast.Constant) and isinstance(body[0].value.value, str):
            self._docstring_nodes.add(id(body[0].value))

    def visit_Module(self, node: ast.Module):
        self._mark_docstrings(node.body)
        self.generic_visit(node)
        return node

    def visit_FunctionDef(self, node: ast.FunctionDef):
        self._mark_docstrings(node.body)
        self.generic_visit(node)
        return node

    def visit_ClassDef(self, node: ast.ClassDef):
        self._mark_docstrings(node.body)
        self.generic_visit(node)
        return node

    def visit_Constant(self, node: ast.Constant):
        if id(node) in self._docstring_nodes:
            return node
        if isinstance(node.value, str):
            if not self.ctx.rng.weighted_bool(self.rate):
                return node
            enc = base64.b64encode(node.value.encode("utf-8")).decode("ascii")
            self.changes += 1
            return ast.copy_location(
                ast.Call(func=ast.Name("_obf_const_decode_b64", ast.Load()), args=[ast.Constant(enc)], keywords=[]),
                node,
            )
        if self.tier in {"med", "hard"} and isinstance(node.value, int) and node.value not in (0, 1):
            if not self.ctx.rng.weighted_bool(self.rate * 0.7):
                return node
            key = self.ctx.rng.randint(2, 63)
            self.changes += 1
            return ast.copy_location(
                ast.Call(
                    func=ast.Name("_obf_const_decode_int", ast.Load()),
                    args=[ast.Constant(node.value ^ key), ast.Constant(key)],
                    keywords=[],
                ),
                node,
            )
        if self.tier == "hard" and isinstance(node.value, bool) and self.ctx.rng.weighted_bool(self.rate * 0.5):
            self.changes += 1
            return ast.copy_location(ast.UnaryOp(op=ast.Not(), operand=ast.UnaryOp(op=ast.Not(), operand=node)), node)
        return node


class T3ConstHidePass(ObfuscationPass):
    name = "T3"
    applies_to_lang = {"python"}

    def apply(self, source: str, ctx: PassContext):
        setting = ctx.pass_settings.get(self.name, {})
        tier = setting.get("tier", "easy")
        rate = float(setting.get("target_rate", 0.6))

        tree = parse_source(source)
        t = _ConstHide(ctx, tier, rate)
        out_tree = t.visit(tree)
        ast.fix_missing_locations(out_tree)
        if t.changes == 0:
            return source, False, "no_literals_selected", 0, 0

        helpers = 0
        if ctx.helpers.add("py_const_decode", HELPER):
            if ctx.budget.consume_helper(1):
                helpers = 1
        return print_source(out_tree), True, f"constants_hidden:{t.changes}", t.changes, helpers
