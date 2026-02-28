function f(nums, fill){
    let ans = {};
    nums.forEach(num => {
        ans[num] = fill;
    });
    return ans;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([0, 1, 1, 2], "abcca"),{0: "abcca", 1: "abcca", 2: "abcca"});
}

test();
