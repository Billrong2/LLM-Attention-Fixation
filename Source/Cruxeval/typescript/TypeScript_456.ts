function f(s: string, tab: number): string {
    return s.split('\t').join(' '.repeat(tab));
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("Join us in Hungary", 4),"Join us in Hungary");
}

test();
