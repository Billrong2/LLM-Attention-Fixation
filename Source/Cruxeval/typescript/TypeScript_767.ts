function f(text: string): string {
    let a: string[] = text.trim().split(' ');
    for (let i = 0; i < a.length; i++) {
        if (isNaN(Number(a[i]))) {
            return '-';
        }
    }
    return a.join(' ');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("d khqw whi fwi bbn 41"),"-");
}

test();
