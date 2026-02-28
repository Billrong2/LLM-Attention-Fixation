function f(text){
    return text.length - (text.match(/bot/g) || []).length;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("Where is the bot in this world?"),30);
}

test();
