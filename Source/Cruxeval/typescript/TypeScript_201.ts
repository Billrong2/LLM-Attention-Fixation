function f(text: string): string {
    const chars: string[] = [];
    for (let i = 0; i < text.length; i++) {
        if (!isNaN(parseInt(text[i]))) {
            chars.push(text[i]);
        }
    }
    return chars.reverse().join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("--4yrw 251-//4 6p"),"641524");
}

test();
