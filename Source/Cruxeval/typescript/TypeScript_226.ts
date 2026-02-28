function f(nums: number[]): number[] {
    let length = nums.length;
    for (let i = 0; i < length; i++) {
        if (nums[i] % 3 === 0) {
            nums.push(nums[i]);
        }
    }
    return nums;
}

declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 3]),[1, 3, 3]);
}

test();
