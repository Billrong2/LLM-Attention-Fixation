function f(s: string): string {
    return s.slice(3) + s[2] + s.slice(5, 8);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("jbucwc"),"cwcuc");
}

test();
