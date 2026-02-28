function f(string, substring){
    while (string.startsWith(substring)) {
        string = string.substring(substring.length);
    }
    return string;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("", "A"),"");
}

test();
