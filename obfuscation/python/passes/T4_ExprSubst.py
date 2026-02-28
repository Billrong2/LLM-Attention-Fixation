from __future__ import annotations

import ast

from ...core.pass_base import ObfuscationPass, PassContext
from ..analysis.typeflow import infer_int_like
from ..frontend.parse import parse_source
from ..frontend.print import print_source


class _ExprSubst(ast.NodeTransformer):
    def __init__(self, ctx: PassContext, tier: str, rate: float, int_like: set[str]):
        self.ctx = ctx
        self.tier = tier
        self.rate = rate
        self.int_like = int_like
        self.changes = 0

    def _ok(self, node: ast.AST) -> bool:
        if isinstance(node, ast.Constant) and isinstance(node.value, int):
            return True
        if isinstance(node, ast.Name) and node.id in self.int_like:
            return True
        return False

    def visit_BinOp(self, node: ast.BinOp):
        self.generic_visit(node)
        if isinstance(node.op, ast.Add) and self._ok(node.left) and self._ok(node.right):
            if self.ctx.rng.weighted_bool(self.rate):
                self.changes += 1
                return ast.copy_location(
                    ast.BinOp(left=node.left, op=ast.Sub(), right=ast.UnaryOp(op=ast.USub(), operand=node.right)),
                    node,
                )
        if self.tier in {"med", "hard"} and isinstance(node.op, ast.BitXor) and self._ok(node.left) and self._ok(node.right):
            if self.ctx.rng.weighted_bool(self.rate * 0.5):
                self.changes += 1
                # (a | b) - (a & b) == a ^ b
                return ast.copy_location(
                    ast.BinOp(
                        left=ast.BinOp(left=node.left, op=ast.BitOr(), right=node.right),
                        op=ast.Sub(),
                        right=ast.BinOp(left=node.left, op=ast.BitAnd(), right=node.right),
                    ),
                    node,
                )
        return node


class T4ExprSubstPass(ObfuscationPass):
    name = "T4"
    applies_to_lang = {"python"}

    def apply(self, source: str, ctx: PassContext):
        setting = ctx.pass_settings.get(self.name, {})
        tier = setting.get("tier", "easy")
        rate = float(setting.get("target_rate", 0.4))

        tree = parse_source(source)
        int_like = infer_int_like(tree).int_like
        t = _ExprSubst(ctx, tier, rate, int_like)
        out_tree = t.visit(tree)
        ast.fix_missing_locations(out_tree)
        if t.changes == 0:
            return source, False, "no_safe_expr_candidates", 0, 0
        if not ctx.budget.consume_expr_depth(1):
            return source, False, "budget_expr_depth_exceeded", 0, 0
        return print_source(out_tree), True, f"expr_subst:{t.changes}", t.changes, 0
