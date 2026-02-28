function f(chars){
    let s = "";
    for(let ch of chars){
        let count = chars.split(ch).length - 1;
        if(count % 2 === 0){
            s += ch.toUpperCase();
        }else{
            s += ch;
        }
    }
    return s;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("acbced"),"aCbCed");
}

test();
