function f(d1, d2){
    let mmax = 0;
    for (let k1 in d1) {
        let p = d1[k1].length + (d2[k1] ? d2[k1].length : 0);
        if (p > mmax) {
            mmax = p;
        }
    }
    return mmax;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({0: [], 1: []}, {0: [0, 0, 0, 0], 2: [2, 2, 2]}),4);
}

test();
