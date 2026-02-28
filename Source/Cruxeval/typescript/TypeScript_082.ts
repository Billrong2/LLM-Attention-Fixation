function f(a: string, b: string, c: string, d: string): string {
    return a && b || c && d;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("CJU", "BFS", "WBYDZPVES", "Y"),"BFS");
}

test();
