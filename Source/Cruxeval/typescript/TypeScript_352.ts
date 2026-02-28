function f(nums: number[]): number {
    return nums[Math.floor(nums.length / 2)];
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([-1, -3, -5, -7, 0]),-5);
}

test();
