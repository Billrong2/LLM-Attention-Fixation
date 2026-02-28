function f(lst: number[], i: number, n: number): number[] {
    lst.splice(i, 0, n);
    return lst;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([44, 34, 23, 82, 24, 11, 63, 99], 4, 15),[44, 34, 23, 82, 15, 24, 11, 63, 99]);
}

test();
