function f(nums: number[]): number[] {
    let length = nums.length;
    for (let i = 0; i < length; i++) {
        nums.splice(i, 0, nums[i] * nums[i]);
    }
    return nums;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 2, 4]),[1, 1, 1, 1, 2, 4]);
}

test();
