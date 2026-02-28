function f(n: string, s: string): string {
    if(s.startsWith(n)) {
        let [pre, _] = s.split(n, 2);
        return pre + n + s.slice(n.length);
    }
    return s;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("xqc", "mRcwVqXsRDRb"),"mRcwVqXsRDRb");
}

test();
