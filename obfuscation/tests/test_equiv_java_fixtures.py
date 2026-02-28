from pathlib import Path

from eyetracking.obfuscation.core.pipeline import obfuscate_program
from eyetracking.obfuscation.harness.equiv import verify_equivalence


def test_equiv_java_fixture(tmp_path: Path):
    src = tmp_path / "Main01.java"
    src.write_text(
        "public class Main01 { public static int f(int x){ return x + 1; } public static void main(String[] args){ System.out.println(f(4)); }}\n",
        encoding="utf-8",
    )
    result = obfuscate_program(
        source=src.read_text(encoding="utf-8"),
        language="java",
        profile="safe",
        seed=2,
        mode="level",
        level="level2",
        technique=None,
        difficulty=None,
        program_id="Main01",
        config_root=Path("eyetracking/obfuscation"),
    )
    vr = verify_equivalence(src, result.source, "java", timeout_sec=8)
    assert vr.ok, vr.details
