function f(text, tab_size){
    return text.replace(/\t/g, ' '.repeat(tab_size));
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("a", 100),"a");
}

test();
