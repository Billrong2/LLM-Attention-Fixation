## Step-1 Decode-Only Steering Smoke Checks

This repository now supports Step-1 non-destructive steering:

- L1/L2 steering is decode-only (`q_len == 1`)
- optional first-decode-step-only safety (`kv_len == prompt_len`)
- split prefill (`prompt[:-1]` prefill + `prompt[-1:]` decode)

### Run no-op invariants

```bash
cd /people/cs/x/xxr230000/eyetracking
/people/cs/x/xxr230000/anaconda3/bin/python scripts/testing/check_decode_only_invariants.py \
  --model-name Qwen/Qwen2.5-Coder-7B-Instruct \
  --snippet Source/Ackerman.java \
  --gpu-ids 0
```

This script checks:

1. Steering disabled == baseline
2. `split_prefill=ON` + steering disabled == legacy baseline
3. `beta=0` == baseline
4. Uniform prior == baseline

All checks compare full token IDs exactly.

### Normal run (split prefill active by default for L1/L2)

```bash
cd /people/cs/x/xxr230000/eyetracking
/people/cs/x/xxr230000/anaconda3/bin/python main.py \
  --level1 \
  --prior=ast \
  --beta-bias=0.8 \
  --model-name=Qwen/Qwen2.5-Coder-7B-Instruct \
  --runs-per-snippet=20
```

The output `model_output.json` includes `steering_debug` with:

- `split_prefill_used`
- `steer_calls`
- `blocked_prefill_calls`
