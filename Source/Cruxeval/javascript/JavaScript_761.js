function f(array){
    let output = array.slice();
    output.filter((element, index) => index % 2 === 0).forEach((element, index) => {
        output[output.length - 1 - index * 2] = element;
    });
    output.reverse();
    return output;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([]),[]);
}

test();
