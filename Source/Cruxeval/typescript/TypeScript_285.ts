function f(text: string, ch: string): number {
    return text.split(ch).length - 1;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("This be Pirate's Speak for 'help'!", " "),5);
}

test();
