function f(n: string): number {
    for (let i of n) {
        if (isNaN(parseInt(i))) {
            n = '-1';
            break;
        }
    }
    return parseInt(n);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("6 ** 2"),-1);
}

test();
