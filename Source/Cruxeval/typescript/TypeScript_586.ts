function f(text: string, char: string): number {
    return text.lastIndexOf(char);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("breakfast", "e"),2);
}

test();
