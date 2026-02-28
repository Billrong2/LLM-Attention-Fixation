function f(s: string): string {
    let a: string[] = s.split('').filter(char => char !== ' ');
    let b: string[] = a.slice();
    for (let i = a.length - 1; i >= 0; i--) {
        if (a[i] === ' ') {
            b.pop();
        } else {
            break;
        }
    }
    return b.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("hi "),"hi");
}

test();
