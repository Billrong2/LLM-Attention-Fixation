function f(array: number[]): number[] {
    const result = array.slice();
    result.reverse();
    result.forEach((value, index, array) => {
        array[index] = value * 2;
    });
    return result;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 2, 3, 4, 5]),[10, 8, 6, 4, 2]);
}

test();
