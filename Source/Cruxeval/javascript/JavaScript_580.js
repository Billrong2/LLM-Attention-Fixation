function f(text, char){
    let new_text = text;
    let a = [];
    while (new_text.includes(char)) {
        a.push(new_text.indexOf(char));
        new_text = new_text.replace(char, "");
    }
    return a;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("rvr", "r"),[0, 1]);
}

test();
