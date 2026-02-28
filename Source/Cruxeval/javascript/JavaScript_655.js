function f(s){
    return s.split('a').join('').split('r').join('');
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("rpaar"),"p");
}

test();
