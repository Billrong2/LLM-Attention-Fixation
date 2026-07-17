#!/usr/bin/env bash
set -euo pipefail

PROMPT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="${PROJECT_ROOT:-$(cd "${PROMPT_ROOT}/.." && pwd)}"
PYTHON_BIN="${PYTHON_BIN:-python3}"
ARTIFACT_ROOT="${ARTIFACT_ROOT:-${PROMPT_ROOT}/artifacts}"
RUN_TAG="${RUN_TAG:-prompt-slice-final-20260711}"
SOURCE_BASE="${SOURCE_BASE:-${PROJECT_ROOT}/Rebuttal/artifacts/obfuscation/source}"
RUNS="${RUNS:-3}"
TEMPERATURE="${TEMPERATURE:-0.9}"
TOP_P="${TOP_P:-0.95}"
BASE_SEED="${BASE_SEED:-20260527}"
MAX_NEW_TOKENS="${MAX_NEW_TOKENS:-512}"
MAX_STRUCTURAL_ELEMENTS="${MAX_STRUCTURAL_ELEMENTS:-24}"
OFFLINE="${OFFLINE:-off}"
RESUME="${RESUME:-on}"
GPU_IDS="${GPU_IDS:-}"
JAVA_HOME_OVERRIDE="${PROMPT_JAVA_HOME:-${JAVA_HOME:-}}"
SHARD_INDEX="${SHARD_INDEX:-}"
NUM_SHARDS="${NUM_SHARDS:-1}"
SNIPPETS="${SNIPPETS:-}"
DRY_RUN="${DRY_RUN:-off}"

if [[ "${RUNS}" != "3" ]]; then
  printf 'Table 2 requires exactly three trials; got RUNS=%s\n' "${RUNS}" >&2
  exit 2
fi

dataset_source_root() {
  local dataset="$1"
  printf '%s/%s/java\n' "${SOURCE_BASE}" "${dataset}"
}

dataset_snippets() {
  local dataset="$1"
  if [[ -n "${SNIPPETS}" ]]; then
    printf '%s\n' "${SNIPPETS}"
  elif [[ -n "${SHARD_INDEX}" ]]; then
    "${PYTHON_BIN}" "${PROMPT_ROOT}/split_snippets.py" \
      --project-root "${PROJECT_ROOT}" \
      --dataset "${dataset}" \
      --shard-index "${SHARD_INDEX}" \
      --num-shards "${NUM_SHARDS}"
  fi
}

run_row() {
  local model_name="$1"
  local dataset="$2"
  local cache_dir="$3"
  local trust_remote_code="$4"
  local source_root
  local snippets
  local args

  source_root="$(dataset_source_root "${dataset}")"
  if [[ ! -d "${source_root}" ]]; then
    printf 'Missing prepared source corpus: %s\n' "${source_root}" >&2
    exit 2
  fi
  snippets="$(dataset_snippets "${dataset}")"
  args=(
    --project-root "${PROJECT_ROOT}"
    --output-root "${ARTIFACT_ROOT}"
    --dataset "${dataset}"
    --source-kind obfuscated
    --source-root "${source_root}"
    --techniques identifier_renaming,bogus_control_flow,control_flow_flattening,call_indirection
    --tiers easy
    --prompt-steering slice
    --model-name "${model_name}"
    --runs-per-snippet "${RUNS}"
    --max-new-tokens "${MAX_NEW_TOKENS}"
    --temperature "${TEMPERATURE}"
    --top-p "${TOP_P}"
    --base-seed "${BASE_SEED}"
    --max-structural-elements "${MAX_STRUCTURAL_ELEMENTS}"
    --record-layers off
    --offline "${OFFLINE}"
    --run-tag "${RUN_TAG}"
    --resume "${RESUME}"
  )
  [[ -n "${cache_dir}" ]] && args+=(--cache-dir "${cache_dir}")
  [[ -n "${JAVA_HOME_OVERRIDE}" ]] && args+=(--java-home "${JAVA_HOME_OVERRIDE}")
  [[ -n "${GPU_IDS}" ]] && args+=(--gpu-ids "${GPU_IDS}")
  [[ -n "${snippets}" ]] && args+=(--snippets "${snippets}")
  [[ "${DRY_RUN}" == "on" ]] && args+=(--dry-run)

  printf 'Running %s on %s\n' "${model_name}" "${dataset}"
  LLM_TRUST_REMOTE_CODE="${trust_remote_code}" \
    "${PYTHON_BIN}" "${PROMPT_ROOT}/run_element_prompt_steering_output.py" "${args[@]}"
}

# These are the six reported Table 2 Prompt rows. The Qwen2.5-7B/CruxEval and
# DeepSeek-6.7B/CruxEval rows are intentionally excluded.
run_row Qwen/Qwen2.5-Coder-7B-Instruct humaneval "${QWEN7_CACHE_DIR:-${CACHE_DIR:-}}" 0
run_row deepseek-ai/deepseek-coder-6.7b-base humaneval "${DEEPSEEK67_CACHE_DIR:-${CACHE_DIR:-}}" 0
run_row Qwen/Qwen2.5-14B humaneval "${QWEN14_CACHE_DIR:-${CACHE_DIR:-}}" 0
run_row Qwen/Qwen2.5-14B cruxeval "${QWEN14_CACHE_DIR:-${CACHE_DIR:-}}" 0
run_row deepseek-ai/DeepSeek-V2-Lite humaneval "${DEEPSEEK_V2_CACHE_DIR:-${CACHE_DIR:-}}" 1
run_row deepseek-ai/DeepSeek-V2-Lite cruxeval "${DEEPSEEK_V2_CACHE_DIR:-${CACHE_DIR:-}}" 1

if [[ "${DRY_RUN}" == "off" && -z "${SHARD_INDEX}" && -z "${SNIPPETS}" ]]; then
  "${PYTHON_BIN}" "${PROMPT_ROOT}/export_prompt_results.py" \
    --project-root "${PROJECT_ROOT}" \
    --artifact-root "${ARTIFACT_ROOT}"
  "${PYTHON_BIN}" "${PROMPT_ROOT}/evaluate_prompt_results.py"
else
  printf 'Skipped final export/evaluation for a dry run or partial shard.\n'
fi
