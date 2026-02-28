function f(parts){
    return Object.values(Object.fromEntries(parts));
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([["u", 1], ["s", 7], ["u", -5]]),[-5, 7]);
}

test();
