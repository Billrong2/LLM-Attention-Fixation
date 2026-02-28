function f(number: string): boolean {
    return number.trim().length > 0 && !isNaN(Number(number));
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("dummy33;d"),false);
}

test();
