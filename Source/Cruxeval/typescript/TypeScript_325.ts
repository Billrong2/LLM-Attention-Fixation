function f(s: string): boolean {
    let l: string[] = s.split('');
    for (let i = 0; i < l.length; i++) {
        l[i] = l[i].toLowerCase();
        if (isNaN(parseInt(l[i]))) {
            return false;
        }
    }
    return true;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(""),true);
}

test();
