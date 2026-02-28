from pathlib import Path

from eyetracking.obfuscation.core.pipeline import obfuscate_program


def test_py_flatten_safe_subset():
    source = "def f(x):\n    if x > 0:\n        y = 1\n    else:\n        y = 2\n    return y\nprint(f(1))\n"
    result = obfuscate_program(
        source=source,
        language="python",
        profile="safe",
        seed=6,
        mode="technique",
        level="level3",
        technique="T6",
        difficulty="med",
        program_id="flat",
        config_root=Path("eyetracking/obfuscation"),
    )
    assert "while _obf_state_" in result.source or "no_flattenable" in str(result.metadata.skipped_passes_with_reasons)
