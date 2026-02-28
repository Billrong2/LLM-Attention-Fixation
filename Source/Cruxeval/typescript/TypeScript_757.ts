function f(text: string, char: string, replace: string): string {
    return text.replace(char, replace);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("a1a8", "1", "n2"),"an2a8");
}

test();
