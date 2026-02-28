function f(array: number[]): number[] {
    while (array.includes(-1)) {
        array.splice(array.indexOf(-1), 1);
    }
    while (array.includes(0)) {
        array.pop();
    }
    while (array.includes(1)) {
        array.splice(array.indexOf(1), 1);
    }
    return array;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([0, 2]),[]);
}

test();
