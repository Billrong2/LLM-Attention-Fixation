function f(s: number[]): number {
    while (s.length > 1) {
        s.length = 0;
        s.push(s.length);
    }
    return s.pop();
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([6, 1, 2, 3]),0);
}

test();
