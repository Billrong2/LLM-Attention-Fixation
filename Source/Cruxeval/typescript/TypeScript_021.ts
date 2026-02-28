function f(array: number[]): number[] {
    const n: number = array.pop()!;
    array.push(n, n);
    return array;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 1, 2, 2]),[1, 1, 2, 2, 2]);
}

test();
