from __future__ import annotations

import ast

from ...core.pass_base import ObfuscationPass, PassContext
from ..frontend.parse import parse_source
from ..frontend.print import print_source


class _Flatten(ast.NodeTransformer):
    def __init__(self, ctx: PassContext, tier: str, rate: float):
        self.ctx = ctx
        self.tier = tier
        self.rate = rate
        self.changes = 0

    def visit_FunctionDef(self, node: ast.FunctionDef):
        self.generic_visit(node)
        if not self.ctx.rng.weighted_bool(self.rate):
            return node
        guarded = (ast.Try, ast.With, ast.AsyncWith, ast.For, ast.While)
        match_node = getattr(ast, "Match", None)
        if match_node:
            guarded = guarded + (match_node,)
        if any(isinstance(n, guarded) for n in ast.walk(node)):
            return node

        for i, stmt in enumerate(node.body):
            if isinstance(stmt, ast.If) and stmt.orelse:
                bad = (ast.Return, ast.Break, ast.Continue, ast.Raise)
                if any(isinstance(n, bad) for n in ast.walk(stmt)):
                    continue
                state_name = f"_obf_state_{self.changes}"
                init = ast.Assign(targets=[ast.Name(state_name, ast.Store())], value=ast.Constant(0))
                cond = ast.Compare(left=ast.Name(state_name, ast.Load()), ops=[ast.Eq()], comparators=[ast.Constant(0)])
                loop_body = [
                    stmt,
                    ast.Assign(targets=[ast.Name(state_name, ast.Store())], value=ast.Constant(1)),
                ]
                loop = ast.While(test=cond, body=loop_body, orelse=[])
                node.body[i : i + 1] = [init, loop]
                self.changes += 1
                break
        return node


class T6FlattenPass(ObfuscationPass):
    name = "T6"
    applies_to_lang = {"python"}

    def apply(self, source: str, ctx: PassContext):
        setting = ctx.pass_settings.get(self.name, {})
        tier = setting.get("tier", "easy")
        rate = float(setting.get("target_rate", 0.2))

        tree = parse_source(source)
        t = _Flatten(ctx, tier, rate)
        out_tree = t.visit(tree)
        ast.fix_missing_locations(out_tree)
        if t.changes == 0:
            return source, False, "no_flattenable_regions", 0, 0
        if not ctx.budget.consume_flatten_states(max(1, t.changes * 2)):
            return source, False, "budget_flatten_states_exceeded", 0, 0
        return print_source(out_tree), True, f"flatten_regions:{t.changes}", t.changes, 0
