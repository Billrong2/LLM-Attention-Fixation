function f(array: number[]): number[] {
    for (let i = 0; i < array.length; i++) {
        if (array[i] < 0) {
            array.splice(i, 1);
            i--; // Decrement i to account for the removed element
        }
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
