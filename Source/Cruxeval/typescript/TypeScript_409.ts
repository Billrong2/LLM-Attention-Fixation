function f(text: string, char: string): string {
    if (text) {
        text = text.startsWith(char) ? text.slice(char.length) : text;
        text = text.slice(0, -1) + text.slice(-1).toUpperCase();
    }
    return text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("querist", "u"),"querisT");
}

test();
