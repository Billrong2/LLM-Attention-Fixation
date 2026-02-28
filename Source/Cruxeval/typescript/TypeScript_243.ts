function f(text: string, char: string): boolean {
    return char.toLowerCase() === char && text.toLowerCase() === text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("abc", "e"),true);
}

test();
