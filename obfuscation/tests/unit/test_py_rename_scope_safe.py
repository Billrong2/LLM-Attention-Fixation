from pathlib import Path
import ast

from eyetracking.obfuscation.core.pipeline import obfuscate_program


def test_py_rename_scope_safe():
    source = "def f(x):\n    y = x + 1\n    return y\nprint(f(3))\n"
    result = obfuscate_program(
        source=source,
        language="python",
        profile="safe",
        seed=4,
        mode="technique",
        level="level1",
        technique="T1",
        difficulty="easy",
        program_id="f",
        config_root=Path("eyetracking/obfuscation"),
    )
    ast.parse(result.source)
