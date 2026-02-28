function f(text: string, letter: string): string {
    if (text.includes(letter)) {
        const start = text.indexOf(letter);
        return text.slice(start + 1) + text.slice(0, start + 1);
    }
    return text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("19kefp7", "9"),"kefp719");
}

test();
