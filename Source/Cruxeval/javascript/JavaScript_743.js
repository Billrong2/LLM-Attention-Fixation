function f(text){
    let [string_a, string_b] = text.split(',');
    return -(string_a.length + string_b.length);
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("dog,cat"),-6);
}

test();
