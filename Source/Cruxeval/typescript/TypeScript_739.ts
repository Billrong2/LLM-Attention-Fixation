function f(st: string, pattern: string[]): boolean {
    for (let p of pattern) {
        if (!st.startsWith(p)) {
            return false;
        }
        st = st.slice(p.length);
    }
    return true;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("qwbnjrxs", ["jr", "b", "r", "qw"]),false);
}

test();
