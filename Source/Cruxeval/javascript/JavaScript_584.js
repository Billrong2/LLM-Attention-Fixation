function f(txt){
    return txt.replace(/{}/g, '0'.repeat(20));
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("5123807309875480094949830"),"5123807309875480094949830");
}

test();
