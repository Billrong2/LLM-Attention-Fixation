function f(a: number[]): number[] {
    if (a.length >= 2 && a[0] > 0 && a[1] > 0) {
        a.reverse();
        return a;
    }
    a.push(0);
    return a;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([]),[0]);
}

test();
