function f(text: string, char: string): boolean {
    let count = 0;
    for (let i = 0; i < text.length; i++) {
        if (text[i] === char) {
            count += 1;
        }
    }
    return count % 2 !== 0;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("abababac", "a"),false);
}

test();
