function f(string){
    if (string === string.toUpperCase()) {
        return string.toLowerCase();
    } else if (string === string.toLowerCase()) {
        return string.toUpperCase();
    }
    return string;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("cA"),"cA");
}

test();
