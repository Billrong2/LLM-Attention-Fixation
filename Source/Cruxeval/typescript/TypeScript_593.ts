function f(nums: number[], n: number): number[] {
    let pos: number = nums.length - 1;
    for (let i = -nums.length; i < 0; i++) {
        nums.splice(pos, 0, nums[i]);
    }
    return nums;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([], 14),[]);
}

test();
