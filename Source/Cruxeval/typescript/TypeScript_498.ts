function f(nums: number[], idx: number, added: number): number[] {
    nums.splice(idx, 0, added);
    return nums;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([2, 2, 2, 3, 3], 2, 3),[2, 2, 3, 2, 3, 3]);
}

test();
