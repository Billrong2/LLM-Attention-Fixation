function f(xs: number[]): number[] {
    for (let idx = -xs.length; idx < 0; idx++) {
        xs.unshift(xs.pop() as number);
    }
    return xs;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 2, 3]),[1, 2, 3]);
}

test();
