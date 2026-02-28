function f(text: string, letter: string): number {
    let t: string = text;
    for (const alph of text) {
        t = t.replace(alph, "");
    }
    return t.split(letter).length;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("c, c, c ,c, c", "c"),1);
}

test();
