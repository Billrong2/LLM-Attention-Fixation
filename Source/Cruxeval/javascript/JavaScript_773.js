function f(nums, n){
    return nums.splice(n, 1)[0];
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([-7, 3, 1, -1, -1, 0, 4], 6),4);
}

test();
