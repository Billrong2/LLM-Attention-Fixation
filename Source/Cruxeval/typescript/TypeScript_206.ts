function f(a: string): string {
    return a.trim().split(/\s+/).join(' ');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(" h e l l o   w o r l d! "),"h e l l o w o r l d!");
}

test();
