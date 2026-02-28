function f(nums: number[], target: number): number {
    const cnt = nums.filter(num => num === target).length;
    return cnt * 2;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 1], 1),4);
}

test();
