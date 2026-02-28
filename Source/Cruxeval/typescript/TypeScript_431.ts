function f(n: number, m: number): number[] {
    let arr: number[] = Array.from({length: n}, (_, index) => index + 1);
    for (let i = 0; i < m; i++) {
        arr = [];
    }
    return arr;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(1, 3),[]);
}

test();
