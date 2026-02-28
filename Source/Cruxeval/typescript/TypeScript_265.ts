function f(d: {[key: number]: number}, k: number): {[key: number]: number} {
    const new_d: {[key: number]: number} = {};
    for (const key in d) {
        if (parseInt(key) < k) {
            new_d[parseInt(key)] = d[parseInt(key)];
        }
    }
    return new_d;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({1: 2, 2: 4, 3: 3}, 3),{1: 2, 2: 4});
}

test();
