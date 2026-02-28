function f(nums: Array<string | number>): number[] {
    const digits: number[] = [];
    nums.forEach(num => {
        if ((typeof num === 'string' && !isNaN(Number(num))) || typeof num === 'number') {
            digits.push(Number(num));
        }
    });
    return digits;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([0, 6, "1", "2", 0]),[0, 6, 1, 2, 0]);
}

test();
