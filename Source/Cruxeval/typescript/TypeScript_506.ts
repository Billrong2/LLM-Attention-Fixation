function f(n: number): string {
    let p: string = '';
    if (n % 2 === 1) {
        p += 'sn';
    } else {
        return (n * n).toString();
    }
    for (let x = 1; x <= n; x++) {
        if (x % 2 === 0) {
            p += 'to';
        } else {
            p += 'ts';
        }
    }
    return p;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(1),"snts");
}

test();
