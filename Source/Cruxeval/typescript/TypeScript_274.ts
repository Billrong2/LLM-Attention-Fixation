function f(nums: number[], target: number): number {
    let count: number = 0;
    for (let n1 of nums) {
        for (let n2 of nums) {
            count += Number(n1 + n2 === target);
        }
    }
    return count;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 2, 3], 4),3);
}

test();
