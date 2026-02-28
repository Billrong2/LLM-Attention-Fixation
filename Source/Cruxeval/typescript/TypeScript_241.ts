function f(postcode: string): string {
    return postcode.substring(postcode.indexOf('C'));
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("ED20 CW"),"CW");
}

test();
