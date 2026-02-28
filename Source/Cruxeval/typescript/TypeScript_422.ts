function f(array: number[]): number[] {
    const new_array: number[] = array.slice();
    new_array.reverse();
    return new_array.map(x => x * x);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 2, 1]),[1, 4, 1]);
}

test();
