function f(nums, n){
    let pos = nums.length - 1;
    for (let i = -nums.length; i < 0; i++){
        nums.splice(pos, 0, nums[i]);
    }
    return nums;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([], 14),[]);
}

test();
