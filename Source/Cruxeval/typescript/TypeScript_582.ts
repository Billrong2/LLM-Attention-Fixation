function f(k: number, j: number): number[] {
    const arr: number[] = [];
    for (let i = 0; i < k; i++) {
        arr.push(j);
    }
    return arr;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(7, 5),[5, 5, 5, 5, 5, 5, 5]);
}

test();
