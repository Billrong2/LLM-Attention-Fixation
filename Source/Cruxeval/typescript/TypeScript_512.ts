function f(s: string): boolean {
    return s.length === s.split('0').length + s.split('1').length - 2;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("102"),false);
}

test();
