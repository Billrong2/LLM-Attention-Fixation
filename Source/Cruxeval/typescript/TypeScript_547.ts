function f(letters: string): string {
    const letters_only: string = letters.replace(/^[., !?*]+|[., !?*]+$/g, '');
    return letters_only.split(" ").join("....");
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("h,e,l,l,o,wo,r,ld,"),"h,e,l,l,o,wo,r,ld");
}

test();
