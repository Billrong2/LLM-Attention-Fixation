function f(nums: number[]): number[] {
    const middle = Math.floor(nums.length / 2);
    return nums.slice(middle).concat(nums.slice(0, middle));
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 1, 1]),[1, 1, 1]);
}

test();
