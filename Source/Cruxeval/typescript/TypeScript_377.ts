function f(text: string): string {
    return text.split('\n').join(', ');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("BYE\nNO\nWAY"),"BYE, NO, WAY");
}

test();
