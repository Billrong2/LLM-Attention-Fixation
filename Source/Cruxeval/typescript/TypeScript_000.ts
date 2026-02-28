function f(nums: number[]): [number, number][] {
    const output: [number, number][] = [];
    nums.forEach(n => {
        output.push([nums.filter(num => num === n).length, n]);
    });
    output.sort((a, b) => b[0] - a[0]);
    return output;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 1, 3, 1, 3, 1]),[[4, 1], [4, 1], [4, 1], [4, 1], [2, 3], [2, 3]]);
}

test();
