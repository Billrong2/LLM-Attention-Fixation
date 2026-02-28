function f(n: number): boolean {
    for (const digit of n.toString()) {
        if (!["0", "1", "2"].includes(digit) && !Array.from({length: 5}, (_, i) => i + 5).includes(Number(digit))) {
            return false;
        }
    }
    return true;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(1341240312),false);
}

test();
