function f(s: string, sep: string): string {
    s += sep;
    return s.substring(0, s.lastIndexOf(sep));
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("234dsfssdfs333324314", "s"),"234dsfssdfs333324314");
}

test();
