function f(array: any[], L: number): any[] {
    if (L <= 0) {
        return array;
    }
    if (array.length < L) {
        array.push(...f(array, L - array.length));
    }
    return array;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 2, 3], 4),[1, 2, 3, 1, 2, 3]);
}

test();
