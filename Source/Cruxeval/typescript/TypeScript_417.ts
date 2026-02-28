function f(lst: number[]): number[] {
    lst.reverse();
    lst.pop();
    lst.reverse();
    return lst;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([7, 8, 2, 8]),[8, 2, 8]);
}

test();
