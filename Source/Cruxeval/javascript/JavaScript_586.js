function f(text, char){
    return text.lastIndexOf(char);
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("breakfast", "e"),2);
}

test();
