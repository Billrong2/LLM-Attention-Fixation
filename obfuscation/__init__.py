"""Deterministic source-to-source obfuscation suite (Java + Python)."""

from .core.pipeline import obfuscate_program
from .harness.equiv import verify_equivalence

__all__ = ["obfuscate_program", "verify_equivalence"]
