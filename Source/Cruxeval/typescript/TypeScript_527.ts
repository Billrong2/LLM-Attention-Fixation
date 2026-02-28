function f(text: string, value: string): string {
    return text.padEnd(value.length, '?');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("!?", ""),"!?");
}

test();
