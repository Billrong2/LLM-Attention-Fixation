function f(nums){
    nums.splice(0, nums.length);
    return "quack";
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([2, 5, 1, 7, 9, 3]),"quack");
}

test();
