from pathlib import Path

from eyetracking.obfuscation.core.pipeline import obfuscate_program
from eyetracking.obfuscation.harness.equiv import verify_equivalence


def test_py_instr_subst_equiv(tmp_path: Path):
    src = tmp_path / "a.py"
    src.write_text("def f(a,b):\n    return a + b\nprint(f(5,7))\n", encoding="utf-8")
    result = obfuscate_program(
        source=src.read_text(encoding="utf-8"),
        language="python",
        profile="safe",
        seed=3,
        mode="technique",
        level="level2",
        technique="T4",
        difficulty="med",
        program_id="a",
        config_root=Path("eyetracking/obfuscation"),
    )
    vr = verify_equivalence(src, result.source, "python", timeout_sec=8)
    assert vr.ok
