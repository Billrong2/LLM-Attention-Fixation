function f(s: string, l: number): string {
    return s.padEnd(l, '=').split('=')[0];
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("urecord", 8),"urecord");
}

test();
