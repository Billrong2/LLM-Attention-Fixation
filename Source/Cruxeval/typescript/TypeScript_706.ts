function f(r: string, w: string): string[] {
    let a: string[] = [];
    if (r[0] === w[0] && w[w.length - 1] === r[r.length - 1]) {
        a.push(r);
        a.push(w);
    } else {
        a.push(w);
        a.push(r);
    }
    return a;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("ab", "xy"),["xy", "ab"]);
}

test();
