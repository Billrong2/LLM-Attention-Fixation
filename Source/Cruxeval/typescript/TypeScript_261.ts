function f(nums: number[], target: number): [number[], number[]] {
    const lows: number[] = [];
    const higgs: number[] = [];
    nums.forEach((i) => {
        if (i < target) {
            lows.push(i);
        } else {
            higgs.push(i);
        }
    });
    lows.splice(0, lows.length);
    return [lows, higgs];
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([12, 516, 5, 2, 3, 214, 51], 5),[[], [12, 516, 5, 214, 51]]);
}

test();
