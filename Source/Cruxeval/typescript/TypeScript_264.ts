function f(test_str: string): string {
    let s = test_str.replace(/a/g, 'A');
    return s.replace(/e/g, 'A');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("papera"),"pApArA");
}

test();
