function f(text: string): boolean {
    return !text.split('').some(c => c.toUpperCase() === c);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("lunabotics"),true);
}

test();
