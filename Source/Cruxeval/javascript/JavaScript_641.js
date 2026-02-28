function f(number){
    return number.trim().match(/^\d+$/) !== null;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("dummy33;d"),false);
}

test();
