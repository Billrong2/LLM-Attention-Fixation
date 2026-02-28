function f(string: string, c: string): boolean {
    return string.endsWith(c);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("wrsch)xjmb8", "c"),false);
}

test();
