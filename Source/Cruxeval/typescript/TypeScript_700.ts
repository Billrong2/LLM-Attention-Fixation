function f(text: string): number {
    return text.length - (text.match(/bot/g) || []).length;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("Where is the bot in this world?"),30);
}

test();
