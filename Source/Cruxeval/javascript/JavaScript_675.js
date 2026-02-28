function f(nums, sort_count){
    nums.sort((a, b) => a - b);
    return nums.slice(0, sort_count);
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 2, 2, 3, 4, 5], 1),[1]);
}

test();
