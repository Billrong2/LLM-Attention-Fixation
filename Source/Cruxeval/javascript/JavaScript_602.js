function f(nums, target){
    let cnt = nums.filter(num => num === target).length;
    return cnt * 2;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 1], 1),4);
}

test();
