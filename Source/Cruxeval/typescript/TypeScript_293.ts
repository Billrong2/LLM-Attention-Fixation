function f(text: string): string {
    let s: string = text.toLowerCase();
    for (let i = 0; i < s.length; i++) {
        if (s[i] === 'x') {
            return 'no';
        }
    }
    return text.toUpperCase();
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("dEXE"),"no");
}

test();
