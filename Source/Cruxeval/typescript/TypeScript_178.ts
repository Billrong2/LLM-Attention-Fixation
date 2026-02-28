function f(array: number[], n: number): number[] {
    return array.slice(n);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([0, 0, 1, 2, 2, 2, 2], 4),[2, 2, 2]);
}

test();
