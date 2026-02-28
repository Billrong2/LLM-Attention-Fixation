function f(nums: string[]): string[] {
    nums = nums.slice(1).map(val => val.padStart(parseInt(nums[0]), '0'));
    return nums.map(val => val.toString());
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["1", "2", "2", "44", "0", "7", "20257"]),["2", "2", "44", "0", "7", "20257"]);
}

test();
