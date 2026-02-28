function f(array, ind, elem){
    let index = ind < 0 ? -5 : ind > array.length ? array.length : ind + 1;
    array.splice(index, 0, elem);
    return array;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 5, 8, 2, 0, 3], 2, 7),[1, 5, 8, 7, 2, 0, 3]);
}

test();
