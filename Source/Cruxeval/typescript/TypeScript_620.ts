function f(x: string): string {
    return x.split('').reverse().join(' ');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("lert dna ndqmxohi3"),"3 i h o x m q d n   a n d   t r e l");
}

test();
