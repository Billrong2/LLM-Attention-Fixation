function f(nums: number[], p: number): number {
    let prev_p: number = p - 1;
    if (prev_p < 0) {
        prev_p = nums.length - 1;
    }
    return nums[prev_p];
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([6, 8, 2, 5, 3, 1, 9, 7], 6),1);
}

test();
