function f(letters: string): number {
    let count: number = 0;
    for (let l of letters) {
        if (!isNaN(parseInt(l, 10))) {
            count += 1;
        }
    }
    return count;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("dp ef1 gh2"),2);
}

test();
