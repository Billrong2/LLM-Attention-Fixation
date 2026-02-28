function f(text: string): boolean {
    try {
        return text.match(/^[a-zA-Z]+$/) !== null;
    } catch {
        return false;
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("x"),true);
}

test();
