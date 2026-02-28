function f(nums, pos){
    let s = nums.slice();
    if(pos % 2){
        s = nums.slice(0, -1);
    }
    s.reverse();
    return nums;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([6, 1], 3),[6, 1]);
}

test();
