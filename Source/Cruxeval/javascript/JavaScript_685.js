function f(array, elem){
    return array.filter(item => item === elem).length + elem;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 1, 1], -2),-2);
}

test();
