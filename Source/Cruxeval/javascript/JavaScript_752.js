function f(s, amount){
    return 'z'.repeat(amount - s.length) + s;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("abc", 8),"zzzzzabc");
}

test();
