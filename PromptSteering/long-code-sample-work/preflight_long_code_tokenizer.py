#!/usr/bin/env python3
"""Tokenizer-only CodeSteer preflight for the long-code experiment.

This program deliberately loads only the immutable Qwen/Qwen2.5-14B tokenizer.
It expands the prepared variant manifest with the experiment runner, rebuilds the
exact CodeSteer prompt for every concrete case, and applies the same runtime
SlicingPrior-versus-positional-fallback check used immediately before inference.

All files created by this program are constrained to ``long-code-sample-work``.
The source manifest and cached tokenizer are read-only inputs.
"""

from __future__ import annotations

import argparse
import copy
import hashlib
import importlib.metadata
import json
import os
import platform
import sys
import tempfile
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Dict, List, Mapping, Optional, Sequence, Tuple


WORK_ROOT = Path(__file__).resolve().parent
PROJECT_ROOT = WORK_ROOT.parents[1]
DEFAULT_MANIFEST = WORK_ROOT / "prepared_variants" / "eligible_variants.json"
DEFAULT_OUTPUT_DIR = WORK_ROOT / "tokenizer_preflight"
DEFAULT_MODEL_NAME = "Qwen/Qwen2.5-14B"
DEFAULT_CACHE_DIR = Path("/data/xxr230000/model_cache")
MODEL_SNAPSHOT_COMMIT = "97e1e76335b7017d8f67c08a19d103c0504298c9"
SCHEMA_VERSION = "long-code-tokenizer-preflight-v1"
N_BINS = 12
MAX_NEW_TOKENS = 512
EXPECTED_DENOMINATOR = 25
EXPECTED_INFERENCE_ELIGIBLE = 23


def _utc_now() -> str:
    return datetime.now(timezone.utc).isoformat()


def _sha256_bytes(payload: bytes) -> str:
    return hashlib.sha256(payload).hexdigest()


def sha256_file(path: Path) -> str:
    return _sha256_bytes(path.read_bytes())


def _package_version(name: str) -> Optional[str]:
    try:
        return importlib.metadata.version(name)
    except importlib.metadata.PackageNotFoundError:
        return None


def _stable_json(payload: Any) -> str:
    return json.dumps(payload, ensure_ascii=False, sort_keys=True, separators=(",", ":"))


def ensure_output_dir(path: Path) -> Path:
    """Return an absolute output directory, rejecting symlink/path escapes."""
    resolved = path.expanduser().resolve()
    try:
        resolved.relative_to(WORK_ROOT)
    except ValueError as exc:
        raise ValueError(
            f"Output directory must remain below {WORK_ROOT}; received {resolved}."
        ) from exc
    return resolved


def _atomic_write_text(path: Path, text: str) -> None:
    output_dir = ensure_output_dir(path.parent)
    output_dir.mkdir(parents=True, exist_ok=True)
    fd, raw_temp = tempfile.mkstemp(prefix=f".{path.name}.", suffix=".tmp", dir=output_dir)
    temp_path = Path(raw_temp)
    try:
        with os.fdopen(fd, "w", encoding="utf-8", newline="") as handle:
            handle.write(text)
            handle.flush()
            os.fsync(handle.fileno())
        os.replace(temp_path, path)
    finally:
        if temp_path.exists():
            temp_path.unlink()


def _atomic_write_json(path: Path, payload: Any) -> None:
    _atomic_write_text(path, json.dumps(payload, ensure_ascii=False, indent=2, sort_keys=True) + "\n")


def _load_experiment_runner() -> Any:
    if str(WORK_ROOT) not in sys.path:
        sys.path.insert(0, str(WORK_ROOT))
    if str(PROJECT_ROOT) not in sys.path:
        sys.path.insert(0, str(PROJECT_ROOT))
    import run_long_code_experiment

    return run_long_code_experiment


def _model_cache_name(model_name: str) -> str:
    return "models--" + model_name.replace("/", "--")


def resolve_cached_snapshot(cache_dir: Path, model_name: str, revision: str) -> Path:
    """Resolve an exact local snapshot without contacting the Hugging Face Hub."""
    roots = (
        cache_dir / _model_cache_name(model_name),
        cache_dir / "hub" / _model_cache_name(model_name),
    )
    for root in roots:
        candidate = root / "snapshots" / revision
        if candidate.is_dir():
            return candidate.resolve()
    rendered = ", ".join(str(root / "snapshots" / revision) for root in roots)
    raise FileNotFoundError(f"Cached tokenizer snapshot {revision} was not found at: {rendered}")


def load_offline_tokenizer(snapshot_dir: Path) -> Any:
    """Load the tokenizer only; no AutoModel class is referenced or instantiated."""
    os.environ["HF_HUB_OFFLINE"] = "1"
    os.environ["TRANSFORMERS_OFFLINE"] = "1"
    from transformers import AutoTokenizer

    tokenizer = AutoTokenizer.from_pretrained(
        str(snapshot_dir),
        local_files_only=True,
        trust_remote_code=False,
    )
    tokenizer.padding_side = "left"
    if tokenizer.pad_token is None:
        tokenizer.pad_token = tokenizer.eos_token
        tokenizer.pad_token_id = tokenizer.eos_token_id
    return tokenizer


class TokenizerOnlyRunner:
    """Minimal runner interface consumed by the experiment's preflight helpers."""

    def __init__(self, tokenizer: Any, prompt_builder: Optional[Any] = None) -> None:
        self.tokenizer = tokenizer
        self.model = None
        if prompt_builder is None:
            # Importing this class does not construct or load a language model.  Using
            # its static method prevents prompt-template drift from the inference path.
            from models import SteeredCausalLM

            prompt_builder = SteeredCausalLM._build_prompt
        self._prompt_builder = prompt_builder

    def _build_prompt(
        self,
        code_snippet: str,
        *,
        instruction: str,
        language: str,
        answer_prefix: str = "",
    ) -> str:
        return self._prompt_builder(
            code_snippet,
            instruction=instruction,
            language=language,
            answer_prefix=answer_prefix,
        )


def _flatten_ids(encoded: Any) -> List[int]:
    ids = encoded.get("input_ids", []) if isinstance(encoded, dict) else getattr(encoded, "input_ids", [])
    if hasattr(ids, "tolist"):
        ids = ids.tolist()
    if ids and isinstance(ids[0], list):
        ids = ids[0]
    return [int(value) for value in ids]


def _float_vector_summary(vector: Any) -> Dict[str, Any]:
    import numpy as np

    array = np.asarray(vector, dtype=np.float64).reshape(-1)
    canonical = array.astype("<f8", copy=False).tobytes(order="C")
    if array.size:
        minimum = float(array.min())
        maximum = float(array.max())
        total = float(array.sum())
        nonzero = int(np.count_nonzero(array))
    else:
        minimum = maximum = total = None
        nonzero = 0
    return {
        "dtype_for_sha256": "little-endian-float64",
        "length": int(array.size),
        "nonzero_count": nonzero,
        "sum": total,
        "min": minimum,
        "max": maximum,
        "sha256": _sha256_bytes(canonical),
    }


def _vector_comparison(actual: Any, positional: Any) -> Dict[str, Any]:
    import numpy as np

    lhs = np.asarray(actual, dtype=np.float64).reshape(-1)
    rhs = np.asarray(positional, dtype=np.float64).reshape(-1)
    same_shape = lhs.shape == rhs.shape
    allclose = bool(same_shape and np.allclose(lhs, rhs, rtol=1e-7, atol=1e-10))
    if not same_shape:
        return {
            "same_shape": False,
            "allclose": False,
            "rtol": 1e-7,
            "atol": 1e-10,
            "l1_distance": None,
            "linf_distance": None,
            "cosine_similarity": None,
        }
    delta = np.abs(lhs - rhs)
    lhs_norm = float(np.linalg.norm(lhs))
    rhs_norm = float(np.linalg.norm(rhs))
    cosine = None
    if lhs_norm > 0.0 and rhs_norm > 0.0:
        cosine = float(np.dot(lhs, rhs) / (lhs_norm * rhs_norm))
    return {
        "same_shape": True,
        "allclose": allclose,
        "rtol": 1e-7,
        "atol": 1e-10,
        "l1_distance": float(delta.sum()),
        "linf_distance": float(delta.max()) if delta.size else 0.0,
        "cosine_similarity": cosine,
    }


def _identity(sample: Any) -> Tuple[str, Optional[str]]:
    metadata = sample.metadata
    parent = str(
        metadata.get("parent_candidate_id")
        or metadata.get("variant_id")
        or metadata.get("id")
        or sample.sample_id
    )
    concrete = metadata.get("concrete_case")
    case_id: Optional[str] = None
    if isinstance(concrete, Mapping):
        raw_case = concrete.get("case_id") or concrete.get("id") or concrete.get("name")
        if raw_case is not None:
            case_id = str(raw_case)
    return parent, case_id


def _relative_to_work(path: Path) -> str:
    resolved = path.resolve()
    try:
        return str(resolved.relative_to(WORK_ROOT))
    except ValueError:
        return str(resolved)


def evaluate_sample(
    sample: Any,
    tokenizer_runner: TokenizerOnlyRunner,
    experiment: Any,
    *,
    denominator_index: int,
) -> Dict[str, Any]:
    """Evaluate one already-exploded sample with the exact inference preflight."""
    from steering.priors import PriorContext, SlicingHybridPrior, SlicingPrior

    parent_id, case_id = _identity(sample)
    conditions, prompt_slice_metadata = experiment.prepare_conditions(sample)
    condition = next(entry for entry in conditions if entry.name == "obfuscated_codesteer")
    obfuscated_plain = next(entry for entry in conditions if entry.name == "obfuscated_plain")

    prompt = tokenizer_runner._build_prompt(
        condition.source_code,
        instruction=condition.instruction,
        language="java",
        answer_prefix="",
    )
    encoded = tokenizer_runner.tokenizer(prompt, add_special_tokens=True)
    ids = _flatten_ids(encoded)
    prompt_tokens = list(tokenizer_runner.tokenizer.convert_ids_to_tokens(ids))
    context = PriorContext(
        prompt_tokens=prompt_tokens,
        code_text=condition.source_code,
        vocab_tokens=[],
        prompt_text=prompt,
    )

    algorithm_prior = SlicingPrior(context)
    actual = algorithm_prior.vector(0, N_BINS)
    positional = algorithm_prior._normalize(algorithm_prior._fallback_chunk(0, N_BINS))
    comparison = _vector_comparison(actual, positional)
    hybrid = SlicingHybridPrior(context)
    hybrid_vector = hybrid.vector(0, N_BINS)
    case_ids = list(getattr(hybrid, "_case_ids", []) or [])
    case_vectors = list(getattr(hybrid, "_case_vectors", []) or [])

    # Run the same public helpers called by inference, then prove that this
    # standalone report agrees with their exact pass/fail signals.
    runtime_preflight = experiment.codesteer_prior_preflight(tokenizer_runner, condition)
    token_preflight = experiment.prompt_token_preflight(
        tokenizer_runner,
        condition,
        max_new_tokens=MAX_NEW_TOKENS,
    )
    if bool(runtime_preflight["algorithm_fallback_detected"]) != bool(comparison["allclose"]):
        raise RuntimeError("Standalone vector comparison disagrees with inference preflight.")
    if bool(runtime_preflight["case_signal_active"]) != bool(case_ids):
        raise RuntimeError("Standalone CASES activation disagrees with inference preflight.")
    if runtime_preflight["prompt_sha256"] != _sha256_bytes(prompt.encode("utf-8")):
        raise RuntimeError("Prompt hash drift detected between standalone and inference preflight.")

    reasons: List[str] = []
    if comparison["allclose"]:
        reasons.append("algorithm_prior_matches_normalized_positional_fallback")
    if not case_ids:
        reasons.append("slice_hybrid_cases_signal_inactive")
    if not bool(token_preflight["fits_context"]):
        reasons.append("prompt_plus_generation_exceeds_model_context")
    inference_eligible = not reasons

    case_vector_summaries = [_float_vector_summary(vector) for vector in case_vectors]
    case_markers = {
        "cases_begin_present": "### CASES_BEGIN" in prompt,
        "cases_end_present": "### CASES_END" in prompt,
        "c001_spec_present": "c001:" in prompt,
    }
    token_payload = _stable_json(prompt_tokens).encode("utf-8")
    id_payload = _stable_json(ids).encode("utf-8")
    return {
        "denominator_index": denominator_index,
        "sample_id": sample.sample_id,
        "parent_variant_id": parent_id,
        "case_id": case_id,
        "decision": {
            "inference_eligible": inference_eligible,
            "exclusion_reasons": reasons,
        },
        "inputs": {
            "original_path": _relative_to_work(sample.original_path),
            "obfuscated_path": _relative_to_work(sample.obfuscated_path),
            "original_target_method": sample.original_target_method,
            "obfuscated_target_method": sample.obfuscated_target_method,
        },
        "prompt": {
            "text": prompt,
            "sha256": _sha256_bytes(prompt.encode("utf-8")),
            "token_count": len(ids),
            "token_ids_sha256": _sha256_bytes(id_payload),
            "token_strings_sha256": _sha256_bytes(token_payload),
            "markers": case_markers,
            "codesteer_instruction_equals_obfuscated_plain": (
                condition.instruction == obfuscated_plain.instruction
            ),
            "token_preflight": token_preflight,
        },
        "slicing_prior": {
            "bin_index": 0,
            "n_bins": N_BINS,
            "actual": _float_vector_summary(actual),
            "normalized_positional_fallback": _float_vector_summary(positional),
            "comparison": comparison,
            "algorithm_fallback_detected": bool(comparison["allclose"]),
        },
        "slice_hybrid": {
            "case_signal_active": bool(case_ids),
            "parsed_case_ids": case_ids,
            "case_vector_count": len(case_vectors),
            "case_vectors": case_vector_summaries,
            "hybrid_vector": _float_vector_summary(hybrid_vector),
            "weights": {
                "baseline": float(hybrid.baseline_weight),
                "algorithm": float(hybrid.alg_weight),
                "case": float(hybrid.case_weight),
            },
        },
        "inference_helper_result": runtime_preflight,
        "prompt_slice_metadata": {
            "target_method": prompt_slice_metadata.get("target_method"),
            "recorded_target_method": prompt_slice_metadata.get("recorded_target_method"),
            "eligible_element_count": prompt_slice_metadata.get("eligible_element_count"),
            "emitted_element_count": prompt_slice_metadata.get("emitted_element_count"),
        },
    }


def _collection(payload: Mapping[str, Any]) -> Tuple[str, List[Any]]:
    for key in ("samples", "variants", "cases", "items"):
        value = payload.get(key)
        if isinstance(value, list):
            return key, value
    raise ValueError("Manifest must contain samples, variants, cases, or items as a list.")


def _pick_id(row: Mapping[str, Any], fallback: str) -> str:
    for key in ("id", "sample_id", "variant_id", "candidate_id", "name"):
        value = row.get(key)
        if value is not None and str(value):
            return str(value)
    return fallback


def _pick_case_id(row: Mapping[str, Any], fallback: str) -> str:
    value = row.get("case_id")
    if value is not None and str(value):
        return str(value)
    return _pick_id(row, fallback)


def filter_manifest_to_passing(
    source_payload: Mapping[str, Any],
    records: Sequence[Mapping[str, Any]],
) -> Dict[str, Any]:
    """Retain only passing parents and passing concrete cases within them."""
    collection_key, rows = _collection(source_payload)
    passing_pairs = {
        (str(record["parent_variant_id"]), record.get("case_id"))
        for record in records
        if bool(record.get("decision", {}).get("inference_eligible"))
    }
    passing_samples = {
        str(record["sample_id"])
        for record in records
        if bool(record.get("decision", {}).get("inference_eligible"))
    }
    retained: List[Any] = []
    for index, raw_row in enumerate(rows, start=1):
        if not isinstance(raw_row, Mapping):
            continue
        parent_id = _pick_id(raw_row, f"sample_{index:02d}")
        row = copy.deepcopy(dict(raw_row))
        cases = row.get("cases")
        if isinstance(cases, list) and cases:
            kept_cases = []
            for case_index, case in enumerate(cases, start=1):
                if not isinstance(case, Mapping):
                    continue
                case_id = _pick_case_id(case, f"c{case_index:03d}")
                if (parent_id, case_id) in passing_pairs:
                    kept_cases.append(case)
            if kept_cases:
                row["cases"] = kept_cases
                retained.append(row)
        elif parent_id in passing_samples or (parent_id, None) in passing_pairs:
            retained.append(row)

    filtered = copy.deepcopy(dict(source_payload))
    filtered[collection_key] = retained
    for count_key in ("variant_count", "sample_count", "item_count"):
        if count_key in filtered:
            filtered[count_key] = len(retained)
    if "case_count" in filtered:
        filtered["case_count"] = sum(
            len(row.get("cases", []))
            if isinstance(row, Mapping) and isinstance(row.get("cases"), list)
            else 1
            for row in retained
        )
    if "state" in filtered:
        filtered["state"] = "exact_tokenizer_gate_passed"
    filtered["selection_stage"] = "tokenizer_exact_prior_preflight"
    filtered["tokenizer_preflight"] = {
        "schema_version": SCHEMA_VERSION,
        "input_top_level_count": len(rows),
        "retained_top_level_count": len(retained),
        "retained_exploded_sample_count": len(passing_samples),
        "selection_rule": (
            "Retain only cases whose exact Qwen2.5-14B-tokenized CodeSteer prompt yields "
            "a non-positional SlicingPrior vector, an active CASES signal, and fits context."
        ),
        "full_report": "full_report.json",
        "exclusions": "exclusions.jsonl",
    }
    return filtered


def _looks_like_relative_path(key: str, value: str) -> bool:
    if not value or value.startswith(("http://", "https://", "hf://", "<")):
        return False
    candidate = Path(value)
    if candidate.is_absolute():
        return False
    return key == "path" or key.endswith("_path") or key in {
        "original_path",
        "obfuscated_path",
        "source_path",
    }


def rebase_existing_manifest_paths(
    value: Any,
    *,
    source_dir: Path,
    output_dir: Path,
    parent_key: str = "",
) -> Any:
    """Rebase existing relative files so the filtered manifest remains runnable."""
    if isinstance(value, dict):
        return {
            key: rebase_existing_manifest_paths(
                child,
                source_dir=source_dir,
                output_dir=output_dir,
                parent_key=str(key),
            )
            for key, child in value.items()
        }
    if isinstance(value, list):
        if parent_key == "classpath":
            rendered = []
            for child in value:
                if isinstance(child, str) and not Path(child).is_absolute():
                    source_path = (source_dir / child).resolve()
                    if source_path.exists():
                        rendered.append(os.path.relpath(source_path, output_dir))
                        continue
                rendered.append(child)
            return rendered
        return [
            rebase_existing_manifest_paths(
                child,
                source_dir=source_dir,
                output_dir=output_dir,
                parent_key=parent_key,
            )
            for child in value
        ]
    if isinstance(value, str) and _looks_like_relative_path(parent_key, value):
        source_path = (source_dir / value).resolve()
        if source_path.exists():
            return os.path.relpath(source_path, output_dir)
    return value


def tokenizer_provenance(
    tokenizer: Any,
    snapshot_dir: Path,
    model_name: str,
    snapshot_commit: str,
) -> Dict[str, Any]:
    files: Dict[str, Dict[str, Any]] = {}
    for name in ("tokenizer.json", "tokenizer_config.json", "vocab.json", "merges.txt", "config.json"):
        path = snapshot_dir / name
        if path.is_file():
            files[name] = {
                "sha256": sha256_file(path),
                "bytes": path.stat().st_size,
            }
    return {
        "model_id": model_name,
        "snapshot_commit": snapshot_commit,
        "snapshot_dir_read_only_input": str(snapshot_dir),
        "tokenizer_class": type(tokenizer).__name__,
        "vocab_size": int(len(tokenizer)),
        "model_max_length": getattr(tokenizer, "model_max_length", None),
        "padding_side": getattr(tokenizer, "padding_side", None),
        "files": files,
        "offline_environment": {
            "HF_HUB_OFFLINE": os.environ.get("HF_HUB_OFFLINE"),
            "TRANSFORMERS_OFFLINE": os.environ.get("TRANSFORMERS_OFFLINE"),
        },
        "model_weights_loaded": False,
    }


def run_preflight(
    *,
    manifest_path: Path,
    output_dir: Path,
    cache_dir: Path = DEFAULT_CACHE_DIR,
    model_name: str = DEFAULT_MODEL_NAME,
    snapshot_commit: str = MODEL_SNAPSHOT_COMMIT,
    expected_denominator: Optional[int] = EXPECTED_DENOMINATOR,
    expected_eligible: Optional[int] = EXPECTED_INFERENCE_ELIGIBLE,
    tokenizer: Optional[Any] = None,
    prompt_builder: Optional[Any] = None,
) -> Dict[str, Any]:
    output_dir = ensure_output_dir(output_dir)
    manifest_path = manifest_path.expanduser().resolve()
    source_payload = json.loads(manifest_path.read_text(encoding="utf-8"))
    if not isinstance(source_payload, dict):
        raise TypeError("Prepared variants manifest root must be an object.")

    experiment = _load_experiment_runner()
    samples, manifest_metadata = experiment.load_manifest(manifest_path)
    snapshot_dir = resolve_cached_snapshot(cache_dir, model_name, snapshot_commit)
    if tokenizer is None:
        tokenizer = load_offline_tokenizer(snapshot_dir)
    tokenizer_runner = TokenizerOnlyRunner(tokenizer, prompt_builder=prompt_builder)

    records: List[Dict[str, Any]] = []
    for index, sample in enumerate(samples, start=1):
        parent_id, case_id = _identity(sample)
        try:
            record = evaluate_sample(
                sample,
                tokenizer_runner,
                experiment,
                denominator_index=index,
            )
        except Exception as exc:
            record = {
                "denominator_index": index,
                "sample_id": sample.sample_id,
                "parent_variant_id": parent_id,
                "case_id": case_id,
                "decision": {
                    "inference_eligible": False,
                    "exclusion_reasons": ["preflight_error"],
                },
                "error": {
                    "type": type(exc).__name__,
                    "message": str(exc),
                },
            }
        records.append(record)

    passing = [record for record in records if record["decision"]["inference_eligible"]]
    excluded = [record for record in records if not record["decision"]["inference_eligible"]]
    errors = [record for record in excluded if "error" in record]
    collection_key, source_rows = _collection(source_payload)
    counts = {
        "input_top_level_variants": len(source_rows),
        "exploded_denominator_records": len(records),
        "inference_eligible_records": len(passing),
        "excluded_records": len(excluded),
        "preflight_error_records": len(errors),
    }

    report = {
        "schema_version": SCHEMA_VERSION,
        "generated_at_utc": _utc_now(),
        "purpose": (
            "Tokenizer-exact inference gate for the prepared long-code CodeSteer variants; "
            "all denominator records are retained here regardless of decision."
        ),
        "source_manifest": {
            "path": _relative_to_work(manifest_path),
            "sha256": sha256_file(manifest_path),
            "collection_key": collection_key,
            "metadata": manifest_metadata,
        },
        "tokenizer": tokenizer_provenance(
            tokenizer,
            snapshot_dir,
            model_name,
            snapshot_commit,
        ),
        "policy": {
            "n_bins": N_BINS,
            "checked_bin_index": 0,
            "allclose_rtol": 1e-7,
            "allclose_atol": 1e-10,
            "required": [
                "SlicingPrior vector does not match normalized positional fallback",
                "SlicingHybridPrior parses at least one CASES case vector",
                f"prompt plus {MAX_NEW_TOKENS} generated tokens fits context",
            ],
            "expected_denominator": expected_denominator,
            "expected_inference_eligible": expected_eligible,
        },
        "software": {
            "python": platform.python_version(),
            "numpy": _package_version("numpy"),
            "transformers": _package_version("transformers"),
            "tokenizers": _package_version("tokenizers"),
            "javalang": _package_version("javalang"),
        },
        "counts": counts,
        "records": records,
    }

    filtered = filter_manifest_to_passing(source_payload, records)
    filtered = rebase_existing_manifest_paths(
        filtered,
        source_dir=manifest_path.parent,
        output_dir=output_dir,
    )
    filtered["tokenizer_preflight"]["source_manifest"] = os.path.relpath(manifest_path, output_dir)
    filtered["tokenizer_preflight"]["source_manifest_sha256"] = sha256_file(manifest_path)

    exclusion_lines = []
    for record in excluded:
        exclusion_lines.append(
            _stable_json(
                {
                    "schema_version": SCHEMA_VERSION,
                    "denominator_index": record["denominator_index"],
                    "sample_id": record["sample_id"],
                    "parent_variant_id": record["parent_variant_id"],
                    "case_id": record.get("case_id"),
                    "inference_eligible": False,
                    "exclusion_reasons": record["decision"]["exclusion_reasons"],
                    "algorithm_fallback_detected": record.get("slicing_prior", {}).get(
                        "algorithm_fallback_detected"
                    ),
                    "case_signal_active": record.get("slice_hybrid", {}).get("case_signal_active"),
                    "error": record.get("error"),
                }
            )
        )

    output_dir.mkdir(parents=True, exist_ok=True)
    _atomic_write_json(output_dir / "full_report.json", report)
    _atomic_write_json(output_dir / "inference_eligible_variants.json", filtered)
    _atomic_write_text(
        output_dir / "exclusions.jsonl",
        ("\n".join(exclusion_lines) + "\n") if exclusion_lines else "",
    )

    mismatches: List[str] = []
    if expected_denominator is not None and len(records) != expected_denominator:
        mismatches.append(f"denominator={len(records)} expected={expected_denominator}")
    if expected_eligible is not None and len(passing) != expected_eligible:
        mismatches.append(f"eligible={len(passing)} expected={expected_eligible}")
    if errors:
        mismatches.append(f"preflight_errors={len(errors)} expected=0")
    return {
        "output_dir": str(output_dir),
        "counts": counts,
        "count_mismatches": mismatches,
        "excluded_sample_ids": [record["sample_id"] for record in excluded],
    }


def parse_args(argv: Optional[Sequence[str]] = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--manifest", type=Path, default=DEFAULT_MANIFEST)
    parser.add_argument("--output-dir", type=Path, default=DEFAULT_OUTPUT_DIR)
    parser.add_argument("--cache-dir", type=Path, default=DEFAULT_CACHE_DIR)
    parser.add_argument("--model-name", default=DEFAULT_MODEL_NAME)
    parser.add_argument("--snapshot-commit", default=MODEL_SNAPSHOT_COMMIT)
    parser.add_argument("--expect-denominator", type=int, default=EXPECTED_DENOMINATOR)
    parser.add_argument("--expect-eligible", type=int, default=EXPECTED_INFERENCE_ELIGIBLE)
    return parser.parse_args(argv)


def main(argv: Optional[Sequence[str]] = None) -> int:
    args = parse_args(argv)
    result = run_preflight(
        manifest_path=args.manifest,
        output_dir=args.output_dir,
        cache_dir=args.cache_dir,
        model_name=args.model_name,
        snapshot_commit=args.snapshot_commit,
        expected_denominator=args.expect_denominator,
        expected_eligible=args.expect_eligible,
    )
    print(json.dumps(result, ensure_ascii=False, indent=2, sort_keys=True))
    return 2 if result["count_mismatches"] else 0


if __name__ == "__main__":
    raise SystemExit(main())
