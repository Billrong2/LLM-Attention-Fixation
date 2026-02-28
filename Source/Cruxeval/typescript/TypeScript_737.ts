function f(nums: number[]): number {
    let counts: number = 0;
    for (let i of nums) {
        if (!isNaN(i)) {
            if (counts === 0) {
                counts += 1;
            }
        }
    }
    return counts;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([0, 6, 2, -1, -2]),1);
}

test();
