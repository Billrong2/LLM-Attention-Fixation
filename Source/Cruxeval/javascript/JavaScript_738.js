function f(text, characters){
    for (let i = 0; i < characters.length; i++) {
        text = text.replace(new RegExp(`${characters[i]}$`,'g'), '');
    }
    return text;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("r;r;r;r;r;r;r;r;r", "x.r"),"r;r;r;r;r;r;r;r;");
}

test();
