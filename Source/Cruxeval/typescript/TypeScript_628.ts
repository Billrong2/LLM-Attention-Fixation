function f(nums: number[], deleteNum: number): number[] {
    return nums.filter(num => num !== deleteNum);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([4, 5, 3, 6, 1], 5),[4, 3, 6, 1]);
}

test();
