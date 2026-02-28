function f(text: string): number {
    const s = text.split('\n');
    return s.length;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("145\n\n12fjkjg"),3);
}

test();
