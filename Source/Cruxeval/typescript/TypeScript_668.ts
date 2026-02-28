function f(text: string): string {
    return text.slice(-1) + text.slice(0, -1);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("hellomyfriendear"),"rhellomyfriendea");
}

test();
