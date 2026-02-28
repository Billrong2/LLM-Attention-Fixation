function f(text: string, n: number): string {
    if (text.length <= 2) {
        return text;
    }
    const leadingChars = text[0].repeat(n - text.length + 1);
    return leadingChars + text.substring(1, text.length - 1) + text[text.length - 1];
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("g", 15),"g");
}

test();
