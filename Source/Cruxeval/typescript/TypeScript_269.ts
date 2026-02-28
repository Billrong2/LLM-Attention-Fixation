function f(array: number[]): number[] {
    const zero_len: number = (array.length - 1) % 3;
    for (let i = 0; i < zero_len; i++) {
        array[i] = 0;
    }
    for (let i = zero_len + 1; i < array.length; i += 3) {
        array.splice(i - 1, 3, 0, 0, 0);
    }
    return array;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([9, 2]),["0", 2]);
}

test();
