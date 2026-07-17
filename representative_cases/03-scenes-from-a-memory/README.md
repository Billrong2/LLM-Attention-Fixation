# Scenes From a Memory

| Field | Value |
|---|---|
| Dataset problem | Code Contests validation row 79 — Codeforces 1562-B |
| Trial / paired seed | 2 / `1213338101` |
| Expected output | Two lines: `1`, `1` |
| Without steering | Single-line `11`; not exact |
| With CodeSteer | Two-line `1`, `1`; exact |

Both generations identify the relevant digit, but only CodeSteer preserves the required two-line output structure. The unsteered condition succeeds on a different trial, so this is specifically a selected-seed comparison.

## Case files

[Input](input.txt) · [Expected output](expected_output.txt) · [Original Java](original.java) · [Obfuscated Java](obfuscated.java) · [Shared submitted prompt](submitted_prompt.txt) · [Metadata](metadata.json)

## Raw generations

| Condition | Raw completion | Score |
|---|---|---|
| Without steering | [View unchanged generation](non_steering_raw.txt) | [View score](non_steering_score.json) |
| CodeSteer | [View unchanged generation](codesteer_raw.txt) | [View score](codesteer_score.json) |

[Back to all cases](../)

