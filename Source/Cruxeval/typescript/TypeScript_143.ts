function f(s: string, n: string): boolean {
    return s.toLowerCase() === n.toLowerCase();
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("daaX", "daaX"),true);
}

test();
