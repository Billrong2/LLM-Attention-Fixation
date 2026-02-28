function f(text: string): number {
    return text.indexOf(',');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("There are, no, commas, in this text"),9);
}

test();
