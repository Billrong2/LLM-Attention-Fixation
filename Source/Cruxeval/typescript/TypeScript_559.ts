function f(n: string): string {
    n = String(n);
    return n[0] + '.' + n.slice(1).replace(/-/g, '_');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("first-second-third"),"f.irst_second_third");
}

test();
