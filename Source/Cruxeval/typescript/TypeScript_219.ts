function f(s1: string, s2: string): boolean {
    for (let k = 0; k < s2.length + s1.length; k++) {
        s1 += s1[0];
        s1 = s1.substring(1); // Remove the first character to keep the length consistent
        if (s1.indexOf(s2) >= 0) {
            return true;
        }
    }
    return false;
}

declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("Hello", ")"),false);
}

test();
