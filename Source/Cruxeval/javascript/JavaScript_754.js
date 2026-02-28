function f(nums){
    nums = nums.slice(1).map(val => {
        return val.toString().padStart(parseInt(nums[0]), '0');
    });
    return nums.map(val => val.toString());
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["1", "2", "2", "44", "0", "7", "20257"]),["2", "2", "44", "0", "7", "20257"]);
}

test();
