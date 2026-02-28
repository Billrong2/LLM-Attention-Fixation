function f(text){
    let count = 0;
    for(let i of text){
        if('.?!.,'.includes(i)){
            count++;
        }
    }
    return count;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("bwiajegrwjd??djoda,?"),4);
}

test();
