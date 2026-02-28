function f(num1: number, num2: number, num3: number): string {
    const nums: number[] = [num1, num2, num3];
    nums.sort();
    return `${nums[0]},${nums[1]},${nums[2]}`;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(6, 8, 8),"6,8,8");
}

test();
