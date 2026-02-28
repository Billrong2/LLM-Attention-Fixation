function f(text: string): boolean {
    return text.split('-').length - 1 === text.length;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("---123-4"),false);
}

test();
