function f(nums){
    let count = nums.length;
    while (nums.length > Math.floor(count / 2)) {
        nums.length = 0;
    }
    return nums;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([2, 1, 2, 3, 1, 6, 3, 8]),[]);
}

test();
