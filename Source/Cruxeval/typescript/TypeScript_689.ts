function f(arr: number[]): number[] {
    const count: number = arr.length;
    const sub: number[] = arr.slice();
    for (let i: number = 0; i < count; i += 2) {
        sub[i] *= 5;
    }
    return sub;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([-3, -6, 2, 7]),[-15, -6, 10, 7]);
}

test();
