function f(nums: number[], pos: number): number[] {
    let s: number[] = [];
    if (pos % 2) {
        s = nums.slice(0, -1);
    }
    s.reverse();
    return nums;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([6, 1], 3),[6, 1]);
}

test();
