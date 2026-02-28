function f(a: string, b: string): [string, string] {
    if (a < b) {
        return [b, a];
    }
    return [a, b];
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("ml", "mv"),["mv", "ml"]);
}

test();
