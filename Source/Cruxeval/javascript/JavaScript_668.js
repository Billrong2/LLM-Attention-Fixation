function f(text){
    return text[text.length - 1] + text.substring(0, text.length - 1);
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("hellomyfriendear"),"rhellomyfriendea");
}

test();
