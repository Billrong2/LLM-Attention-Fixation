function f(text: string, prefix: string): string {
    let idx: number = 0;
    for (const letter of prefix) {
        if (text[idx] !== letter) {
            return null;
        }
        idx++;
    }
    return text.substring(idx);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("bestest", "bestest"),"");
}

test();
