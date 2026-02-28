function f(nums: number[], number: number): number {
    return nums.filter(num => num === number).length;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([12, 0, 13, 4, 12], 12),2);
}

test();
