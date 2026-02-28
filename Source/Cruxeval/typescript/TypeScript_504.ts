function f(values: number[]): number[] {
    values.sort((a, b) => a - b);
    return values;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 1, 1, 1]),[1, 1, 1, 1]);
}

test();
