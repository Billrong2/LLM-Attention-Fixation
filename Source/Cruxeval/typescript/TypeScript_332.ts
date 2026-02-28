function f(nums: number[]): number[] {
    const count: number = nums.length;
    if (count === 0) {
        nums = new Array<number>(parseInt(nums.pop().toString())).fill(0);
    } else if (count % 2 === 0) {
        nums.length = 0;
    } else {
        nums.splice(0, Math.floor(count / 2));
    }
    return nums;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([-6, -2, 1, -3, 0, 1]),[]);
}

test();
