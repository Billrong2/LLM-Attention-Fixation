from __future__ import annotations

import ast

from ...core.pass_base import ObfuscationPass, PassContext
from ..frontend.parse import parse_source
from ..frontend.print import print_source


class _SyntaxNoise(ast.NodeTransformer):
    def __init__(self, ctx: PassContext, tier: str, rate: float):
        self.ctx = ctx
        self.tier = tier
        self.rate = rate
        self.changes = 0

    def visit_AugAssign(self, node: ast.AugAssign):
        self.generic_visit(node)
        if not isinstance(node.target, ast.Name):
            return node
        if not self.ctx.rng.weighted_bool(self.rate):
            return node
        self.changes += 1
        return ast.Assign(
            targets=[node.target],
            value=ast.BinOp(left=ast.copy_location(ast.Name(id=node.target.id, ctx=ast.Load()), node.target), op=node.op, right=node.value),
        )

    def visit_Return(self, node: ast.Return):
        self.generic_visit(node)
        if node.value is None:
            return node
        if self.tier in {"med", "hard"} and self.ctx.rng.weighted_bool(self.rate * 0.5):
            self.changes += 1
            node.value = ast.copy_location(ast.UnaryOp(op=ast.UAdd(), operand=node.value), node.value)
        return node


class T2SyntaxNoisePass(ObfuscationPass):
    name = "T2"
    applies_to_lang = {"python"}

    def apply(self, source: str, ctx: PassContext):
        setting = ctx.pass_settings.get(self.name, {})
        tier = setting.get("tier", "easy")
        rate = float(setting.get("target_rate", 0.5))

        tree = parse_source(source)
        tf = _SyntaxNoise(ctx, tier, rate)
        out_tree = tf.visit(tree)
        ast.fix_missing_locations(out_tree)
        if tf.changes == 0:
            return source, False, "no_candidates", 0, 0
        return print_source(out_tree), True, f"syntax_noise:{tf.changes}", tf.changes, 0
