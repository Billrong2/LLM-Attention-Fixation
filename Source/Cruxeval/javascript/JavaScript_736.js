function f(text, insert){
    const whitespaces = new Set(['\t', '\r', '\v', ' ', '\f', '\n']);
    let clean = '';
    for (let char of text) {
        if (whitespaces.has(char)) {
            clean += insert;
        } else {
            clean += char;
        }
    }
    return clean;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("pi wa", "chi"),"pichiwa");
}

test();
