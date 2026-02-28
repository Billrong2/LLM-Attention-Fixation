function f(array: number[]): number[] {
    let output = array.slice(); // copying the array
    output.filter((_, index) => index % 2 === 0).reverse().forEach((value, index) => output[output.length - 1 - index * 2] = value);
    return output;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([]),[]);
}

test();
