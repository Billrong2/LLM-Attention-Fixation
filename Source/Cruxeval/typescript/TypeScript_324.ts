function f(nums: number[]): number[] {
    let asc: number[] = nums.slice();
    let desc: number[] = [];
    asc.reverse();
    desc = asc.slice(0, asc.length / 2);
    return desc.concat(asc).concat(desc);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([]),[]);
}

test();
