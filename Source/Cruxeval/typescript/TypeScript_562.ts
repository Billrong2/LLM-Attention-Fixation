function f(text: string): boolean {
    return text.toUpperCase() === text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("VTBAEPJSLGAHINS"),true);
}

test();
