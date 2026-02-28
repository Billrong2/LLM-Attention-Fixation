function f(s: string, suffix: string): string {
    if (!suffix) {
        return s;
    }
    while (s.endsWith(suffix)) {
        s = s.slice(0, -suffix.length);
    }
    return s;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("ababa", "ab"),"ababa");
}

test();
