function f(number: number): string[] {
    const transl: { [key: string]: number } = { 'A': 1, 'B': 2, 'C': 3, 'D': 4, 'E': 5 };
    const result: string[] = [];
    for (const [key, value] of Object.entries(transl)) {
        if (value % number === 0) {
            result.push(key);
        }
    }
    return result;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(2),["B", "D"]);
}

test();
