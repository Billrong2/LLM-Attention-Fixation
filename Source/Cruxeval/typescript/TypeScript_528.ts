function f(s: string): number {
    let b: string = '';
    let c: string = '';
    for (let i of s) {
        c = c + i;
        if (s.lastIndexOf(c) > -1) {
            return s.lastIndexOf(c);
        }
    }
    return 0;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("papeluchis"),2);
}

test();
