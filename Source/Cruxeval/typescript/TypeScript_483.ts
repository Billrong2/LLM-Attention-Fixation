function f(text: string, char: string): string {
    return text.split(char).join(' ');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("a", "a")," ");
}

test();
