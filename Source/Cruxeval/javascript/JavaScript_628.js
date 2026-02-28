function f(nums, toDelete){
    nums.splice(nums.indexOf(toDelete), 1);
    return nums;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([4, 5, 3, 6, 1], 5),[4, 3, 6, 1]);
}

test();
