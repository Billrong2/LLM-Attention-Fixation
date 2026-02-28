function f(text, letter){
    let t = text;
    for(let alph of text){
        t = t.replace(new RegExp(alph, 'g'), "");
    }
    return t.split(letter).length;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("c, c, c ,c, c", "c"),1);
}

test();
