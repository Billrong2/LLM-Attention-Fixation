function f(a: number[], b: number[]): number[] {
    a.sort();
    b.sort((x, y) => y - x);
    return a.concat(b);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([666], []),[666]);
}

test();
