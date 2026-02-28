function f(n: number): number[] {
    const values: { [key: number]: number | string } = {0: 3, 1: 4.5, 2: '-'}
    const res: { [key: number]: number } = {};
    for (let i in values) {
        let j = values[i];
        if (parseInt(i) % n !== 2) {
            res[j] = Math.floor(n / 2);
        }
    }
    return Object.keys(res).sort().map(Number);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(12),[3, 4.5]);
}

test();
