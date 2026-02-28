function f(text: string): number {
    return text.split('\n').length;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("ncdsdfdaaa0a1cdscsk*XFd"),1);
}

test();
