function f(letters, maxsplit){
    return letters.split(' ').slice(-maxsplit).join('');
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("elrts,SS ee", 6),"elrts,SSee");
}

test();
