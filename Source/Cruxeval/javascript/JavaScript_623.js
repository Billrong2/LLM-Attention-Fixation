function f(text, rules){
    for(let rule of rules){
        if(rule === '@'){
            text = text.split('').reverse().join('');
        }
        else if(rule === '~'){
            text = text.toUpperCase();
        }
        else if(text && text.charAt(text.length-1) === rule){
            text = text.slice(0, text.length-1);
        }
    }
    return text;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("hi~!", ["~", "`", "!", "&"]),"HI~");
}

test();
