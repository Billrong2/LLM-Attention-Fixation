function f(text: string): boolean {
    for (const c of text) {
        if (!c.match(/\d/)) {
            return false;
        }
    }
    return !!text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("99"),true);
}

test();
