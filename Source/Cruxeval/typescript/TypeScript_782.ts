function f(input: string): boolean {
    for (let char of input) {
        if (char === char.toUpperCase()) {
            return false;
        }
    }
    return true;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("a j c n x X k"),false);
}

test();
