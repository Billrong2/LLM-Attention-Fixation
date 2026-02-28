function f(arr){
    let count = arr.length;
    let sub = arr.slice();
    for (let i = 0; i < count; i += 2) {
        sub[i] *= 5;
    }
    return sub;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([-3, -6, 2, 7]),[-15, -6, 10, 7]);
}

test();
