function f(nums: number[], elements: number[]): number[] {
    let result: number[] = [];
    for (let i = 0; i < elements.length; i++) {
        result.push(nums.pop()!);
    }
    return nums;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([7, 1, 2, 6, 0, 2], [9, 0, 3]),[7, 1, 2]);
}

test();
