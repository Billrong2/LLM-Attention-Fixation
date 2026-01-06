#!/usr/bin/env bash
set -euo pipefail

SCRIPT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_ROOT/.." && pwd)"
cd "$PROJECT_ROOT"

MAX_JOBS="${MAX_JOBS:-8}"
JOBS=()

run_job() {
  "$@" &
  JOBS+=($!)
  if (( ${#JOBS[@]} >= MAX_JOBS )); then
    wait -n
    local new=()
    for pid in "${JOBS[@]}"; do
      kill -0 "$pid" 2>/dev/null && new+=("$pid")
    done
    JOBS=("${new[@]}")
  fi
}

scripts=(
  "$SCRIPT_ROOT/baselines/baseline_llama7b.sh"
  "$SCRIPT_ROOT/prior-AST/pre-softmax.sh"
  "$SCRIPT_ROOT/prior-AST/post-softmax.sh"
  "$SCRIPT_ROOT/prior-AST/residual-scaling.sh"
  "$SCRIPT_ROOT/prior-CFG/pre-softmax.sh"
  "$SCRIPT_ROOT/prior-CFG/post-softmax.sh"
  "$SCRIPT_ROOT/prior-CFG/residual-scaling.sh"
  "$SCRIPT_ROOT/prior-slicing/pre-softmax.sh"
  "$SCRIPT_ROOT/prior-slicing/post-softmax.sh"
  "$SCRIPT_ROOT/prior-slicing/residual-scaling.sh"
)

for script in "${scripts[@]}"; do
  run_job bash "$script"
done

wait
