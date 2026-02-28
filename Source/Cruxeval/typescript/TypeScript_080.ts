function f(s: string): string {
    return s.trimRight().split('').reverse().join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("ab        "),"ba");
}

test();
