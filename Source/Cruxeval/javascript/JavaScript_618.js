function f(match, fill, n){
    return fill.substring(0, n) + match;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("9", "8", 2),"89");
}

test();
