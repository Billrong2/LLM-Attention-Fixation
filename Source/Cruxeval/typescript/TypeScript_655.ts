function f(s: string): string {
    return s.split('a').join('').split('r').join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("rpaar"),"p");
}

test();
