function f(x: string): boolean {
    let n: number = x.length;
    let i: number = 0;
    while (i < n && !isNaN(Number(x[i]))) {
        i++;
    }
    return i === n;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("1"),true);
}

test();
