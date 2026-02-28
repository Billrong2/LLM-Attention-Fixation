function f(text: string): boolean {
    for (let char of text) {
        if (char !== ' ') {
            return false;
        }
    }
    return true;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("     i"),false);
}

test();
