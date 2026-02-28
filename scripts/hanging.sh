#!/usr/bin/env bash
set -euo pipefail

# Queue runner for a single smoke-test job:
#   /people/cs/x/xxr230000/eyetracking/scripts/Qwen-based/SmokeTest/step4_topk/l2/smoketest_ast.sh
#
# Usage:
#   bash scripts/hanging.sh
# Optional env overrides:
#   CHECK_SEC=20 MIN_FREE_MB=14000 GPU_LIST=0,1,2,3 bash scripts/hanging.sh

JOB_SCRIPT="/people/cs/x/xxr230000/eyetracking/scripts/Qwen-based/SmokeTest/step4_topk/l2/smoketest_ast.sh"
CHECK_SEC="${CHECK_SEC:-5}"
MIN_FREE_MB="${MIN_FREE_MB:-4500}"
GPU_LIST="${GPU_LIST:-0,1,2,3}"

if [[ ! -x "$(command -v nvidia-smi)" ]]; then
  echo "[ERROR] nvidia-smi not found in PATH."
  exit 1
fi

if [[ ! -f "$JOB_SCRIPT" ]]; then
  echo "[ERROR] Job script not found: $JOB_SCRIPT"
  exit 1
fi

if pgrep -f "$JOB_SCRIPT" >/dev/null 2>&1; then
  echo "[INFO] Job already running: $JOB_SCRIPT"
  exit 0
fi

IFS=',' read -r -a GPUS <<< "$GPU_LIST"

gpu_ready() {
  local snapshot
  snapshot="$(nvidia-smi --query-gpu=index,memory.free --format=csv,noheader,nounits)"

  for gpu in "${GPUS[@]}"; do
    gpu="${gpu// /}"
    [[ -z "$gpu" ]] && continue
    local free
    free="$(awk -F',' -v id="$gpu" '
      {gsub(/ /, "", $1); gsub(/ /, "", $2)}
      $1 == id {print $2; found=1}
      END {if (!found) print "-1"}
    ' <<< "$snapshot")"

    if [[ "$free" -lt "$MIN_FREE_MB" ]]; then
      echo "[WAIT] $(date '+%F %T') GPU ${gpu}: free=${free}MB (< ${MIN_FREE_MB}MB)"
      return 1
    fi
  done
  return 0
}

echo "[INFO] Waiting for GPUs (${GPU_LIST}) with >= ${MIN_FREE_MB}MB free each..."
echo "[INFO] Target job: $JOB_SCRIPT"

while true; do
  if gpu_ready; then
    echo "[START] $(date '+%F %T') launching: $JOB_SCRIPT"
    exec bash "$JOB_SCRIPT"
  fi
  sleep "$CHECK_SEC"
done
