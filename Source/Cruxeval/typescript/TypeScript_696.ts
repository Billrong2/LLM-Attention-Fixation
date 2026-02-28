function f(text: string): number {
    let s: number = 0;
    for (let i = 1; i < text.length; i++) {
        s += text.substr(0, text.lastIndexOf(text[i])).length;
    }
    return s;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("wdj"),3);
}

test();
