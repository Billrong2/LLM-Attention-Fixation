function f(nums: number[]): number[] {
    nums = nums.slice();
    let count = nums.length;
    for (let i = -count+1; i < 0; i++) {
        nums.unshift(nums[nums.length + i]);
    }
    return nums;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([7, 1, 2, 6, 0, 2]),[2, 0, 6, 2, 1, 7, 1, 2, 6, 0, 2]);
}

test();
