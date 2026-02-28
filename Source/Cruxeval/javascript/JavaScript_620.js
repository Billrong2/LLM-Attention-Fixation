function f(x){
    return x.split('').reverse().join(' ');
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("lert dna ndqmxohi3"),"3 i h o x m q d n   a n d   t r e l");
}

test();
