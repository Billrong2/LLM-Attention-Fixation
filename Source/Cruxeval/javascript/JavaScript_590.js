function f(text){
    for(let i = 10; i > 0; i--){
        text = text.replace(new RegExp(`^${i}`, "g"), "");
    }
    return text;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("25000   $"),"5000   $");
}

test();
