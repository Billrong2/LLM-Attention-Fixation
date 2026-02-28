function f(value: string, char: string): number {
    let total = 0;
    for (let c of value) {
        if (c === char || c === char.toLowerCase()) {
            total += 1;
        }
    }
    return total;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("234rtccde", "e"),1);
}

test();
