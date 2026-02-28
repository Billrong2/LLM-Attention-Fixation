function f(nums: number[]): number[] {
    const count = nums.length;
    for (let i = 0; i < count; i++) {
        nums.push(nums[i % 2]);
    }
    return nums;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([-1, 0, 0, 1, 1]),[-1, 0, 0, 1, 1, -1, 0, -1, 0, -1]);
}

test();
