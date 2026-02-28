function f(string: string): string {
    if (string === string.toUpperCase()) {
        return string.toLowerCase();
    } else if (string === string.toLowerCase()) {
        return string.toUpperCase();
    }
    return string;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("cA"),"cA");
}

test();
