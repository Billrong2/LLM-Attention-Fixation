function f(n){
    if (String(n).indexOf('.') !== -1) {
        return String(parseInt(n) + 2.5);
    }
    return String(n);
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("800"),"800");
}

test();
