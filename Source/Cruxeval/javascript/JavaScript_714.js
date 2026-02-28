function f(array){
    array.reverse();
    array.splice(0, array.length);
    array.push(...Array(array.length).fill('x'));
    array.reverse();
    return array;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([3, -2, 0]),[]);
}

test();
