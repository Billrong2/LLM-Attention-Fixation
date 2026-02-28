function f(text, n){
    var length = text.length;
    return text.slice(length*(n%4), length);
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("abc", 1),"");
}

test();
