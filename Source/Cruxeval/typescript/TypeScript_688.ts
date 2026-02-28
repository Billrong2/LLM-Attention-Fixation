function f(nums: number[]): number[] {
    let l: number[] = [];
    for (let i of nums) {
        if (!l.includes(i)) {
            l.push(i);
        }
    }
    return l;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([3, 1, 9, 0, 2, 0, 8]),[3, 1, 9, 0, 2, 8]);
}

test();
