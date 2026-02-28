function f(array: number[], index: number, value: number): number[] {
    array.unshift(index + 1);
    if (value >= 1) {
        array.splice(index, 0, value);
    }
    return array;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([2], 0, 2),[2, 1, 2]);
}

test();
