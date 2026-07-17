# Raw output comparisons

Each snippet compares generation without steering against generation with CodeSteer under the same source, prompt, model, trial, and sampling seed. Full raw generations are preserved unchanged.

## Snippet 1

| Without steering | With CodeSteer |
|---|---|
| Completion ends before a valid final-output value | `FINAL_OUTPUT_JSON: {"stdout":"NO"}` |

[Open Snippet 1](snippet-1/)

## Snippet 2

| Without steering | With CodeSteer |
|---|---|
| `FINAL_OUTPUT_JSON: {"stdout": "0\n0\n0\n0\n"}` | `FINAL_OUTPUT_JSON: {"stdout":"0\n0\n0\n"}` |

[Open Snippet 2](snippet-2/)

## Snippet 3

| Without steering | With CodeSteer |
|---|---|
| `{"stdout":"11"}` | `FINAL_OUTPUT_JSON: {"stdout":"1\n1\n"}` |

[Open Snippet 3](snippet-3/)

## Snippet 4

| Without steering | With CodeSteer |
|---|---|
| Completion ends before a final-output value | `FINAL_OUTPUT_JSON: {"stdout":"0\n"}` |

[Open Snippet 4](snippet-4/)

