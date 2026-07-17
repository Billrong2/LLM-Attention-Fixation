# Inconvenient Pairs

| Field | Value |
|---|---|
| Dataset problem | Code Contests validation row 101 — Codeforces 1569-D |
| Trial / paired seed | 1 / `1956018768` |
| Expected output | `0` |
| Without steering | No valid final JSON; not exact |
| With CodeSteer | `0`; exact |

The concrete input has no points (`k = 0`). The unsteered generation begins tracing the program but ends before producing a result; CodeSteer emits the exact output. The unsteered condition succeeds on a different trial, so this is specifically a selected-seed comparison.

## Case files

[Input](input.txt) · [Expected output](expected_output.txt) · [Original Java](original.java) · [Obfuscated Java](obfuscated.java) · [Shared submitted prompt](submitted_prompt.txt) · [Metadata](metadata.json)

## Raw generations

| Condition | Raw completion | Score |
|---|---|---|
| Without steering | [View unchanged generation](non_steering_raw.txt) | [View score](non_steering_score.json) |
| CodeSteer | [View unchanged generation](codesteer_raw.txt) | [View score](codesteer_score.json) |

[Back to all cases](../)

