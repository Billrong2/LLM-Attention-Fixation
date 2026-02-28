function f(match: string, fill: string, n: number): string {
    return fill.substring(0, n) + match;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("9", "8", 2),"89");
}

test();
