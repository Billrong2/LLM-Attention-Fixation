function f(nums: number[]): number[] {    
    let count = nums.length;
    for(let num = 2; num < count; num++) {
        nums.sort((a, b) => a - b);
    }
    return nums;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([-6, -5, -7, -8, 2]),[-8, -7, -6, -5, 2]);
}

test();
