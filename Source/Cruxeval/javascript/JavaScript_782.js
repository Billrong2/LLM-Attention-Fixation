function f(input){
    for(let char of input){
        if(char === char.toUpperCase()){
            return false;
        }
    }
    return true;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("a j c n x X k"),false);
}

test();
