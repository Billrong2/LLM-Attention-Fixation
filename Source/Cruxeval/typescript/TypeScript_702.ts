function f(nums: number[]): number[] {
    const count: number = nums.length;
    for (let i = nums.length - 1; i >= 0; i--) {
        nums.splice(i, 0, nums.shift()!);
    }
    return nums;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([0, -5, -4]),[-4, -5, 0]);
}

test();
