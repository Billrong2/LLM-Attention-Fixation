function f(s: string, n: number, c: string): string {
    let width: number = c.length * n;
    for (let _ = 0; _ < width - s.length; _++) {
        s = c + s;
    }
    return s;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(".", 0, "99"),".");
}

test();
