function f(string: string): string {
    let count = string.split(':').length - 1;
    let lastIndex = string.lastIndexOf(':');
    return string.substring(0, lastIndex) + string.substring(lastIndex + 1);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("1::1"),"1:1");
}

test();
