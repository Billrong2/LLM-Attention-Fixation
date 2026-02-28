from pathlib import Path

from eyetracking.obfuscation.core.pipeline import obfuscate_program
from eyetracking.obfuscation.harness.equiv import verify_equivalence


def test_equiv_python_fixture(tmp_path: Path):
    src = tmp_path / "fixture.py"
    src.write_text("def f(n):\n    x = 0\n    for i in range(n):\n        x += i\n    return x\nprint(f(5))\n", encoding="utf-8")
    result = obfuscate_program(
        source=src.read_text(encoding="utf-8"),
        language="python",
        profile="safe",
        seed=1,
        mode="level",
        level="level2",
        technique=None,
        difficulty=None,
        program_id="fixture",
        config_root=Path("eyetracking/obfuscation"),
    )
    vr = verify_equivalence(src, result.source, "python", timeout_sec=8)
    assert vr.ok, vr.details
