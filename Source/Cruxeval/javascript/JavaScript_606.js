function f(value){
    let ls = value.split('');
    ls.push('NHIB');
    return ls.join('');
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("ruam"),"ruamNHIB");
}

test();
