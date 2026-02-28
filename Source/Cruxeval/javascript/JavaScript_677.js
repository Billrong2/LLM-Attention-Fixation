function f(text, length){
    length = length < 0 ? -length : length;
    let output = '';
    for (let idx = 0; idx < length; idx++) {
        if (text[idx % text.length] !== ' ') {
            output += text[idx % text.length];
        } else {
            break;
        }
    }
    return output;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("I got 1 and 0.", 5),"I");
}

test();
