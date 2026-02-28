function f(text, letter){
    if (text.includes(letter)) {
        let start = text.indexOf(letter);
        return text.slice(start + 1) + text.slice(0, start + 1);
    }
    return text;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("19kefp7", "9"),"kefp719");
}

test();
