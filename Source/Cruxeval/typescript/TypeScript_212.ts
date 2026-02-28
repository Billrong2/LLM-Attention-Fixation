function f(nums: number[]): number[] {
    for (let _ = 0; _ < nums.length - 1; _++) {
        nums.reverse();
    }
    return nums;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, -9, 7, 2, 6, -3, 3]),[1, -9, 7, 2, 6, -3, 3]);
}

test();
