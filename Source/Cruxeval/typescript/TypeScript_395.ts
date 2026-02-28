function f(s: string): number {
    for (let i = 0; i < s.length; i++) {
        if (s[i].match(/\d/)) {
            return i + (s[i] === '0' ? 1 : 0);
        } else if (s[i] === '0') {
            return -1;
        }
    }
    return -1;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("11"),0);
}

test();
