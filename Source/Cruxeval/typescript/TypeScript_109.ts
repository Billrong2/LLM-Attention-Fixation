function f(nums: number[], spot: number, idx: number): number[] {
    nums.splice(spot, 0, idx);
    return nums;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 0, 1, 1], 0, 9),[9, 1, 0, 1, 1]);
}

test();
