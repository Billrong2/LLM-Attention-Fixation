function f(text){
    let out = "";
    for(let i = 0; i < text.length; i++){
        if(text[i] === text[i].toUpperCase()){
            out += text[i].toLowerCase();
        } else {
            out += text[i].toUpperCase();
        }
    }
    return out;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(",wPzPppdl/"),",WpZpPPDL/");
}

test();
