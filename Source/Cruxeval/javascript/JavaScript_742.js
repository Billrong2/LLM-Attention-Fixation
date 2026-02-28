function f(text){
    let b = true;
    for(let x of text){
        if(!isNaN(x)){
            b = true;
        } else {
            b = false;
            break;
        }
    }
    return b;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("-1-3"),false);
}

test();
