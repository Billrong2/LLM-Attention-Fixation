function f(sentence: string): boolean {
    for (let c of sentence) {
        if (!c.match(/[ -~]/)) {
            return false;
        }
    }
    return true;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("1z1z1"),true);
}

test();
