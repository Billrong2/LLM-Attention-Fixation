function f(nums: number[]): number[] {
    for (let i = nums.length - 1; i >= 0; i--) {
        if (nums[i] % 2 === 0) {
            nums.splice(i, 1);
        }
    }
    return nums;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([5, 3, 3, 7]),[5, 3, 3, 7]);
}

test();
