function f(aDict){
    return Object.fromEntries(Object.entries(aDict));
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({1: 1, 2: 2, 3: 3}),{1: 1, 2: 2, 3: 3});
}

test();
