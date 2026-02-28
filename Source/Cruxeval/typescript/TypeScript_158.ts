function f(arr: number[]): number[] {
    const n = arr.filter(item => item % 2 === 0);
    const m = n.concat(arr);
    for (let i of m) {
        if (m.indexOf(i) >= n.length) {
            m.splice(m.indexOf(i), 1);
        }
    }
    return m;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([3, 6, 4, -2, 5]),[6, 4, -2, 6, 4, -2]);
}

test();
