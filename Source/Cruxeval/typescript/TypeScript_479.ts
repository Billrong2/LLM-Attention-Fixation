function f(nums: number[], pop1: number, pop2: number): number[] {
    nums.splice(pop1 - 1, 1);
    nums.splice(pop2 - 1, 1);
    return nums;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 5, 2, 3, 6], 2, 4),[1, 2, 3]);
}

test();
