function f(text: string, letter: string): string {
    if (letter === letter.toLowerCase()) letter = letter.toUpperCase();
    text = Array.from(text).map(char => char === letter ? letter.toUpperCase() : char).join('');
    return text.charAt(0).toUpperCase() + text.slice(1);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("E wrestled evil until upperfeat", "e"),"E wrestled evil until upperfeat");
}

test();
