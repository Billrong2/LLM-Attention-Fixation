#!/usr/bin/env python3
"""Extract and execute long Java CodeContests candidates.

The script intentionally performs *prevalidation*, not model inference.  It
keeps at most one correct solution per dataset problem and only accepts a
solution when all of the following are true:

* the exact source is 250--350 physical lines;
* a non-void, parameterized, return-valued algorithm method is reachable from
  ``main`` through the source-local call graph;
* that method's return value is syntactically consumed by a print call on a
  path reachable from ``main``;
* the method is substantive and is not an obvious I/O/template helper; and
* JDK 17 compiles it without output and executes a dataset test with exit 0,
  empty stderr, no timeout, and byte-for-byte expected stdout.

The generated manifest embeds the selected input/output text as well as paths
and hashes, making it directly consumable by the later output-prediction run.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
from collections import Counter, defaultdict, deque
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any, Iterator, Sequence

import pyarrow.parquet as pq
from tree_sitter import Language, Node, Parser
import tree_sitter_java


DATASET_ID = "deepmind/code_contests"
DATASET_REVISION = "802411c3010cb00d1b05bad57ca77365a3c699d6"
DATASET_URL = (
    "https://huggingface.co/datasets/deepmind/code_contests/resolve/"
    f"{DATASET_REVISION}/data/valid-00000-of-00001-5e672c5751f060d3.parquet"
)
DATASET_SHA256 = "02e8c1ccedae716f1e43cc813fcb7823c3db666ea92638820aba80e8cef451ab"
DEFAULT_JAVA_HOME = Path("/people/cs/x/xxr230000/jdks/jdk-17.0.11+9")
JAVA_LANGUAGE_CODE = 4
PROJECT_ROOT = Path(__file__).resolve().parent.parents[1]

OUTPUT_METHOD_NAMES = frozenset({"print", "println", "printf"})
CONTROL_NODE_TYPES = frozenset(
    {
        "if_statement",
        "for_statement",
        "enhanced_for_statement",
        "while_statement",
        "do_statement",
        "switch_expression",
        "switch_statement",
        "conditional_expression",
        "try_statement",
    }
)

# These names are overwhelmingly contest scaffolding or generic library
# helpers.  Matching is deliberately exact/prefix-specific so algorithm names
# such as getMin are not discarded merely because they begin with "get".
REJECT_METHOD_RE = re.compile(
    r"^(?:"
    r"next(?:Int|Long|Double|Float|Char|Byte|Short|Boolean|Line|Token|Array|Arr|Ints|Longs|String|CharArray|IntArray|LongArray|LongArr).*|"
    r"read(?:Int|Long|Double|Float|Char|Byte|Short|Boolean|Line|Token|Array|Arr|Ints|Longs|String|Junk).*|"
    r"scan(?:Int|Long|Double|Line|String).*|"
    r"input(?:Int|Long|Array|Arr|String|L)?|output.*|"
    r"print.*|write.*|append|flush|close|"
    r"isSpaceChar|isWhiteSpace|isWhitespace|countDigits|"
    r"sort|swap|gcd|lcm|pow|power|modPow|binPow|"
    r"lowerBound|upperBound|binarySearch|compare|compareTo|"
    r"equals|hashCode|toString|nia|ni|nl|ns|arr|of"
    r")$",
    re.IGNORECASE,
)
REJECT_CLASS_RE = re.compile(
    r"(?:scanner|reader|writer|input|output|fastio|fastscan|fastread|printer)",
    re.IGNORECASE,
)
PACKAGE_RE = re.compile(r"(?m)^\s*package\s+([A-Za-z_$][\w$]*(?:\.[A-Za-z_$][\w$]*)*)\s*;")


def sha256_bytes(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def node_text(node: Node | None, source: bytes) -> str:
    if node is None:
        return ""
    return source[node.start_byte : node.end_byte].decode("utf-8", "strict")


def walk(node: Node) -> Iterator[Node]:
    yield node
    for child in node.children:
        yield from walk(child)


def physical_loc(text: str) -> int:
    return len(text.splitlines())


def slugify(value: str) -> str:
    value = re.sub(r"[^a-z0-9]+", "-", value.lower()).strip("-")
    return value[:48] or "problem"


def json_dump(path: Path, value: Any) -> None:
    path.write_text(
        json.dumps(value, indent=2, sort_keys=True, ensure_ascii=False) + "\n",
        encoding="utf-8",
    )


@dataclass
class Invocation:
    name: str
    arity: int
    node: Node


@dataclass
class Method:
    index: int
    name: str
    return_type: str
    parameter_types: list[str]
    node: Node
    body: Node
    class_name: str
    modifiers: str
    invocations: list[Invocation] = field(default_factory=list)

    @property
    def arity(self) -> int:
        return len(self.parameter_types)

    @property
    def key(self) -> tuple[str, int]:
        return (self.name, self.arity)


@dataclass
class StructuralCandidate:
    row_index: int
    solution_index: int
    row: dict[str, Any]
    source: str
    source_bytes: bytes
    source_loc: int
    source_nonblank_loc: int
    main_class: str
    compile_class: str
    runtime_class: str
    target: Method
    call_path: list[Method]
    output_caller: Method
    output_expression: str
    output_relevance_kind: str
    output_relevance_variable: str | None
    target_body_loc: int
    target_nonblank_loc: int
    control_nodes: int
    loop_nodes: int
    recursive_calls: int
    codesteer_selector: dict[str, Any]
    score: tuple[Any, ...]


def nearest_class_name(node: Node, source: bytes) -> str:
    parent = node.parent
    while parent is not None:
        if parent.type in {"class_declaration", "record_declaration", "enum_declaration"}:
            return node_text(parent.child_by_field_name("name"), source)
        parent = parent.parent
    return ""


def parameter_types(parameters: Node, source: bytes) -> list[str]:
    result: list[str] = []
    for child in parameters.named_children:
        if child.type not in {"formal_parameter", "spread_parameter"}:
            continue
        type_node = child.child_by_field_name("type")
        type_text = node_text(type_node, source)
        if child.type == "spread_parameter":
            type_text += "..."
        result.append(type_text)
    return result


def parse_methods(source: bytes, parser: Parser) -> tuple[Node, list[Method]]:
    root = parser.parse(source).root_node
    if root.has_error:
        raise ValueError("tree-sitter parse contains ERROR or missing nodes")
    methods: list[Method] = []
    for node in walk(root):
        if node.type != "method_declaration":
            continue
        name_node = node.child_by_field_name("name")
        type_node = node.child_by_field_name("type")
        params_node = node.child_by_field_name("parameters")
        body_node = node.child_by_field_name("body")
        if not all((name_node, type_node, params_node, body_node)):
            continue
        modifiers_node = next((c for c in node.children if c.type == "modifiers"), None)
        method = Method(
            index=len(methods),
            name=node_text(name_node, source),
            return_type=node_text(type_node, source),
            parameter_types=parameter_types(params_node, source),
            node=node,
            body=body_node,
            class_name=nearest_class_name(node, source),
            modifiers=node_text(modifiers_node, source),
        )
        for descendant in walk(body_node):
            if descendant.type != "method_invocation":
                continue
            call_name = descendant.child_by_field_name("name")
            args = descendant.child_by_field_name("arguments")
            if call_name is None or args is None:
                continue
            method.invocations.append(
                Invocation(
                    name=node_text(call_name, source),
                    arity=len(args.named_children),
                    node=descendant,
                )
            )
        methods.append(method)
    return root, methods


def find_main(methods: Sequence[Method]) -> Method:
    candidates = [
        method
        for method in methods
        if method.name == "main"
        and method.return_type == "void"
        and method.arity == 1
        and "String" in method.parameter_types[0]
        and "static" in method.modifiers
    ]
    if len(candidates) != 1:
        raise ValueError(f"expected one static Java main method, found {len(candidates)}")
    return candidates[0]


def output_ancestor(invocation: Node, method: Method, source: bytes) -> Node | None:
    ancestor = invocation.parent
    while ancestor is not None and ancestor != method.node:
        if ancestor.type == "method_invocation":
            name = node_text(ancestor.child_by_field_name("name"), source)
            if name in OUTPUT_METHOD_NAMES:
                return ancestor
        ancestor = ancestor.parent
    return None


def identifier_names(node: Node | None, source: bytes) -> set[str]:
    if node is None:
        return set()
    return {
        node_text(descendant, source)
        for descendant in walk(node)
        if descendant.type == "identifier"
    }


def assignment_destination(
    invocation: Node,
    method: Method,
    source: bytes,
) -> tuple[str, Node] | None:
    """Find a simple local/identifier assignment receiving a call result."""
    ancestor = invocation.parent
    while ancestor is not None and ancestor != method.node:
        if ancestor.type == "variable_declarator":
            name = ancestor.child_by_field_name("name")
            value = ancestor.child_by_field_name("value")
            if (
                name is not None
                and value is not None
                and value.start_byte <= invocation.start_byte < invocation.end_byte <= value.end_byte
            ):
                return node_text(name, source), ancestor
        if ancestor.type == "assignment_expression":
            left = ancestor.child_by_field_name("left")
            right = ancestor.child_by_field_name("right")
            if (
                left is not None
                and left.type == "identifier"
                and right is not None
                and right.start_byte <= invocation.start_byte < invocation.end_byte <= right.end_byte
            ):
                return node_text(left, source), ancestor
        ancestor = ancestor.parent
    return None


def printed_taint_sink(
    method: Method,
    initial_variable: str,
    after_byte: int,
    source: bytes,
) -> tuple[Node, set[str]] | None:
    """Conservative lexical local-variable propagation into a print argument."""
    tainted = {initial_variable}
    events = [
        node
        for node in walk(method.body)
        if node.start_byte >= after_byte
        and node.type in {"variable_declarator", "assignment_expression", "method_invocation"}
    ]
    events.sort(key=lambda node: (node.start_byte, -node.end_byte))
    for node in events:
        if node.type == "method_invocation":
            name = node_text(node.child_by_field_name("name"), source)
            arguments = node.child_by_field_name("arguments")
            if name in OUTPUT_METHOD_NAMES and identifier_names(arguments, source) & tainted:
                return node, set(tainted)
            continue
        if node.type == "variable_declarator":
            destination = node.child_by_field_name("name")
            value = node.child_by_field_name("value")
        else:
            destination = node.child_by_field_name("left")
            value = node.child_by_field_name("right")
            if destination is not None and destination.type != "identifier":
                destination = None
        if destination is None or value is None:
            continue
        if identifier_names(value, source) & tainted:
            tainted.add(node_text(destination, source))
    return None


def predicate_output_sink(invocation: Node, method: Method, source: bytes) -> Node | None:
    ancestor = invocation.parent
    while ancestor is not None and ancestor != method.node:
        if ancestor.type in {
            "if_statement",
            "while_statement",
            "do_statement",
            "for_statement",
            "conditional_expression",
        }:
            condition = ancestor.child_by_field_name("condition")
            if (
                condition is not None
                and condition.start_byte <= invocation.start_byte < invocation.end_byte <= condition.end_byte
            ):
                for descendant in walk(ancestor):
                    if descendant.type != "method_invocation" or descendant == invocation:
                        continue
                    name = node_text(descendant.child_by_field_name("name"), source)
                    if name in OUTPUT_METHOD_NAMES and descendant.start_byte > condition.end_byte:
                        return descendant
        ancestor = ancestor.parent
    return None


def output_relevance_evidence(
    invocation: Invocation,
    method: Method,
    source: bytes,
) -> dict[str, Any] | None:
    direct_sink = output_ancestor(invocation.node, method, source)
    if direct_sink is not None:
        return {
            "kind": "direct_print_argument",
            "variable": None,
            "expression": node_text(direct_sink, source),
        }
    assignment = assignment_destination(invocation.node, method, source)
    if assignment is not None:
        variable, assignment_node = assignment
        taint_sink = printed_taint_sink(method, variable, assignment_node.end_byte, source)
        if taint_sink is not None:
            sink, tainted = taint_sink
            expression = (
                f"{node_text(assignment_node, source)} -> {node_text(sink, source)}"
            )
            return {
                "kind": "local_assignment_then_print",
                "variable": variable,
                "tainted_variables": sorted(tainted),
                "expression": expression,
            }
    predicate_sink = predicate_output_sink(invocation.node, method, source)
    if predicate_sink is not None:
        return {
            "kind": "output_control_predicate",
            "variable": None,
            "expression": (
                f"{node_text(invocation.node, source)} controls {node_text(predicate_sink, source)}"
            ),
        }
    return None


def class_is_public(root: Node, class_name: str, source: bytes) -> bool:
    for node in root.named_children:
        if node.type not in {"class_declaration", "record_declaration", "enum_declaration"}:
            continue
        if node_text(node.child_by_field_name("name"), source) != class_name:
            continue
        modifiers = next((c for c in node.children if c.type == "modifiers"), None)
        return "public" in node_text(modifiers, source).split()
    return False


def public_top_level_classes(root: Node, source: bytes) -> list[str]:
    result: list[str] = []
    for node in root.named_children:
        if node.type not in {"class_declaration", "record_declaration", "enum_declaration"}:
            continue
        modifiers = next((c for c in node.children if c.type == "modifiers"), None)
        if "public" in node_text(modifiers, source).split():
            result.append(node_text(node.child_by_field_name("name"), source))
    return result


def source_local_call_graph(
    methods: Sequence[Method],
) -> tuple[dict[int, list[int]], dict[tuple[str, int], list[Method]]]:
    by_key: dict[tuple[str, int], list[Method]] = defaultdict(list)
    for method in methods:
        by_key[method.key].append(method)
    graph: dict[int, list[int]] = defaultdict(list)
    for caller in methods:
        for call in caller.invocations:
            declarations = by_key.get((call.name, call.arity), [])
            # Exact steering targets require an unambiguous local declaration.
            if len(declarations) == 1:
                graph[caller.index].append(declarations[0].index)
    return graph, by_key


def exact_codesteer_selector(source: str) -> dict[str, Any]:
    """Run the repository's actual SlicingPrior target selector.

    Reimplementing its policy would risk silent drift.  This calls the private
    selector used by the experiment runner and treats a javalang parse failure
    as ineligible rather than accepting a heuristic fallback.
    """
    if str(PROJECT_ROOT) not in sys.path:
        sys.path.insert(0, str(PROJECT_ROOT))
    from steering.priors import PriorContext, SlicingPrior

    prior = SlicingPrior(
        PriorContext(prompt_tokens=[], code_text=source, vocab_tokens=[], prompt_text="")
    )
    javalang_mod = prior._try_import()
    if javalang_mod is None:
        raise ValueError("CodeSteer javalang dependency is unavailable")
    _lines, _tokens, tree = prior._prepare_parse_artifacts(javalang_mod)
    if tree is None:
        raise ValueError("CodeSteer javalang parse failed")
    selected = prior._select_target_method(tree, javalang_mod)
    if selected is None:
        raise ValueError("CodeSteer selected no target method")
    position = getattr(selected, "position", None)
    return {
        "implementation": "steering.priors.SlicingPrior._select_target_method",
        "parse_status": "javalang",
        "fallback_used": False,
        "name": str(getattr(selected, "name", "") or ""),
        "parameter_count": len(getattr(selected, "parameters", []) or []),
        "declaration_line": int(position.line) if position is not None else None,
        "top_level_body_statement_count": len(getattr(selected, "body", []) or []),
    }


def reachable_paths(main: Method, methods: Sequence[Method], graph: dict[int, list[int]]) -> dict[int, list[int]]:
    paths: dict[int, list[int]] = {main.index: [main.index]}
    queue: deque[int] = deque([main.index])
    while queue:
        current = queue.popleft()
        for target in graph.get(current, []):
            if target in paths:
                continue
            paths[target] = [*paths[current], target]
            queue.append(target)
    return paths


def analyze_solution(
    row_index: int,
    solution_index: int,
    row: dict[str, Any],
    source: str,
    parser: Parser,
    analysis_stats: Counter[str],
) -> list[StructuralCandidate]:
    source_bytes = source.encode("utf-8")
    root, methods = parse_methods(source_bytes, parser)
    main = find_main(methods)
    graph, by_key = source_local_call_graph(methods)
    paths = reachable_paths(main, methods, graph)
    public_classes = public_top_level_classes(root, source_bytes)
    if len(public_classes) > 1:
        raise ValueError("multiple public top-level classes")
    compile_class = public_classes[0] if public_classes else main.class_name
    if not compile_class or not main.class_name:
        raise ValueError("could not identify main/compilation class")
    package_match = PACKAGE_RE.search(source)
    runtime_class = (
        f"{package_match.group(1)}.{main.class_name}" if package_match else main.class_name
    )

    result: list[StructuralCandidate] = []
    for target in methods:
        if target.index not in paths:
            continue
        if target.return_type == "void" or target.arity == 0:
            continue
        if len(by_key[target.key]) != 1:
            continue
        if sum(method.name == target.name for method in methods) != 1:
            continue
        if REJECT_METHOD_RE.fullmatch(target.name) or REJECT_CLASS_RE.search(target.class_name):
            continue

        body_text = node_text(target.body, source_bytes)
        body_loc = target.body.end_point[0] - target.body.start_point[0] + 1
        body_nonblank = sum(bool(line.strip()) for line in body_text.splitlines())
        descendants = list(walk(target.body))
        return_nodes = [
            node
            for node in descendants
            if node.type == "return_statement" and bool(node.named_children)
        ]
        if not return_nodes or body_loc < 10 or body_nonblank < 8:
            continue
        control_nodes = sum(node.type in CONTROL_NODE_TYPES for node in descendants)
        loop_nodes = sum(
            node.type in {"for_statement", "enhanced_for_statement", "while_statement", "do_statement"}
            for node in descendants
        )
        recursive_calls = sum(
            call.name == target.name and call.arity == target.arity for call in target.invocations
        )
        if control_nodes < 2 and body_nonblank < 20:
            continue

        # The exact CodeSteer target must be called by main.  Output relevance
        # is either direct, a simple local return-value dataflow into print, or
        # use as the predicate controlling a print-bearing branch.
        evidence: list[tuple[Invocation, dict[str, Any]]] = []
        for call in main.invocations:
            if (call.name, call.arity) != target.key:
                continue
            relevance = output_relevance_evidence(call, main, source_bytes)
            if relevance is not None:
                evidence.append((call, relevance))
        if not evidence:
            continue
        evidence_rank = {
            "direct_print_argument": 0,
            "local_assignment_then_print": 1,
            "output_control_predicate": 2,
        }
        _call, relevance = min(
            evidence,
            key=lambda item: (evidence_rank[item[1]["kind"]], item[0].node.start_byte),
        )
        output_caller = main
        call_path = [main, target]

        # Ranking is deterministic and favors near-300-line sources, large
        # algorithm bodies, direct/short output paths, and control structure.
        relevance_rank = evidence_rank[relevance["kind"]]
        score = (
            abs(physical_loc(source) - 300),
            relevance_rank,
            -min(body_nonblank, 80),
            -min(control_nodes, 30),
            len(call_path),
            solution_index,
            target.node.start_byte,
        )
        result.append(
            StructuralCandidate(
                row_index=row_index,
                solution_index=solution_index,
                row=row,
                source=source,
                source_bytes=source_bytes,
                source_loc=physical_loc(source),
                source_nonblank_loc=sum(bool(line.strip()) for line in source.splitlines()),
                main_class=main.class_name,
                compile_class=compile_class,
                runtime_class=runtime_class,
                target=target,
                call_path=call_path,
                output_caller=output_caller,
                output_expression=str(relevance["expression"])[:1000],
                output_relevance_kind=str(relevance["kind"]),
                output_relevance_variable=relevance.get("variable"),
                target_body_loc=body_loc,
                target_nonblank_loc=body_nonblank,
                control_nodes=control_nodes,
                loop_nodes=loop_nodes,
                recursive_calls=recursive_calls,
                codesteer_selector={},
                score=score,
            )
        )
    if not result:
        return result
    analysis_stats["solutions_with_output_relevant_target_pre_selector"] += 1
    analysis_stats["output_relevant_targets_pre_selector"] += len(result)
    try:
        selected = exact_codesteer_selector(source)
    except (ImportError, RuntimeError, ValueError):
        analysis_stats["codesteer_selector_failures"] += 1
        return []
    matched: list[StructuralCandidate] = []
    for candidate in result:
        if selected["name"] != candidate.target.name:
            continue
        if selected["parameter_count"] != candidate.target.arity:
            continue
        candidate.codesteer_selector = dict(selected)
        matched.append(candidate)
    analysis_stats["output_relevant_targets_rejected_by_codesteer_selector"] += len(result) - len(matched)
    if matched:
        analysis_stats["solutions_with_exact_codesteer_target"] += 1
        analysis_stats["exact_codesteer_targets"] += len(matched)
    return matched


def test_cases(
    row: dict[str, Any],
    min_input_bytes: int,
    max_input_bytes: int,
    max_output_bytes: int,
    max_output_lines: int,
) -> list[dict[str, Any]]:
    result: list[dict[str, Any]] = []
    for suite in ("public_tests", "private_tests", "generated_tests"):
        group = row.get(suite) or {}
        inputs = group.get("input") or []
        outputs = group.get("output") or []
        for index, (input_text, output_text) in enumerate(zip(inputs, outputs)):
            if input_text is None or output_text is None or output_text == "":
                continue
            input_bytes = input_text.encode("utf-8")
            output_bytes = output_text.encode("utf-8")
            if not min_input_bytes <= len(input_bytes) <= max_input_bytes:
                continue
            if len(output_bytes) > max_output_bytes or len(output_text.splitlines()) > max_output_lines:
                continue
            result.append(
                {
                    "suite": suite,
                    "index": index,
                    "input": input_text,
                    "expected_stdout": output_text,
                    "input_bytes": input_bytes,
                    "expected_bytes": output_bytes,
                }
            )
    # Prefer hidden/private cases to reduce memorization risk.  Within a suite,
    # favor a moderately sized input rather than a toy/single-token example.
    # Dataset indices are the deterministic final tie breaker.
    suite_rank = {"private_tests": 0, "generated_tests": 1, "public_tests": 2}
    result.sort(
        key=lambda case: (
            suite_rank[case["suite"]],
            abs(len(case["input_bytes"]) - 256),
            -len(case["input_bytes"]),
            len(case["expected_bytes"]),
            case["index"],
        )
    )
    return result


def clean_subprocess_env() -> dict[str, str]:
    env = os.environ.copy()
    for variable in ("JAVA_TOOL_OPTIONS", "JDK_JAVA_OPTIONS", "_JAVA_OPTIONS", "CLASSPATH"):
        env.pop(variable, None)
    env.update({"LC_ALL": "C", "LANG": "C"})
    return env


def compile_and_validate(
    candidate: StructuralCandidate,
    cases: Sequence[dict[str, Any]],
    java_home: Path,
    timeout_seconds: float,
    tests_per_sample: int,
    scratch_parent: Path,
) -> tuple[list[dict[str, Any]], str | None]:
    javac = java_home / "bin" / "javac"
    java = java_home / "bin" / "java"
    env = clean_subprocess_env()
    with tempfile.TemporaryDirectory(prefix="candidate-", dir=scratch_parent) as temp_name:
        temp = Path(temp_name)
        source_path = temp / f"{candidate.compile_class}.java"
        classes = temp / "classes"
        classes.mkdir()
        source_path.write_bytes(candidate.source_bytes)
        compile_command = [
            str(javac),
            "-encoding",
            "UTF-8",
            "-Xlint:none",
            "-nowarn",
            "-d",
            str(classes),
            str(source_path),
        ]
        try:
            compiled = subprocess.run(
                compile_command,
                cwd=temp,
                env=env,
                stdin=subprocess.DEVNULL,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                timeout=timeout_seconds,
                check=False,
            )
        except subprocess.TimeoutExpired:
            return [], "compile_timeout"
        if compiled.returncode != 0:
            return [], "compile_nonzero"
        if compiled.stdout:
            return [], "compile_stdout"
        if compiled.stderr:
            return [], "compile_stderr"

        passed: list[dict[str, Any]] = []
        for case in cases:
            command = [
                str(java),
                "-Dfile.encoding=UTF-8",
                "-cp",
                str(classes),
                candidate.runtime_class,
            ]
            try:
                execution = subprocess.run(
                    command,
                    cwd=temp,
                    env=env,
                    input=case["input_bytes"],
                    stdout=subprocess.PIPE,
                    stderr=subprocess.PIPE,
                    timeout=timeout_seconds,
                    check=False,
                )
            except subprocess.TimeoutExpired:
                continue
            if execution.returncode != 0 or execution.stderr:
                continue
            if execution.stdout != case["expected_bytes"]:
                continue
            passed.append(case)
            if len(passed) >= tests_per_sample:
                break
        if len(passed) < tests_per_sample:
            return [], "no_exact_dataset_test"
        return passed, None


def target_signature(candidate: StructuralCandidate) -> str:
    params = ", ".join(candidate.target.parameter_types)
    return f"{candidate.target.return_type} {candidate.target.class_name}.{candidate.target.name}({params})"


def method_descriptor(method: Method) -> dict[str, Any]:
    return {
        "class": method.class_name,
        "name": method.name,
        "arity": method.arity,
        "parameter_types": method.parameter_types,
        "return_type": method.return_type,
        "start_line": method.node.start_point[0] + 1,
        "end_line": method.node.end_point[0] + 1,
    }


def problem_key(candidate: StructuralCandidate) -> str:
    contest = candidate.row.get("cf_contest_id")
    index = candidate.row.get("cf_index")
    if contest is not None and index:
        return f"codeforces-{contest}-{index}"
    return f"valid-row-{candidate.row_index:03d}"


def sample_id(candidate: StructuralCandidate) -> str:
    return (
        f"cc-valid-r{candidate.row_index:03d}-s{candidate.solution_index:04d}-"
        f"{slugify(str(candidate.row.get('name') or 'problem'))}"
    )


def write_sample(
    output_root: Path,
    candidate: StructuralCandidate,
    cases: Sequence[dict[str, Any]],
    dataset_file: Path,
) -> dict[str, Any]:
    identifier = sample_id(candidate)
    sample_root = output_root / "candidates" / identifier
    io_root = sample_root / "io"
    io_root.mkdir(parents=True, exist_ok=False)
    original_path = sample_root / "original.java"
    original_path.write_bytes(candidate.source_bytes)

    test_entries: list[dict[str, Any]] = []
    for position, case in enumerate(cases):
        stem = f"{position:02d}-{case['suite'].removesuffix('_tests')}-{case['index']:03d}"
        input_path = io_root / f"{stem}.in"
        output_path = io_root / f"{stem}.out"
        input_path.write_bytes(case["input_bytes"])
        output_path.write_bytes(case["expected_bytes"])
        test_entries.append(
            {
                "id": stem,
                "suite": case["suite"],
                "dataset_test_index": case["index"],
                "input": case["input"],
                "expected_stdout": case["expected_stdout"],
                "input_path": input_path.relative_to(output_root).as_posix(),
                "expected_stdout_path": output_path.relative_to(output_root).as_posix(),
                "input_sha256": sha256_bytes(case["input_bytes"]),
                "expected_stdout_sha256": sha256_bytes(case["expected_bytes"]),
                "validation": {
                    "compiled_with_jdk17": True,
                    "exit_code": 0,
                    "timed_out": False,
                    "stderr_bytes": 0,
                    "stdout_exact_byte_match": True,
                },
            }
        )

    first = test_entries[0]
    row = candidate.row
    provenance = {
        "dataset_id": DATASET_ID,
        "dataset_revision": DATASET_REVISION,
        "dataset_url": DATASET_URL,
        "dataset_file": dataset_file.name,
        "dataset_file_sha256": DATASET_SHA256,
        "split": "valid",
        "row_index": candidate.row_index,
        "solution_container": "solutions",
        "solution_index": candidate.solution_index,
        "language": "Java",
        "language_code": JAVA_LANGUAGE_CODE,
        "solution_label": "correct human solution",
        "problem_name": row.get("name"),
        "source_code": row.get("source"),
        "difficulty": row.get("difficulty"),
        "cf_contest_id": row.get("cf_contest_id"),
        "cf_index": row.get("cf_index"),
        "cf_points": row.get("cf_points"),
        "cf_rating": row.get("cf_rating"),
        "cf_tags": row.get("cf_tags") or [],
    }
    entry: dict[str, Any] = {
        "id": identifier,
        "problem_key": problem_key(candidate),
        "problem_name": row.get("name"),
        "original_path": original_path.relative_to(output_root).as_posix(),
        "source_sha256": sha256_bytes(candidate.source_bytes),
        "source_bytes": len(candidate.source_bytes),
        "physical_loc": candidate.source_loc,
        "nonblank_loc": candidate.source_nonblank_loc,
        "loc_definition": "Python str.splitlines(); final newline does not add an empty physical line",
        "main_class": candidate.runtime_class,
        "target_method": candidate.target.name,
        "target_signature": target_signature(candidate),
        "target": {
            **method_descriptor(candidate.target),
            "body_physical_loc": candidate.target_body_loc,
            "body_nonblank_loc": candidate.target_nonblank_loc,
            "control_node_count": candidate.control_nodes,
            "loop_node_count": candidate.loop_nodes,
            "recursive_call_count": candidate.recursive_calls,
            "source_sha256": sha256_bytes(
                candidate.source_bytes[candidate.target.node.start_byte : candidate.target.node.end_byte]
            ),
            "main_reachable": True,
            "return_value_output_relevant": True,
            "output_relevance_kind": candidate.output_relevance_kind,
            "output_relevance_variable": candidate.output_relevance_variable,
            "output_evidence": candidate.output_expression,
            "output_caller": method_descriptor(candidate.output_caller),
            "main_call_path": [method_descriptor(method) for method in candidate.call_path],
            "codesteer_selector": candidate.codesteer_selector,
        },
        # Singular aliases are intentionally present for the downstream runner.
        "input": first["input"],
        "expected_stdout": first["expected_stdout"],
        "input_path": first["input_path"],
        "expected_stdout_path": first["expected_stdout_path"],
        "inputs": test_entries,
        "tests": test_entries,
        "provenance": provenance,
        "prevalidation": {
            "jdk_major": 17,
            "compiled": True,
            "compiler_exit_code": 0,
            "compiler_stdout_bytes": 0,
            "compiler_stderr_bytes": 0,
            "all_retained_tests_exact": True,
        },
    }
    json_dump(sample_root / "metadata.json", entry)
    return entry


def java_version(java_home: Path) -> str:
    result = subprocess.run(
        [str(java_home / "bin" / "java"), "-version"],
        stdin=subprocess.DEVNULL,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        env=clean_subprocess_env(),
        check=False,
        timeout=10,
        text=True,
    )
    if result.returncode != 0:
        raise RuntimeError(f"failed to query Java version: {result.stderr.strip()}")
    return (result.stderr or result.stdout).strip()


def build_arg_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--dataset",
        type=Path,
        default=Path(__file__).resolve().parent / "codecontests-valid-802411c3.parquet",
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=Path(__file__).resolve().parent / "candidate_pool",
    )
    parser.add_argument("--java-home", type=Path, default=DEFAULT_JAVA_HOME)
    parser.add_argument("--min-loc", type=int, default=250)
    parser.add_argument("--max-loc", type=int, default=350)
    parser.add_argument("--tests-per-sample", type=int, default=1)
    parser.add_argument("--timeout-seconds", type=float, default=8.0)
    parser.add_argument("--min-input-bytes", type=int, default=20)
    parser.add_argument("--max-input-bytes", type=int, default=4096)
    parser.add_argument("--max-output-bytes", type=int, default=300)
    parser.add_argument("--max-output-lines", type=int, default=20)
    parser.add_argument(
        "--max-samples",
        type=int,
        default=0,
        help="0 retains every passing candidate within the per-problem cap",
    )
    parser.add_argument(
        "--max-solutions-per-problem",
        type=int,
        default=3,
        help=(
            "retain up to this many distinct human solutions per problem for screening; "
            "the final case-study selector can enforce unique problems"
        ),
    )
    parser.add_argument("--force", action="store_true", help="replace an existing output directory")
    return parser


def main(argv: Sequence[str] | None = None) -> int:
    args = build_arg_parser().parse_args(argv)
    dataset = args.dataset.resolve()
    output = args.output.resolve()
    java_home = args.java_home.resolve()
    if not dataset.is_file():
        raise FileNotFoundError(dataset)
    actual_dataset_hash = sha256_file(dataset)
    if actual_dataset_hash != DATASET_SHA256:
        raise RuntimeError(
            f"dataset SHA-256 mismatch: expected {DATASET_SHA256}, got {actual_dataset_hash}"
        )
    for executable in (java_home / "bin" / "java", java_home / "bin" / "javac"):
        if not executable.is_file():
            raise FileNotFoundError(executable)
    if args.min_loc < 1 or args.max_loc < args.min_loc:
        raise ValueError("invalid LOC bounds")
    if args.tests_per_sample < 1:
        raise ValueError("--tests-per-sample must be positive")
    if args.max_solutions_per_problem < 1:
        raise ValueError("--max-solutions-per-problem must be positive")
    if output.exists():
        if not args.force:
            raise FileExistsError(f"output exists (pass --force to replace): {output}")
        shutil.rmtree(output)
    output.mkdir(parents=True)
    scratch = output / ".scratch"
    scratch.mkdir()

    parser = Parser(Language(tree_sitter_java.language()))
    table = pq.read_table(dataset)
    rows = table.to_pylist()
    stats: Counter[str] = Counter()
    stats["dataset_rows"] = len(rows)
    structural: list[StructuralCandidate] = []
    for row_index, row in enumerate(rows):
        solutions = row.get("solutions") or {}
        languages = solutions.get("language") or []
        sources = solutions.get("solution") or []
        for solution_index, (language, source) in enumerate(zip(languages, sources)):
            if language != JAVA_LANGUAGE_CODE:
                continue
            stats["java_solutions"] += 1
            loc = physical_loc(source)
            if not args.min_loc <= loc <= args.max_loc:
                continue
            stats["java_solutions_in_loc_window"] += 1
            try:
                candidates = analyze_solution(
                    row_index,
                    solution_index,
                    row,
                    source,
                    parser,
                    stats,
                )
            except (UnicodeError, ValueError):
                stats["structural_parse_or_main_rejections"] += 1
                continue
            if candidates:
                stats["solutions_with_structural_target"] += 1
                structural.extend(candidates)
    stats["structural_targets"] = len(structural)
    stats["structural_target_problems"] = len({problem_key(candidate) for candidate in structural})

    grouped: dict[str, list[StructuralCandidate]] = defaultdict(list)
    for candidate in structural:
        grouped[problem_key(candidate)].append(candidate)
    for candidates in grouped.values():
        candidates.sort(key=lambda candidate: candidate.score)

    selected: list[dict[str, Any]] = []
    rejection_reasons: Counter[str] = Counter()
    ordered_problems = sorted(
        grouped,
        key=lambda key: (grouped[key][0].score, grouped[key][0].row_index, key),
    )
    for key in ordered_problems:
        accepted_for_problem = 0
        for candidate in grouped[key]:
            if accepted_for_problem >= args.max_solutions_per_problem:
                break
            cases = test_cases(
                candidate.row,
                args.min_input_bytes,
                args.max_input_bytes,
                args.max_output_bytes,
                args.max_output_lines,
            )
            if not cases:
                rejection_reasons["no_bounded_dataset_test"] += 1
                continue
            passed, reason = compile_and_validate(
                candidate,
                cases,
                java_home,
                args.timeout_seconds,
                args.tests_per_sample,
                scratch,
            )
            stats["compiled_candidates_attempted"] += 1
            if reason:
                rejection_reasons[reason] += 1
                continue
            selected.append(write_sample(output, candidate, passed, dataset))
            stats["accepted_samples"] += 1
            accepted_for_problem += 1
            if args.max_samples and len(selected) >= args.max_samples:
                break
        if accepted_for_problem:
            stats["accepted_problems"] += 1
        else:
            stats["problems_without_executable_candidate"] += 1
        if args.max_samples and len(selected) >= args.max_samples:
            break

    shutil.rmtree(scratch)
    selected.sort(key=lambda item: (abs(item["physical_loc"] - 300), item["id"]))
    manifest = {
        "schema_version": 1,
        "purpose": "prevalidated candidate pool for the long-code output-prediction case study",
        "selection_scope": "outcome-blind; no model inference was run by this extractor",
        "dataset": {
            "id": DATASET_ID,
            "revision": DATASET_REVISION,
            "url": DATASET_URL,
            "split": "valid",
            "local_file": dataset.name,
            "sha256": actual_dataset_hash,
            "rows": len(rows),
        },
        "jdk": {
            "java_home": str(java_home),
            "version": java_version(java_home),
        },
        "criteria": {
            "language": "Java",
            "language_code": JAVA_LANGUAGE_CODE,
            "correct_solution_container": "solutions",
            "min_physical_loc": args.min_loc,
            "max_physical_loc": args.max_loc,
            "one_solution_per_problem": args.max_solutions_per_problem == 1,
            "max_solutions_per_problem": args.max_solutions_per_problem,
            "final_case_study_should_enforce_unique_problems": True,
            "target_main_reachable": True,
            "target_directly_called_by_main": True,
            "target_parameterized": True,
            "target_nonvoid": True,
            "target_has_value_return": True,
            "target_output_relevance_modes": [
                "direct_print_argument",
                "local_assignment_then_print",
                "output_control_predicate",
            ],
            "target_matches_exact_codesteer_selector": True,
            "codesteer_selector": "steering.priors.SlicingPrior._select_target_method",
            "codesteer_selector_fallback_allowed": False,
            "reject_io_and_template_helpers": True,
            "tests_per_sample": args.tests_per_sample,
            "test_suite_preference": ["private_tests", "generated_tests", "public_tests"],
            "min_input_bytes": args.min_input_bytes,
            "max_input_bytes": args.max_input_bytes,
            "max_output_bytes": args.max_output_bytes,
            "max_output_lines": args.max_output_lines,
            "runtime_timeout_seconds": args.timeout_seconds,
            "stdout_comparison": "exact UTF-8 bytes; no whitespace normalization",
            "require_empty_compile_stdout_stderr": True,
            "require_empty_runtime_stderr": True,
        },
        "stats": dict(sorted(stats.items())),
        "execution_rejections": dict(sorted(rejection_reasons.items())),
        "samples": selected,
    }
    json_dump(output / "candidate_manifest.json", manifest)
    with (output / "candidate_index.tsv").open("w", encoding="utf-8", newline="") as handle:
        handle.write("id\tproblem\tloc\ttarget_method\ttarget_signature\toriginal_path\n")
        for sample in selected:
            values = [
                sample["id"],
                str(sample["problem_name"]),
                str(sample["physical_loc"]),
                sample["target_method"],
                sample["target_signature"],
                sample["original_path"],
            ]
            handle.write("\t".join(value.replace("\t", " ").replace("\n", " ") for value in values) + "\n")

    print(json.dumps({"output": str(output), "stats": manifest["stats"], "execution_rejections": manifest["execution_rejections"]}, indent=2))
    return 0 if selected else 2


if __name__ == "__main__":
    sys.exit(main())
