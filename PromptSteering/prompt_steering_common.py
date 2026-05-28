from __future__ import annotations

import json
import os
import re
import shutil
import subprocess
import sys
import time
from pathlib import Path
from typing import Any, Dict, Iterable, List, Optional, Sequence, Tuple


DEFAULT_PROJECT_ROOT = Path(__file__).resolve().parents[1]
PROMPT_STEERING_ROOT = Path(__file__).resolve().parent
DEFAULT_MODEL_NAME = "Qwen/Qwen2.5-Coder-7B-Instruct"
DEFAULT_OUTPUT_ROOT = PROMPT_STEERING_ROOT / "artifacts"
DEFAULT_JAVA_HOME = Path("/people/cs/x/xxr230000/jdks/jdk-17.0.11+9")
DEFAULT_JAVA_COMPAT_SRC = PROMPT_STEERING_ROOT / "java_compat"
DEFAULT_JAVA_COMPAT_BUILD = DEFAULT_OUTPUT_ROOT / "java_compat"
DEFAULT_JAVATUPLES_COMPAT_JAR = DEFAULT_JAVA_COMPAT_BUILD / "javatuples-compat.jar"

PROMPT_STEERING_CHOICES = ("none", "slice", "cfg", "ast")
DEFAULT_OBF_TECHNIQUES = (
    "identifier_renaming",
    "bogus_control_flow",
    "control_flow_flattening",
    "call_indirection",
)


def add_project_root(project_root: Path) -> None:
    root = project_root.resolve()
    if str(root) not in sys.path:
        sys.path.insert(0, str(root))


def configure_java_home(java_home: Optional[str | Path] = None) -> Optional[Path]:
    candidates: List[Path] = []
    explicit = java_home is not None and str(java_home).strip() != ""
    if explicit:
        candidates.append(Path(str(java_home)).expanduser())
    else:
        candidates.append(DEFAULT_JAVA_HOME)
        if os.environ.get("JAVA_HOME"):
            candidates.append(Path(os.environ["JAVA_HOME"]).expanduser())

    seen: set[str] = set()
    for candidate in candidates:
        key = str(candidate)
        if key in seen:
            continue
        seen.add(key)
        if (candidate / "bin" / "javac").is_file() and (candidate / "bin" / "java").is_file():
            java_bin = str((candidate / "bin").resolve())
            current_path = os.environ.get("PATH", "")
            os.environ["JAVA_HOME"] = str(candidate.resolve())
            if not current_path.split(os.pathsep) or current_path.split(os.pathsep)[0] != java_bin:
                os.environ["PATH"] = java_bin + os.pathsep + current_path
            return candidate.resolve()

    if explicit:
        raise FileNotFoundError(f"Requested Java home does not contain bin/java and bin/javac: {java_home}")
    return None


def _resolve_java_tool(name: str, java_home: Optional[str | Path] = None) -> Path:
    candidates: List[Path] = []
    if java_home is not None and str(java_home).strip():
        candidates.append(Path(str(java_home)).expanduser() / "bin" / name)
    if os.environ.get("JAVA_HOME"):
        candidates.append(Path(os.environ["JAVA_HOME"]).expanduser() / "bin" / name)
    found = shutil.which(name)
    if found:
        candidates.append(Path(found))

    seen: set[str] = set()
    for candidate in candidates:
        key = str(candidate)
        if key in seen:
            continue
        seen.add(key)
        if candidate.is_file() and os.access(candidate, os.X_OK):
            return candidate.resolve()
    raise FileNotFoundError(f"Could not find executable Java tool: {name}")


def _newer_than_sources(target: Path, sources: Sequence[Path]) -> bool:
    if not target.is_file():
        return False
    target_mtime = target.stat().st_mtime
    return all(target_mtime >= src.stat().st_mtime for src in sources if src.is_file())


def _run_checked(cmd: Sequence[str], *, cwd: Optional[Path] = None) -> None:
    proc = subprocess.run(
        list(cmd),
        cwd=str(cwd) if cwd is not None else None,
        capture_output=True,
        text=True,
        check=False,
    )
    if proc.returncode != 0:
        msg = "\n".join(
            part
            for part in (
                f"Command failed ({proc.returncode}): {' '.join(cmd)}",
                proc.stdout.strip(),
                proc.stderr.strip(),
            )
            if part
        )
        raise RuntimeError(msg)


def ensure_javatuples_compat_jar(java_home: Optional[str | Path] = None) -> Path:
    src_root = DEFAULT_JAVA_COMPAT_SRC / "org" / "javatuples"
    sources = sorted(src_root.glob("*.java"))
    if not sources:
        raise FileNotFoundError(f"No Java compatibility sources found under {src_root}")

    jar_path = DEFAULT_JAVATUPLES_COMPAT_JAR
    if _newer_than_sources(jar_path, sources):
        return jar_path.resolve()

    javac = _resolve_java_tool("javac", java_home)
    jar = _resolve_java_tool("jar", java_home)
    build_dir = DEFAULT_JAVA_COMPAT_BUILD / "classes"
    if build_dir.exists():
        shutil.rmtree(build_dir)
    build_dir.mkdir(parents=True, exist_ok=True)
    jar_path.parent.mkdir(parents=True, exist_ok=True)

    _run_checked([str(javac), "-d", str(build_dir), *[str(src) for src in sources]])
    _run_checked([str(jar), "cf", str(jar_path), "-C", str(build_dir), "."])
    return jar_path.resolve()


def _prepend_path_list(env_name: str, first: Path, *, fallback: str = "") -> None:
    entries: List[str] = [str(first.resolve())]
    current = os.environ.get(env_name, "")
    if current:
        entries.extend(part for part in current.split(os.pathsep) if part)
    elif fallback:
        entries.append(fallback)

    out: List[str] = []
    seen: set[str] = set()
    for entry in entries:
        if entry in seen:
            continue
        seen.add(entry)
        out.append(entry)
    os.environ[env_name] = os.pathsep.join(out)


def configure_java_classpath(java_home: Optional[str | Path] = None) -> Path:
    compat_jar = ensure_javatuples_compat_jar(java_home)
    _prepend_path_list("OBF_JAVA_CLASSPATH", compat_jar)
    _prepend_path_list("CLASSPATH", compat_jar, fallback=".")
    return compat_jar


def _shell_quote(value: str | Path) -> str:
    return "'" + str(value).replace("'", "'\"'\"'") + "'"


def ensure_java_compat_wrappers(
    java_home: Optional[str | Path] = None,
    *,
    javac_path: Optional[str | Path] = None,
    java_path: Optional[str | Path] = None,
) -> Tuple[Path, Path]:
    compat_jar = configure_java_classpath(java_home)
    real_javac = Path(javac_path).expanduser().resolve() if javac_path else _resolve_java_tool("javac", java_home)
    real_java = Path(java_path).expanduser().resolve() if java_path else _resolve_java_tool("java", java_home)
    wrapper_dir = DEFAULT_JAVA_COMPAT_BUILD / "bin"
    wrapper_dir.mkdir(parents=True, exist_ok=True)

    javac_wrapper = wrapper_dir / "javac-with-compat"
    java_wrapper = wrapper_dir / "java-with-compat"
    javac_wrapper.write_text(
        "\n".join(
            [
                "#!/usr/bin/env bash",
                "set -e",
                f"REAL_JAVAC={_shell_quote(real_javac)}",
                f"COMPAT_JAR={_shell_quote(compat_jar)}",
                'BASE_CP="${COMPAT_JAR}"',
                'if [[ -n "${CLASSPATH:-}" ]]; then BASE_CP="${BASE_CP}:${CLASSPATH}"; fi',
                'exec "${REAL_JAVAC}" -cp "${BASE_CP}" "$@"',
                "",
            ]
        ),
        encoding="utf-8",
    )
    java_wrapper.write_text(
        "\n".join(
            [
                "#!/usr/bin/env bash",
                "set -e",
                f"REAL_JAVA={_shell_quote(real_java)}",
                f"COMPAT_JAR={_shell_quote(compat_jar)}",
                "ARGS=()",
                "HAD_CP=0",
                "while [[ $# -gt 0 ]]; do",
                '  case "$1" in',
                "    -cp|-classpath|--class-path)",
                "      OPT=\"$1\"",
                "      shift",
                "      HAD_CP=1",
                "      if [[ $# -eq 0 ]]; then",
                "        ARGS+=(\"${OPT}\")",
                "        break",
                "      fi",
                "      ARGS+=(\"${OPT}\" \"${COMPAT_JAR}:$1\")",
                "      shift",
                "      ;;",
                "    *)",
                "      ARGS+=(\"$1\")",
                "      shift",
                "      ;;",
                "  esac",
                "done",
                "if [[ ${HAD_CP} -eq 0 ]]; then",
                '  BASE_CP="${COMPAT_JAR}"',
                '  if [[ -n "${CLASSPATH:-}" ]]; then BASE_CP="${BASE_CP}:${CLASSPATH}"; else BASE_CP="${BASE_CP}:."; fi',
                '  exec "${REAL_JAVA}" -cp "${BASE_CP}" "${ARGS[@]}"',
                "fi",
                'exec "${REAL_JAVA}" "${ARGS[@]}"',
                "",
            ]
        ),
        encoding="utf-8",
    )
    javac_wrapper.chmod(0o755)
    java_wrapper.chmod(0o755)
    return javac_wrapper.resolve(), java_wrapper.resolve()


def clean_run_tag(raw: Optional[str], *, dataset: str, source_kind: str, mode: str) -> str:
    tag = (raw or "").strip()
    if not tag:
        tag = f"{time.strftime('%Y%m%d-%H%M%S')}-{dataset}-{source_kind}-prompt-{mode}-pid{os.getpid()}"
    return re.sub(r"[^A-Za-z0-9_.-]+", "_", tag)


def parse_gpu_ids(raw: Optional[str]) -> Optional[List[int]]:
    if not raw:
        return None
    out: List[int] = []
    for part in re.split(r"[+,]", raw.strip()):
        part = part.strip()
        if not part:
            continue
        if not part.isdigit():
            raise ValueError(f"Invalid GPU id '{part}' in --gpu-ids={raw!r}.")
        out.append(int(part))
    return out or None


def resolve_path(path: str | Path, *, project_root: Path, must_exist: bool = False) -> Path:
    p = Path(path).expanduser()
    if not p.is_absolute():
        p = project_root / p
    p = p.resolve()
    if must_exist and not p.exists():
        raise FileNotFoundError(str(p))
    return p


def resolve_original_source_dir(project_root: Path, dataset: str) -> Path:
    ds = dataset.strip().lower()
    if ds == "eyetracking":
        candidates = [project_root / "Source" / "eyetracking", project_root / "Source"]
    elif ds == "humaneval":
        root = project_root / "Source" / "Humaneval"
        candidates = [root / "java", root]
    elif ds == "cruxeval":
        root = project_root / "Source" / "Cruxeval"
        candidates = [root / "java", root]
    else:
        raise ValueError(f"Unsupported dataset: {dataset}")
    for cand in candidates:
        if cand.is_dir():
            return cand
    raise FileNotFoundError(f"No source directory found for dataset {dataset}: {candidates}")


def parse_csv_list(raw: Optional[str]) -> List[str]:
    if not raw:
        return []
    return [x.strip() for x in raw.split(",") if x.strip()]


def collect_original_sources(
    *,
    project_root: Path,
    dataset: str,
    snippets: Sequence[str] = (),
) -> List[Tuple[str, Path]]:
    source_dir = resolve_original_source_dir(project_root, dataset)
    requested = set(snippets)
    out: List[Tuple[str, Path]] = []
    if requested:
        for name in sorted(requested):
            path = source_dir / f"{name}.java"
            if not path.is_file():
                raise FileNotFoundError(f"Snippet {name!r} not found under {source_dir}.")
            out.append((name, path))
        return out
    for path in sorted(source_dir.glob("*.java")):
        out.append((path.stem, path))
    if not out:
        raise RuntimeError(f"No Java source files found under {source_dir}.")
    return out


def collect_obfuscated_sources(
    source_root: Path,
    *,
    snippets: Sequence[str] = (),
    techniques: Sequence[str] = (),
    tiers: Sequence[str] = (),
    allow_empty: bool = False,
) -> List[Tuple[str, str, str, Path]]:
    if not source_root.is_dir():
        raise FileNotFoundError(f"Prepared obfuscated corpus root missing: {source_root}")
    snippet_filter = set(snippets)
    technique_filter = set(techniques)
    tier_filter = set(tiers)
    out: List[Tuple[str, str, str, Path]] = []
    for snippet_dir in sorted(p for p in source_root.iterdir() if p.is_dir()):
        snippet = snippet_dir.name
        if snippet_filter and snippet not in snippet_filter:
            continue
        for technique_dir in sorted(p for p in snippet_dir.iterdir() if p.is_dir()):
            technique = technique_dir.name
            if technique_filter and technique not in technique_filter:
                continue
            direct_files = sorted(p for p in technique_dir.glob("*.java") if p.is_file())
            for path in direct_files:
                out.append((snippet, technique, "direct", path))
            for tier_dir in sorted(p for p in technique_dir.iterdir() if p.is_dir()):
                tier = tier_dir.name
                if tier_filter and tier not in tier_filter:
                    continue
                for path in sorted(p for p in tier_dir.glob("*.java") if p.is_file()):
                    out.append((snippet, technique, tier, path))
    if not out and not allow_empty:
        raise RuntimeError(f"No obfuscated Java variants matched filters under {source_root}.")
    return out


def prompt_guidance(mode: str, *, task: str) -> str:
    if mode == "none":
        return ""
    if mode == "slice":
        base = (
            "Prompt-only steering guidance: focus on the backward slice from the required "
            "observable result to the statements, variables, assignments, method calls, and "
            "conditions that can influence it. Ignore code that cannot affect the requested output."
        )
    elif mode == "cfg":
        base = (
            "Prompt-only steering guidance: focus on the control-flow path that is actually "
            "executed. Track branch outcomes, loop iterations, early exits, and method calls in order."
        )
    elif mode == "ast":
        base = (
            "Prompt-only steering guidance: focus on the program's AST-level structure: method "
            "boundaries, expression nesting, operators, call arguments, conditions, loops, and returns."
        )
    else:
        raise ValueError(f"Unsupported prompt steering mode: {mode}")
    if task in {"counterfactual_tf", "trace_prediction"}:
        return base + " Use this only as private reasoning guidance and obey the requested output format exactly."
    return base


def steer_instruction(base_instruction: str, mode: str, *, task: str) -> str:
    guidance = prompt_guidance(mode, task=task)
    if not guidance:
        return base_instruction
    return guidance + "\n\n" + base_instruction


def stdout_instruction() -> str:
    return (
        "You will analyze the Java program provided below. "
        "First, explain how you will predict the output for the code snippet. "
        "Then, simulate it as a compiler would and print the exact console output.\n"
    )


def canonicalize_model_output(text: str) -> Tuple[str, bool]:
    if not text:
        return "", False
    stripped = text.strip()
    fence_pattern = re.compile(r"```(\w+)?\s*\n?(.*?)\n?```", re.DOTALL)
    matches = list(fence_pattern.finditer(stripped))
    for match in reversed(matches):
        candidate = (match.group(2) or "").strip()
        if not candidate:
            continue
        lowered = candidate.lower()
        if "<your answer>" in lowered:
            continue
        if lowered.startswith("class ") or lowered.startswith("import "):
            continue
        return candidate, True
    if matches:
        tail = stripped[matches[-1].end() :].strip()
        if tail:
            return tail, True
    lines = stripped.splitlines()
    collected: List[str] = []
    for line in reversed(lines):
        clean = line.strip()
        if clean == "":
            if collected:
                break
            continue
        if re.search(r"[A-Za-z]", clean):
            if collected:
                break
            continue
        collected.append(clean)
    if collected:
        return "\n".join(reversed(collected)), True
    return stripped, bool(stripped)


def read_json(path: Path) -> Dict[str, Any]:
    return json.loads(path.read_text(encoding="utf-8"))


def write_json(path: Path, payload: Dict[str, Any]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(payload, indent=2, sort_keys=True), encoding="utf-8")


def iter_run_dirs(root: Path) -> Iterable[Path]:
    if not root.exists():
        return
    for path in sorted(root.rglob("model_output.json")):
        yield path.parent
