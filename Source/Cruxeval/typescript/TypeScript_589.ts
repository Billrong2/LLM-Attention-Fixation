function f(num: number[]): number[] {
    num.push(num[num.length - 1]);
    return num;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([-70, 20, 9, 1]),[-70, 20, 9, 1, 1]);
}

test();
