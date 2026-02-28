function f(n: string): string {
    if (n.indexOf('.') !== -1) {
        return String(Number(n) + 2.5);
    }
    return n;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("800"),"800");
}

test();
