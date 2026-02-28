function f(text, letter){
    if (letter === letter.toLowerCase()) letter = letter.toUpperCase();
    text = Array.from(text, char => char === letter ? letter.toUpperCase() : char);
    return text.join('').charAt(0).toUpperCase() + text.join('').slice(1);
}

const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("E wrestled evil until upperfeat", "e"),"E wrestled evil until upperfeat");
}

test();
