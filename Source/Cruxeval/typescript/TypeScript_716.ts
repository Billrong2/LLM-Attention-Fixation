function f(nums: number[]): number[] {
    let count: number = nums.length;
    while (nums.length > Math.floor(count / 2)) {
        nums = [];
    }
    return nums;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([2, 1, 2, 3, 1, 6, 3, 8]),[]);
}

test();
