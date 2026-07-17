# Backspace

| Field | Value |
|---|---|
| Dataset problem | Code Contests validation row 27 — Codeforces 1553-D |
| Trial / paired seed | 2 / `2052082749` |
| Expected output | `NO` |
| Without steering | No valid final JSON; not exact |
| With CodeSteer | `NO`; exact |

The unsteered reasoning reaches the correct semantic conclusion but truncates before completing the required output marker. CodeSteer produces the required exact output.

## Case files

[Input](input.txt) · [Expected output](expected_output.txt) · [Original Java](original.java) · [Obfuscated Java](obfuscated.java) · [Shared submitted prompt](submitted_prompt.txt) · [Metadata](metadata.json)

## Raw generations

| Condition | Raw completion | Score |
|---|---|---|
| Without steering | [View unchanged generation](non_steering_raw.txt) | [View score](non_steering_score.json) |
| CodeSteer | [View unchanged generation](codesteer_raw.txt) | [View score](codesteer_score.json) |

[Back to all cases](../)

