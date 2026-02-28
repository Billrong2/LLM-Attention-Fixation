function f(nums: number[]): boolean {
    if (nums.slice().reverse().join('') === nums.join('')) {
        return true;
    }
    return false;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([0, 3, 6, 2]),false);
}

test();
