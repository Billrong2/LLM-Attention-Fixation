function f(text){
    let letters = '';
    for(let i = 0; i < text.length; i++){
        if(text[i].match(/[a-zA-Z0-9]/)){
            letters += text[i];
        }
    }
    return letters;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("we@32r71g72ug94=(823658*!@324"),"we32r71g72ug94823658324");
}

test();
