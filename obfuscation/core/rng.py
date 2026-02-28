import hashlib
import random
from dataclasses import dataclass
from typing import Iterable, Sequence, TypeVar

T = TypeVar("T")


def derive_seed(*parts: object) -> int:
    material = "::".join(str(p) for p in parts).encode("utf-8")
    digest = hashlib.sha256(material).digest()
    return int.from_bytes(digest[:8], "big", signed=False)


@dataclass
class DeterministicRNG:
    seed: int

    def __post_init__(self) -> None:
        self._rng = random.Random(self.seed)

    def fork(self, label: str) -> "DeterministicRNG":
        return DeterministicRNG(derive_seed(self.seed, label))

    def random(self) -> float:
        return self._rng.random()

    def randint(self, a: int, b: int) -> int:
        return self._rng.randint(a, b)

    def choice(self, values: Sequence[T]) -> T:
        return self._rng.choice(values)

    def shuffle(self, values: list[T]) -> None:
        self._rng.shuffle(values)

    def sample(self, population: Sequence[T], k: int) -> list[T]:
        if k <= 0:
            return []
        return self._rng.sample(list(population), min(k, len(population)))

    def token(self, prefix: str = "obf", n: int = 8) -> str:
        alphabet = "abcdefghijklmnopqrstuvwxyz0123456789"
        out = "".join(self._rng.choice(alphabet) for _ in range(n))
        return f"{prefix}_{out}"

    def weighted_bool(self, p: float) -> bool:
        return self.random() < max(0.0, min(1.0, p))

    def iter_forks(self, labels: Iterable[str]) -> dict[str, "DeterministicRNG"]:
        return {label: self.fork(label) for label in labels}
