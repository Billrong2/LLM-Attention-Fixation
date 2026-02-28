from pathlib import Path
import subprocess


def test_cli_run_smoke(tmp_path: Path):
    src = tmp_path / "p.py"
    src.write_text("def f(x):\n    return x+1\nprint(f(2))\n", encoding="utf-8")
    out = tmp_path / "o.py"
    cmd = [
        "python",
        "-m",
        "eyetracking.obfuscation.tools.obfuscate_cli",
        "run",
        "--lang",
        "python",
        "--input",
        str(src),
        "--output",
        str(out),
        "--level",
        "level1",
    ]
    r = subprocess.run(cmd, capture_output=True, text=True)
    assert r.returncode == 0, r.stderr
    assert out.exists()
