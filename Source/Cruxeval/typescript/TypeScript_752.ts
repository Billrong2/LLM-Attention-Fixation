function f(s: string, amount: number): string {
    return 'z'.repeat(amount - s.length) + s;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("abc", 8),"zzzzzabc");
}

test();
