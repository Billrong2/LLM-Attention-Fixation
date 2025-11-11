from __future__ import annotations

import csv
import json
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Dict, Sequence

import numpy as np


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
    def vector(self, bin_idx: int, n_bins: int) -> np.ndarray:
        total = len(self.context.prompt_tokens)
        if total == 0:
            return np.asarray([])
        chunk = max(1, total // n_bins)
        start = min(bin_idx * chunk, total - 1)
        vec = np.zeros(total, dtype=float)
        vec[start : start + chunk] = 1.0
        return self._normalize(vec)


PRIOR_REGISTRY = {
    "human": HumanPrior,
    "lex": LexPrior,
    "rand": RandPrior,
    "ast": ASTPrior,
}
