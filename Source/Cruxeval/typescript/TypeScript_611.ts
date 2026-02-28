function f(nums: number[]): number[] {
    nums.reverse();
    return nums;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([-6, -2, 1, -3, 0, 1]),[1, 0, -3, 1, -2, -6]);
}

test();
