function f(text: string, insert: string): string {
    const whitespaces: Set<string> = new Set(['\t', '\r', '\v', ' ', '\f', '\n']);
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
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("pi wa", "chi"),"pichiwa");
}

test();
