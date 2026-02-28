function f(text: string, start: string): boolean {
    return text.startsWith(start);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("Hello world", "Hello"),true);
}

test();
