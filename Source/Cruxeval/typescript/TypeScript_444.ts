function f(nums: number[]): number[] {
    let count: number = nums.length;
    for (let i: number = count - 1; i > 0; i -= 2) {
        nums.splice(i, 0, nums.shift() + nums.shift());
    }
    return nums;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([-5, 3, -2, -3, -1, 3, 5]),[5, -2, 2, -5]);
}

test();
