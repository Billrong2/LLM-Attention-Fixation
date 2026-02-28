function f(nums: number[]): number[] {
    let a: number = -1;
    let b: number[] = nums.slice(1);
    while (a <= b[0]) {
        nums.splice(nums.indexOf(b[0]), 1);
        a = 0;
        b = b.slice(1);
    }
    return nums;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([-1, 5, 3, -2, -6, 8, 8]),[-1, -2, -6, 8, 8]);
}

test();
