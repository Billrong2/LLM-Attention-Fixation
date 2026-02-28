function f(nums: number[], val: number): number {
    const new_list: number[] = [];
    nums.forEach(i => {
        new_list.push(...Array(val).fill(i));
    });
    return new_list.reduce((acc, curr) => acc + curr, 0);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([10, 4], 3),42);
}

test();
