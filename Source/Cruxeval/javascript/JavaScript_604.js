function f(text, start){
    return text.startsWith(start);
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("Hello world", "Hello"),true);
}

test();
