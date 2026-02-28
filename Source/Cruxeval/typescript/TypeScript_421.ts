function f(s: string, n: number): string {
    if (s.length < n) {
        return s;
    } else {
        return s.substring(n);
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("try.", 5),"try.");
}

test();
