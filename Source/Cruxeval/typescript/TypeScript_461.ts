function f(text: string, search: string): boolean {
    return search.startsWith(text) || false;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("123", "123eenhas0"),true);
}

test();
