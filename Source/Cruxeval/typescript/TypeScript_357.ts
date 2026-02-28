function f(s: string): string {
    let r: string[] = [];
    for (let i = s.length - 1; i >= 0; i--) {
        r.push(s[i]);
    }
    return r.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("crew"),"werc");
}

test();
