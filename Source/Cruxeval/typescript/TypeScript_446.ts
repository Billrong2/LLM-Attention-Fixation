function f(array: number[]): number[] {
    const l: number = array.length;
    if (l % 2 === 0) {
        array.length = 0;
    } else {
        array.reverse();
    }
    return array;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([]),[]);
}

test();
