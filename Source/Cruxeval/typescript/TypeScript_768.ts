function f(s: string, o: string): string {
    if (s.startsWith(o)) {
        return s;
    } else {
        return o + f(s, o.split('').reverse().join('').slice(1, -1));
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("abba", "bab"),"bababba");
}

test();
