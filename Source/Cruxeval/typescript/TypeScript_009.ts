function f(t: string): boolean {
    for (let c of t) {
        if (!c.match(/[0-9]/)) {
            return false;
        }
    }
    return true;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("#284376598"),false);
}

test();
