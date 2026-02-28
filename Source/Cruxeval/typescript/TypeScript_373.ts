function f(orig: number[]): number[] {
    let copy: number[] = orig;
    copy.push(100);
    orig.pop();
    return copy;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 2, 3]),[1, 2, 3]);
}

test();
