function f(text, char){
    let count = text.split(char).length - 1;
    return count % 2 !== 0;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("abababac", "a"),false);
}

test();
