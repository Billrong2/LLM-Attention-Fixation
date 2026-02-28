function f(s: string): string {
  return Array.from(s).map(c => c.toLowerCase()).join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("abcDEFGhIJ"),"abcdefghij");
}

test();
