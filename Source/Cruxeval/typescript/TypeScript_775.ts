function f(nums: number[]): number[] {
    const count: number = nums.length;
    for (let i = 0; i < count / 2; i++) {
        [nums[i], nums[count - i - 1]] = [nums[count - i - 1], nums[i]];
    }
    return nums;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([2, 6, 1, 3, 1]),[1, 3, 1, 6, 2]);
}

test();
