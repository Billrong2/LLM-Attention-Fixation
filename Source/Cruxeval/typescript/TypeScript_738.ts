function f(text: string, characters: string): string {
    for (let i = 0; i < characters.length; i++) {
        text = text.replace(new RegExp(`${characters[i]}\$`, 'g'), '');
    }
    return text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("r;r;r;r;r;r;r;r;r", "x.r"),"r;r;r;r;r;r;r;r;");
}

test();
