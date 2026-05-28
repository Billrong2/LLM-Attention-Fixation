from __future__ import annotations

import re
from dataclasses import dataclass
from typing import Any, Dict, Iterable, List, Optional, Sequence, Tuple

try:
    from .prompt import artifact_name, disabled_prompt_metadata, render_artifact_conditioned_guidance
except ImportError:
    from prompt import artifact_name, disabled_prompt_metadata, render_artifact_conditioned_guidance


@dataclass(frozen=True)
class Element:
    kind: str
    line: Optional[int]
    description: str
    code: str = ""

    def label(self) -> str:
        if self.line is None or self.line <= 0:
            return self.kind
        return f"{self.kind} at L{self.line:03d}"

    def as_prompt_item(self) -> str:
        prefix = self.label()
        if self.code:
            return f"{prefix}: {self.description} ({self.code})"
        return f"{prefix}: {self.description}"

    def as_dict(self) -> Dict[str, Any]:
        return {
            "kind": self.kind,
            "line": self.line,
            "line_label": f"L{self.line:03d}" if self.line is not None and self.line > 0 else "",
            "description": self.description,
            "code": self.code,
        }


def _try_import_javalang():
    try:
        import javalang  # type: ignore

        return javalang
    except Exception:
        return None


def _clean_code_line(java_code: str, line: Optional[int]) -> str:
    if line is None or line <= 0:
        return ""
    lines = java_code.splitlines()
    if line > len(lines):
        return ""
    return " ".join(lines[line - 1].strip().split())


def _node_line(node: Any) -> Optional[int]:
    pos = getattr(node, "position", None)
    if pos is None:
        return None
    try:
        return int(pos.line)
    except Exception:
        try:
            return int(pos[0])
        except Exception:
            return None


def _walk(node: Any) -> Iterable[Any]:
    if node is None:
        return
    yield node
    for child in getattr(node, "children", ()) or ():
        if child is None:
            continue
        if isinstance(child, (list, tuple)):
            for item in child:
                yield from _walk(item)
        else:
            yield from _walk(child)


def _parse_tree(java_code: str) -> Tuple[Any, Any]:
    javalang = _try_import_javalang()
    if javalang is None:
        return None, None
    try:
        return javalang, javalang.parse.parse(java_code)
    except Exception:
        return javalang, None


def _target_method(tree: Any, javalang: Any, target_method_name: Optional[str]) -> Any:
    if tree is None or javalang is None:
        return None
    methods = [node for _path, node in tree.filter(javalang.tree.MethodDeclaration)]
    if target_method_name:
        for method in methods:
            if getattr(method, "name", "") == target_method_name:
                return method
    for method in methods:
        if getattr(method, "name", "") == "f":
            return method
    for method in methods:
        if getattr(method, "name", "") != "main":
            return method
    return methods[0] if methods else None


def _method_name(method: Any) -> str:
    return str(getattr(method, "name", "") or "")


def _method_params(method: Any) -> List[str]:
    out: List[str] = []
    for param in getattr(method, "parameters", []) or []:
        name = getattr(param, "name", "")
        if name:
            out.append(str(name))
    return out


def _dedupe(elements: Sequence[Element], limit: int = 24) -> List[Element]:
    out: List[Element] = []
    seen = set()
    for elem in elements:
        key = (elem.kind, elem.line, elem.description, elem.code)
        if key in seen:
            continue
        seen.add(key)
        out.append(elem)
        if len(out) >= limit:
            break
    return out


def _collect_names(node: Any, javalang: Any) -> List[str]:
    if node is None or javalang is None:
        return []
    names: List[str] = []
    for item in _walk(node):
        if isinstance(item, javalang.tree.MemberReference):
            member = getattr(item, "member", "")
            if member:
                names.append(str(member))
        elif isinstance(item, javalang.tree.MethodInvocation):
            qualifier = getattr(item, "qualifier", "")
            member = getattr(item, "member", "")
            if qualifier:
                names.append(str(qualifier))
            if member:
                names.append(str(member))
    out: List[str] = []
    seen = set()
    for name in names:
        if name not in seen:
            seen.add(name)
            out.append(name)
    return out


def _declared_names(node: Any, javalang: Any) -> List[str]:
    names: List[str] = []
    if javalang is not None and isinstance(node, javalang.tree.LocalVariableDeclaration):
        for decl in getattr(node, "declarators", []) or []:
            name = getattr(decl, "name", "")
            if name:
                names.append(str(name))
    return names


def _assignment_target(node: Any, javalang: Any) -> str:
    if javalang is None or not isinstance(node, javalang.tree.Assignment):
        return ""
    lhs = getattr(node, "expressionl", None)
    if isinstance(lhs, javalang.tree.MemberReference):
        return str(getattr(lhs, "member", "") or "")
    return str(getattr(lhs, "member", "") or getattr(lhs, "name", "") or "")


def _line_element(kind: str, line: Optional[int], description: str, java_code: str) -> Element:
    return Element(kind=kind, line=line, description=description, code=_clean_code_line(java_code, line))


def _fallback_elements(java_code: str, mode: str, target_method_name: Optional[str]) -> Dict[str, Any]:
    elements: List[Element] = []
    method_pat = re.compile(r"\b([A-Za-z_]\w*)\s*\([^;]*\)\s*\{")
    for idx, line in enumerate(java_code.splitlines(), start=1):
        stripped = line.strip()
        if not stripped:
            continue
        if target_method_name and target_method_name not in stripped and not elements:
            continue
        if method_pat.search(stripped) and not re.match(r"^(if|for|while|switch|catch)\b", stripped):
            elements.append(_line_element("MethodDeclaration", idx, "target method declaration", java_code))
        elif re.match(r"(if|else if)\b", stripped):
            elements.append(_line_element("IfStatement", idx, "static branch predicate", java_code))
        elif re.match(r"(for|while|do)\b", stripped):
            elements.append(_line_element("LoopStatement", idx, "static loop predicate or body entry", java_code))
        elif "return" in stripped:
            elements.append(_line_element("ReturnStatement", idx, "static return statement", java_code))
        elif "=" in stripped:
            elements.append(_line_element("AssignmentOrDefinition", idx, "static definition or update", java_code))
    return {
        "target_method": target_method_name or "",
        "parse_status": "fallback_regex",
        "elements": [elem.as_dict() for elem in _dedupe(elements)],
        "prompt_items": [elem.as_prompt_item() for elem in _dedupe(elements)],
    }


def extract_structural_elements(
    java_code: str,
    mode: str,
    *,
    target_method_name: Optional[str] = None,
    max_elements: int = 24,
) -> Dict[str, Any]:
    javalang, tree = _parse_tree(java_code)
    method = _target_method(tree, javalang, target_method_name)
    if javalang is None or tree is None or method is None:
        return _fallback_elements(java_code, mode, target_method_name)

    method_name = _method_name(method)
    params = _method_params(method)
    elements: List[Element] = [
        _line_element(
            "MethodDeclaration",
            _node_line(method),
            f"target method {method_name}({', '.join(params)})",
            java_code,
        )
    ]

    if mode == "ast":
        wanted = {
            "IfStatement",
            "WhileStatement",
            "ForStatement",
            "DoStatement",
            "SwitchStatement",
            "TryStatement",
            "MethodInvocation",
            "SuperMethodInvocation",
            "MemberReference",
            "Assignment",
            "ReturnStatement",
            "BinaryOperation",
            "UnaryOperation",
            "Cast",
            "InstanceOf",
            "Literal",
            "LocalVariableDeclaration",
        }
        for node in _walk(method):
            ntype = type(node).__name__
            if ntype not in wanted:
                continue
            line = _node_line(node)
            desc = ntype
            if ntype == "MethodInvocation":
                desc = f"method call {getattr(node, 'member', '')}"
            elif ntype == "MemberReference":
                desc = f"variable/member reference {getattr(node, 'member', '')}"
            elif ntype == "Assignment":
                desc = f"assignment/update to {_assignment_target(node, javalang) or 'a variable'}"
            elif ntype == "LocalVariableDeclaration":
                names = _declared_names(node, javalang)
                desc = f"local variable definition {', '.join(names)}" if names else "local variable definition"
            elif ntype == "BinaryOperation":
                desc = f"binary operation {getattr(node, 'operator', '')}"
            elif ntype == "Literal":
                desc = f"literal {getattr(node, 'value', '')}"
            elif ntype in {"IfStatement", "WhileStatement", "ForStatement", "DoStatement", "SwitchStatement"}:
                desc = f"control AST node {ntype}"
            elif ntype == "ReturnStatement":
                names = _collect_names(getattr(node, "expression", None), javalang)
                desc = f"return statement using {', '.join(names)}" if names else "return statement"
            elements.append(_line_element(ntype, line, desc, java_code))

    elif mode == "cfg":
        elements.append(Element("CFGEntry", _node_line(method), f"entry into {method_name}", _clean_code_line(java_code, _node_line(method))))
        body = list(getattr(method, "body", []) or [])
        previous_line: Optional[int] = _node_line(method)
        for stmt in body:
            ntype = type(stmt).__name__
            line = _node_line(stmt)
            if line is None:
                continue
            if ntype in {"IfStatement"}:
                elements.append(_line_element("CFGBranchPredicate", line, "branch predicate with true and false outgoing edges", java_code))
                then_stmt = getattr(stmt, "then_statement", None)
                else_stmt = getattr(stmt, "else_statement", None)
                then_line = _node_line(then_stmt)
                else_line = _node_line(else_stmt)
                if then_line:
                    elements.append(_line_element("CFGThenEdge", then_line, f"then-edge from L{line:03d}", java_code))
                if else_line:
                    elements.append(_line_element("CFGElseEdge", else_line, f"else-edge from L{line:03d}", java_code))
            elif ntype in {"ForStatement", "WhileStatement", "DoStatement"}:
                elements.append(_line_element("CFGLoopPredicate", line, "loop predicate with body edge and exit edge", java_code))
                body_line = _node_line(getattr(stmt, "body", None))
                if body_line:
                    elements.append(_line_element("CFGLoopBody", body_line, f"loop-body edge from L{line:03d}", java_code))
                elements.append(Element("CFGBackEdge", line, f"static back edge from loop body to L{line:03d}", _clean_code_line(java_code, line)))
            elif ntype == "ReturnStatement":
                elements.append(_line_element("CFGReturnExit", line, "return node and method exit", java_code))
            else:
                elements.append(_line_element("CFGSequentialStatement", line, "sequential CFG node", java_code))
            if previous_line and previous_line != line:
                elements.append(Element("CFGSequentialEdge", line, f"sequential edge from L{previous_line:03d} to L{line:03d}", _clean_code_line(java_code, line)))
            previous_line = line
        elements.append(Element("CFGExit", previous_line, f"exit from {method_name}", _clean_code_line(java_code, previous_line)))

    elif mode == "slice":
        for param in params:
            elements.append(Element("SliceMethodParameter", _node_line(method), f"method parameter {param}", _clean_code_line(java_code, _node_line(method))))

        return_nodes = [node for node in _walk(method) if isinstance(node, javalang.tree.ReturnStatement)]
        return_names: List[str] = []
        for ret in return_nodes:
            names = _collect_names(getattr(ret, "expression", None), javalang)
            return_names.extend(names)
            desc = f"return value expression using {', '.join(names)}" if names else "return value expression"
            elements.append(_line_element("SliceReturnValue", _node_line(ret), desc, java_code))
        return_name_set = {name for name in return_names if name}

        for node in _walk(method):
            ntype = type(node).__name__
            line = _node_line(node)
            if ntype == "LocalVariableDeclaration":
                names = _declared_names(node, javalang)
                if not return_name_set or return_name_set.intersection(names):
                    elements.append(_line_element("SliceDefinition", line, f"definition of {', '.join(names) or 'a local value'}", java_code))
            elif ntype == "Assignment":
                target = _assignment_target(node, javalang)
                if not return_name_set or target in return_name_set:
                    elements.append(_line_element("SliceAssignment", line, f"assignment/update influencing {target or 'a sliced value'}", java_code))
            elif ntype in {"IfStatement", "WhileStatement", "ForStatement", "DoStatement", "SwitchStatement"}:
                names = _collect_names(node, javalang)
                desc = f"control predicate over {', '.join(names)}" if names else "control predicate"
                elements.append(_line_element("SliceControlDependency", line, desc, java_code))
            elif ntype == "MethodInvocation":
                member = str(getattr(node, "member", "") or "")
                qualifier = str(getattr(node, "qualifier", "") or "")
                desc = f"method call {qualifier + '.' if qualifier else ''}{member} in static data/control context"
                elements.append(_line_element("SliceMethodCall", line, desc, java_code))

    deduped = _dedupe(elements, limit=max_elements)
    return {
        "target_method": method_name,
        "parse_status": "javalang",
        "mode": mode,
        "elements": [elem.as_dict() for elem in deduped],
        "prompt_items": [elem.as_prompt_item() for elem in deduped],
    }


def build_artifact_conditioned_instruction(
    base_instruction: str,
    mode: str,
    *,
    java_code: str,
    task: str,
    target_method_name: Optional[str] = None,
    max_elements: int = 24,
) -> Tuple[str, Dict[str, Any]]:
    if mode == "none":
        return base_instruction, disabled_prompt_metadata(mode, target_method_name or "")

    structural = extract_structural_elements(
        java_code,
        mode,
        target_method_name=target_method_name,
        max_elements=max_elements,
    )
    items = structural.get("prompt_items", []) or []
    artifact = artifact_name(mode)
    guidance = render_artifact_conditioned_guidance(mode=mode, prompt_items=items, task=task)
    meta = {
        "enabled": True,
        "mode": mode,
        "artifact_name": artifact,
        "target_method": structural.get("target_method", target_method_name or ""),
        "parse_status": structural.get("parse_status", ""),
        "elements": structural.get("elements", []),
        "prompt_items": items,
        "guidance_text": guidance,
        "mechanism": "artifact_conditioned_natural_language_instruction_only",
    }
    return guidance + "\n\n" + base_instruction, meta
