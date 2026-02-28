function f(text, char, replace){
    return text.replace(new RegExp(char, 'g'), replace);
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("a1a8", "1", "n2"),"an2a8");
}

test();
