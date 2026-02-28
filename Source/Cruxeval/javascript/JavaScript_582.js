function f(k, j){
    let arr = [];
    for(let i = 0; i < k; i++){
        arr.push(j);
    }
    return arr;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(7, 5),[5, 5, 5, 5, 5, 5, 5]);
}

test();
