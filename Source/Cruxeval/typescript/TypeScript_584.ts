function f(txt: string): string {
    return txt.replace(/{\d+}/g, '0'.repeat(20));
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("5123807309875480094949830"),"5123807309875480094949830");
}

test();
