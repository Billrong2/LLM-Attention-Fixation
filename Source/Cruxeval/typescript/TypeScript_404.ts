function f(no: string[]): number {
    const d: { [key: string]: boolean } = {};
    no.forEach(item => d[item] = false);
    return Object.keys(d).length;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["l", "f", "h", "g", "s", "b"]),6);
}

test();
