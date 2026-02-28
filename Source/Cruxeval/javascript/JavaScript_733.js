function f(text){
    var length = Math.floor(text.length / 2);
    var left_half = text.substring(0, length);
    var right_half = text.substring(length).split("").reverse().join("");
    return left_half + right_half;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("n"),"n");
}

test();
