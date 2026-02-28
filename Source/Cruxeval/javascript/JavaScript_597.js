function f(s){
    return s.toUpperCase();
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("Jaafodsfa SOdofj AoaFjIs  JAFasIdfSa1"),"JAAFODSFA SODOFJ AOAFJIS  JAFASIDFSA1");
}

test();
