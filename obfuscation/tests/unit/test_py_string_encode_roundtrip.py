from pathlib import Path

from eyetracking.obfuscation.core.pipeline import obfuscate_program
from eyetracking.obfuscation.harness.equiv import verify_equivalence


def test_py_string_encode_roundtrip(tmp_path: Path):
    src = tmp_path / "s.py"
    src.write_text("def g():\n    return 'abc'\nprint(g())\n", encoding="utf-8")
    result = obfuscate_program(
        source=src.read_text(encoding="utf-8"),
        language="python",
        profile="safe",
        seed=5,
        mode="technique",
        level="level1",
        technique="T3",
        difficulty="easy",
        program_id="s",
        config_root=Path("eyetracking/obfuscation"),
    )
    vr = verify_equivalence(src, result.source, "python", timeout_sec=8)
    assert vr.ok
