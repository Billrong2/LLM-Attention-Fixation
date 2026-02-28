function f(parts: [string, number][]): number[] {
    return Object.values(Object.fromEntries(parts));
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([["u", 1], ["s", 7], ["u", -5]]),[-5, 7]);
}

test();
