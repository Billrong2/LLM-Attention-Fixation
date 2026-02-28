function f(s, n, c){
    let width = c.length * n;
    while (s.length < width) {
        s = c + s;
    }
    return s;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(".", 0, "99"),".");
}

test();
