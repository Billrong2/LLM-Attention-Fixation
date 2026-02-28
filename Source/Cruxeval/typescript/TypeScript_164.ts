function f(lst: number[]): number[] {
    lst.sort((a, b) => a - b);
    return lst.slice(0, 3);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([5, 8, 1, 3, 0]),[0, 1, 3]);
}

test();
