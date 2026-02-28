function f(nums: number[]): number[] {
    nums.splice(0, nums.length);
    nums.forEach((num) => nums.push(num * 2));
    
    return nums;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([4, 3, 2, 1, 2, -1, 4, 2]),[]);
}

test();
