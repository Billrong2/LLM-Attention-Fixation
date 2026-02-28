function f(chars: string): string {
    let s = "";
    for (let ch of chars) {
        const count = Array.from(chars).filter(c => c === ch).length;
        if (count % 2 === 0) {
            s += ch.toUpperCase();
        } else {
            s += ch;
        }
    }
    return s;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("acbced"),"aCbCed");
}

test();
