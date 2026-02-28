function f(text: string): boolean {
    return !text.match(/^\d+$/);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("the speed is -36 miles per hour"),true);
}

test();
