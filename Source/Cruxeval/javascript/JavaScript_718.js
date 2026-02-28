function f(text){
    let t = text;
    for (let i of text) {
        text = text.replace(new RegExp(i, 'g'), '');
    }
    return text.length.toString() + t;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("ThisIsSoAtrocious"),"0ThisIsSoAtrocious");
}

test();
