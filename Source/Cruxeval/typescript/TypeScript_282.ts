function f(s1: string, s2: string): number {
    let position: number = 1;
    let count: number = 0;
    while (position > 0) {
        position = s1.indexOf(s2, position);
        count += 1;
        position += 1;
    }
    return count;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("xinyyexyxx", "xx"),2);
}

test();
