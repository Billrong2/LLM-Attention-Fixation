function f(nums: number[], fill: string): {[key: number]: string} {
    let ans: {[key: number]: string} = {};
    nums.forEach(num => {
        ans[num] = fill;
    });
    return ans;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([0, 1, 1, 2], "abcca"),{0: "abcca", 1: "abcca", 2: "abcca"});
}

test();
