function f(text){
    let ws = 0;
    for(let i = 0; i < text.length; i++){
        if(text[i] === ' '){
            ws++;
        }
    }
    return [ws, text.length];
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("jcle oq wsnibktxpiozyxmopqkfnrfjds"),[2, 34]);
}

test();
