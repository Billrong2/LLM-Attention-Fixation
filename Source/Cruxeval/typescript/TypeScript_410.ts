function f(nums: number[]): number[] {
    let a = 0;
    let length = nums.length;
    for(let i = 0; i < length; i++) {
        nums.splice(i, 0, nums[a]);
        a += 1;
    }
    return nums;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 3, -1, 1, -2, 6]),[1, 1, 1, 1, 1, 1, 1, 3, -1, 1, -2, 6]);
}

test();
