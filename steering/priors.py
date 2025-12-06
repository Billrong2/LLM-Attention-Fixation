from __future__ import annotations

import csv
import json
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Dict, Sequence, List, Optional

import numpy as np
import re


@dataclass
class PriorContext:
    prompt_tokens: Sequence[str]
    code_text: str
    vocab_tokens: Sequence[dict]


class PriorProvider:
    def __init__(self, context: PriorContext) -> None:
        self.context = context

    def _normalize(self, vec: np.ndarray) -> np.ndarray:
        s = vec.sum()
        if s <= 0:
            return np.full_like(vec, 1.0 / len(vec))
        return vec / s

    def vector(self, bin_idx: int, n_bins: int) -> np.ndarray:
        raise NotImplementedError


class Semantic(PriorProvider):
    def __init__(self, context):
        super().__init__(context)
        pass
    """ To Do:
        Maybe we can make use of PDG. Let model focus on semantic preserving element through
        Control- or Data- flow 
    """
class HumanPrior(PriorProvider):
    def __init__(self, context: PriorContext, human_file: Path) -> None:
        super().__init__(context)
        self.vectors = self._load(human_file)

    def _load(self, file_path: Path) -> Sequence[np.ndarray]:
        if file_path.is_dir():
            return [self._aggregate_directory(file_path)]
        if file_path.suffix == ".json":
            data = json.loads(file_path.read_text(encoding="utf-8"))
            return self._vectors_from_payload(data, file_path)
        rows = []
        with file_path.open("r", encoding="utf-8") as fh:
            reader = csv.reader(fh)
            for row in reader:
                if row:
                    rows.append([float(x) for x in row])
        if not rows:
            raise ValueError(f"No data in human prior file {file_path}")
        return [np.asarray(row, dtype=float) for row in rows]

    def _aggregate_directory(self, folder: Path) -> np.ndarray:
        vocab = list(self.context.vocab_tokens)
        if not vocab:
            vocab_path = folder / "vocabulary.json"
            if vocab_path.is_file():
                try:
                    vocab = json.loads(vocab_path.read_text(encoding="utf-8"))
                except Exception:
                    vocab = []
        vocab_len = len(vocab)
        if vocab_len == 0:
            vocab_len = len(self.context.prompt_tokens) or 1

        accumulator = np.zeros(vocab_len, dtype=float)
        participant_files = sorted(folder.glob("participant_*.json"))
        for participant in participant_files:
            try:
                payload = json.loads(participant.read_text(encoding="utf-8"))
            except Exception:
                continue
            scores = payload.get("total_scores")
            if not isinstance(scores, list):
                continue
            vec = np.asarray(
                [float(entry.get("score", 0.0)) for entry in scores],
                dtype=float,
            )
            if vec.size < vocab_len:
                padded = np.zeros(vocab_len, dtype=float)
                padded[: vec.size] = vec
                vec = padded
            elif vec.size > vocab_len:
                vec = vec[:vocab_len]
            accumulator += vec

        if accumulator.sum() == 0:
            accumulator += 1.0
        return accumulator

    def _vectors_from_payload(self, payload: Any, source: Path) -> Sequence[np.ndarray]:
        if isinstance(payload, dict):
            if "bins" in payload:
                return [np.asarray(vec, dtype=float) for vec in payload["bins"]]
            if "vector" in payload:
                return [np.asarray(payload["vector"], dtype=float)]
            if "total_scores" in payload:
                return [
                    np.asarray(
                        [float(entry.get("score", 0.0)) for entry in payload["total_scores"]],
                        dtype=float,
                    )
                ]
        if isinstance(payload, list):
            if payload and isinstance(payload[0], dict) and "score" in payload[0]:
                return [
                    np.asarray([float(entry.get("score", 0.0)) for entry in payload], dtype=float)
                ]
            length = len(payload) or 1
            return [np.ones(length, dtype=float)]
        raise ValueError(f"Unsupported human prior format in {source}")

    def vector(self, bin_idx: int, n_bins: int) -> np.ndarray:
        vec = self.vectors[min(bin_idx, len(self.vectors) - 1)]
        if vec.size != len(self.context.prompt_tokens):
            vec = np.resize(vec, len(self.context.prompt_tokens))
        return self._normalize(vec)


class LexPrior(PriorProvider):
    def __init__(self, context: PriorContext, window: int) -> None:
        super().__init__(context)
        self.window = max(1, window)

    def vector(self, bin_idx: int, n_bins: int) -> np.ndarray:
        total = len(self.context.prompt_tokens)
        stride = max(1, total // n_bins)
        start = min(bin_idx * stride, total - 1)
        end = min(start + self.window, total)
        vec = np.zeros(total, dtype=float)
        vec[start:end] = 1.0
        return self._normalize(vec)


class RandPrior(PriorProvider):
    def __init__(self, context: PriorContext, seed: int | None) -> None:
        super().__init__(context)
        self.rng = np.random.default_rng(seed)

    def vector(self, bin_idx: int, n_bins: int) -> np.ndarray:
        vec = self.rng.random(len(self.context.prompt_tokens))
        return self._normalize(vec)


class ASTPrior(PriorProvider):
    """
    AST-aware prior using javalang. Falls back to a simple chunk heuristic if parsing fails.
    """

    tier_weights = {
        "tier1": 3.0,  # signatures and control
        "tier2": 2.0,  # calls / data flow
        "tier3": 1.0,  # literals / secondary
    }
    node_names = {
        "tier1": {
            "ClassDeclaration",
            "ConstructorDeclaration",
            "MethodDeclaration",
            "IfStatement",
            "WhileStatement",
            "ForStatement",
            "SwitchStatement",
            "TryStatement",
        },
        "tier2": {
            "MethodInvocation",
            "SuperMethodInvocation",
            "MemberReference",
            "Assignment",
            "ReturnStatement",
            "BinaryOperation",
            "UnaryOperation",
            "Cast",
            "InstanceOf",
        },
        "tier3": {
            "Literal",
            "ElementArrayValue",
            "ArraySelector",
            "This",
            "SuperConstructorInvocation",
            "ClassCreator",
            "ArrayCreator",
        },
    }

    def _try_import(self):
        try:
            import javalang  # type: ignore
            return javalang
        except Exception:
            return None

    def _tokenize(self, javalang_mod, code: str):
        try:
            return list(javalang_mod.tokenizer.tokenize(code))
        except Exception:
            return []

    def _position_index(self, tokens) -> Dict[tuple, int]:
        pos_map = {}
        for idx, tok in enumerate(tokens):
            if getattr(tok, "position", None):
                pos_map[tok.position] = idx
        return pos_map

    def _add_pos(self, node, weight: float, pos_map: Dict[tuple, int], scores: Dict[int, float]):
        if not node:
            return
        pos = getattr(node, "position", None)
        if pos and pos in pos_map:
            idx = pos_map[pos]
            scores[idx] = scores.get(idx, 0.0) + weight

    def _collect_scores(self, tree, tokens, javalang_mod) -> Dict[int, float]:
        pos_map = self._position_index(tokens)
        scores: Dict[int, float] = {}

        def walk(node, accumulated: float) -> None:
            if node is None:
                return
            ntype = type(node).__name__
            w_self = self._node_weight(ntype)
            total_w = accumulated + w_self
            if total_w > 0:
                self._add_pos(node, total_w, pos_map, scores)
                # for declarations, also tag their name/type positions if present
                if ntype in self.node_names["tier1"]:
                    if hasattr(node, "name"):
                        name_obj = getattr(node, "name", None)
                        if hasattr(name_obj, "position"):
                            self._add_pos(name_obj, total_w, pos_map, scores)
                    if hasattr(node, "parameters"):
                        for p in getattr(node, "parameters", []):
                            walk(p, total_w)
                    if hasattr(node, "type"):
                        walk(getattr(node, "type", None), total_w)
            # Recurse children to inherit this node's emphasis (accumulate)
            for child in getattr(node, "children", ()):
                if child is None:
                    continue
                if isinstance(child, (list, tuple)):
                    for c in child:
                        walk(c, total_w)
                else:
                    walk(child, total_w)

        # walk the parsed tree root
        walk(tree, 0.0)
        return scores

    def _map_scores_to_prompt(self, token_scores: Dict[int, float], tokens, prompt_tokens: Sequence[str]) -> np.ndarray:
        total_len = len(prompt_tokens)
        vec = np.zeros(total_len, dtype=float)
        if not token_scores:
            return vec

        # Build code lexemes and map from token index to lexeme text
        idx_to_text = {i: str(tok.value) for i, tok in enumerate(tokens)}
        # Take code-ish portion from the end of prompt_tokens
        code_token_indices = [i for i, t in enumerate(prompt_tokens) if True]
        # Greedy match from the end: map AST token scores onto prompt tokens
        lexemes = [(idx, idx_to_text[idx], score) for idx, score in token_scores.items()]
        # sort by original order
        lexemes.sort(key=lambda x: x[0], reverse=True)
        pt_idx = len(prompt_tokens) - 1
        for _, lex, score in lexemes:
            lex_clean = lex.strip()
            if not lex_clean:
                continue
            while pt_idx >= 0:
                token_text = prompt_tokens[pt_idx].replace("▁", "").strip()
                if token_text == "":
                    pt_idx -= 1
                    continue
                if token_text.lower().startswith(lex_clean.lower()):
                    vec[pt_idx] += score
                    pt_idx -= 1
                    break
                pt_idx -= 1
            if pt_idx < 0:
                break
        return vec

    def _fallback_chunk(self, bin_idx: int, n_bins: int) -> np.ndarray:
        total = len(self.context.prompt_tokens)
        if total == 0:
            return np.asarray([])
        chunk = max(1, total // n_bins)
        start = min(bin_idx * chunk, total - 1)
        vec = np.zeros(total, dtype=float)
        vec[start : start + chunk] = 1.0
        return vec

    def vector(self, bin_idx: int, n_bins: int) -> np.ndarray:
        javalang_mod = self._try_import()
        if javalang_mod is None:
            return self._normalize(self._fallback_chunk(bin_idx, n_bins))
        tokens = self._tokenize(javalang_mod, self.context.code_text)
        if not tokens:
            return self._normalize(self._fallback_chunk(bin_idx, n_bins))
        try:
            tree = javalang_mod.parse.parse(self.context.code_text)
        except Exception:
            return self._normalize(self._fallback_chunk(bin_idx, n_bins))

        scores = self._collect_scores(tree, tokens, javalang_mod)
        vec = self._map_scores_to_prompt(scores, tokens, self.context.prompt_tokens)
        if vec.sum() == 0:
            vec = self._fallback_chunk(bin_idx, n_bins)
        return self._normalize(vec)

    def _node_weight(self, ntype: str) -> float:
        if ntype in self.node_names["tier1"]:
            return self.tier_weights["tier1"]
        if ntype in self.node_names["tier2"]:
            return self.tier_weights["tier2"]
        if ntype in self.node_names["tier3"]:
            return self.tier_weights["tier3"]
        # small default to avoid over-amplifying deep nesting of unlisted nodes
        return 0.0


PRIOR_REGISTRY = {
    "human": HumanPrior,
    "lex": LexPrior,
    "rand": RandPrior,
    "ast": ASTPrior,
}
