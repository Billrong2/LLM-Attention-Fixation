function f(string: string): number {
    try {
        return string.lastIndexOf('e');
    } catch (error) {
        return NaN;
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("eeuseeeoehasa"),8);
}

test();
