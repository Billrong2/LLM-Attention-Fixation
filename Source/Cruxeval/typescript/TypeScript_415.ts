function f(array: [number, number][]): {[key: number]: number} {
    const d: {[key: number]: number} = Object.fromEntries(array);
    for (const value of Object.values(d)) {
        if (value < 0 || value > 9) {
            return null;
        }
    }
    return d;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([[8, 5], [8, 2], [5, 3]]),{8: 2, 5: 3});
}

test();
