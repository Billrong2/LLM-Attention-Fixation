function f(s: string): string {
    return s.replace('(', '[').replace(')', ']');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("(ac)"),"[ac]");
}

test();
