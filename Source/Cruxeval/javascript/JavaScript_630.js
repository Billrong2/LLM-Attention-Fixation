function f(original, string){
    let temp = {...original};
    for (let [a, b] of Object.entries(string)) {
        temp[b] = a;
    }
    return temp;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({1: -9, 0: -7}, {1: 2, 0: 3}),{1: -9, 0: -7, 2: 1, 3: 0});
}

test();
