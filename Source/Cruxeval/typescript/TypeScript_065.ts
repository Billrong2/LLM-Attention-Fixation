function f(nums: number[], index: number): number {
    return nums[index] % 42 + nums.splice(index, 1)[0] * 2;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([3, 2, 0, 3, 7], 3),9);
}

test();
