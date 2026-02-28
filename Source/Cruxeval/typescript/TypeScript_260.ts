function f(nums: number[], start: number, k: number): number[] {
    nums.splice(start, k, ...nums.slice(start, start + k).reverse());
    return nums;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 2, 3, 4, 5, 6], 4, 2),[1, 2, 3, 4, 6, 5]);
}

test();
