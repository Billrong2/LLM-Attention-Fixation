function f(array, elem){
    array.reverse();
    try {
        let found = array.indexOf(elem);
        return found;
    } finally {
        array.reverse();
    }
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([5, -3, 3, 2], 2),0);
}

test();
