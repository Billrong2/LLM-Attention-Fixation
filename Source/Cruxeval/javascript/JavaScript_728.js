function f(text){
    let result = [];
    for(let i = 0; i < text.length; i++){
        let ch = text[i];
        if(ch === ch.toLowerCase()){
            continue;
        }
        if(text.length - 1 - i < text.lastIndexOf(ch.toLowerCase())){
            result.push(ch);
        }
    }
    return result.join('');
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("ru"),"");
}

test();
