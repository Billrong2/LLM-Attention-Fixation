function f(phrase){
    let result = '';
    for(let i of phrase){
        if(i.toUpperCase() === i){
            result += i;
        }
    }
    return result;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("serjgpoDFdbcA."),"DFA.");
}

test();
