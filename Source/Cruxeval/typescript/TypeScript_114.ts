function f(text: string, sep: string): string[] {
    return text.split(sep).slice(0, 3);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("a-.-.b", "-."),["a", "", "b"]);
}

test();
