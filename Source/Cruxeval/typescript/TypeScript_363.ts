function f(nums: number[]): number[] {
    nums.sort();
    const n: number = nums.length;
    let new_nums: number[] = [nums[Math.floor(n/2)]];
    
    if (n % 2 === 0) {
        new_nums = [nums[n/2 - 1], nums[n/2]];
    }
    
    for (let i = 0; i < Math.floor(n/2); i++) {
        new_nums.unshift(nums[n-i-1]);
        new_nums.push(nums[i]);
    }
    return new_nums;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1]),[1]);
}

test();
