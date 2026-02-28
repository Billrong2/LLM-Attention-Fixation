function f(text, sign){
    let length = text.length;
    let new_text = text.split('');
    let sign_arr = sign.split('');
    for(let i = 0; i < sign_arr.length; i++){
        let index = Math.floor((i * length - 1) / 2) + Math.floor((i + 1) / 2);
        new_text.splice(index, 0, sign_arr[i]);
    }
    return new_text.join('');
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("akoon", "sXo"),"akoXoosn");
}

test();
