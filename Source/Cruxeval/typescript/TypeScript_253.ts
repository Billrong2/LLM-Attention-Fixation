function f(text: string, pref: string): string {
    const length: number = pref.length;
    if (pref === text.slice(0, length)) {
        return text.slice(length);
    }
    return text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("kumwwfv", "k"),"umwwfv");
}

test();
