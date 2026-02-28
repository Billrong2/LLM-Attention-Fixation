function f(array){
    let a = [];
    array.reverse();
    for (let i = 0; i < array.length; i++) {
        if (array[i] !== 0) {
            a.push(array[i]);
        }
    }
    a.reverse();
    return a;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([]),[]);
}

test();
