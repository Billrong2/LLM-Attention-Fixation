from dataclasses import dataclass, field


@dataclass
class BudgetState:
    ast_nodes_before: int = 0
    ast_nodes_after: int = 0
    helpers_added: int = 0
    expr_depth_increase: int = 0
    flatten_states_added: int = 0
    added_branches: int = 0


@dataclass
class BudgetConfig:
    max_new_ast_nodes_percent: float = 200.0
    max_new_helpers: int = 16
    max_expr_depth_increase: int = 6
    max_cfg_states_for_flattening: int = 24
    max_added_branches_per_100_stmts: int = 40


@dataclass
class BudgetManager:
    cfg: BudgetConfig
    state: BudgetState = field(default_factory=BudgetState)

    def reset(self, ast_nodes_before: int) -> None:
        self.state = BudgetState(ast_nodes_before=ast_nodes_before, ast_nodes_after=ast_nodes_before)

    def record_ast_after(self, ast_nodes_after: int) -> None:
        self.state.ast_nodes_after = ast_nodes_after

    def allow_ast_growth(self) -> bool:
        before = max(1, self.state.ast_nodes_before)
        growth = ((self.state.ast_nodes_after - before) / before) * 100.0
        return growth <= self.cfg.max_new_ast_nodes_percent

    def allow_helper(self, count: int = 1) -> bool:
        return (self.state.helpers_added + count) <= self.cfg.max_new_helpers

    def consume_helper(self, count: int = 1) -> bool:
        if not self.allow_helper(count):
            return False
        self.state.helpers_added += count
        return True

    def allow_expr_depth(self, delta: int) -> bool:
        return (self.state.expr_depth_increase + delta) <= self.cfg.max_expr_depth_increase

    def consume_expr_depth(self, delta: int) -> bool:
        if not self.allow_expr_depth(delta):
            return False
        self.state.expr_depth_increase += delta
        return True

    def allow_flatten_states(self, added: int) -> bool:
        return (self.state.flatten_states_added + added) <= self.cfg.max_cfg_states_for_flattening

    def consume_flatten_states(self, added: int) -> bool:
        if not self.allow_flatten_states(added):
            return False
        self.state.flatten_states_added += added
        return True

    def allow_added_branches(self, current_stmt_count: int, added: int) -> bool:
        if current_stmt_count <= 0:
            current_stmt_count = 1
        max_add = (current_stmt_count / 100.0) * self.cfg.max_added_branches_per_100_stmts
        # Avoid pathological all-skip behavior on short snippets.
        if self.cfg.max_added_branches_per_100_stmts > 0:
            max_add = max(1.0, max_add)
        return (self.state.added_branches + added) <= max_add

    def consume_added_branches(self, current_stmt_count: int, added: int) -> bool:
        if not self.allow_added_branches(current_stmt_count, added):
            return False
        self.state.added_branches += added
        return True

    def snapshot(self) -> dict:
        return {
            "limits": self.cfg.__dict__.copy(),
            "usage": self.state.__dict__.copy(),
            "ast_growth_ok": self.allow_ast_growth(),
        }
