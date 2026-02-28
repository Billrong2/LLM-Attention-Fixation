function f(s1: string, s2: string): string {
    if (s2.endsWith(s1)) {
        s2 = s2.slice(0, s1.length * -1);
    }
    return s2;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("he", "hello"),"hello");
}

test();
