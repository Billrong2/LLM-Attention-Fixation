function f(string: string): boolean {
    if (string.toUpperCase() === string) {
        return true;
    } else {
        return false;
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("Ohno"),false);
}

test();
