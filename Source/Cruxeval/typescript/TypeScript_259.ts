function f(text: string): string {
    let new_text: string[] = [];
    for(let character of text) {
        if (character === character.toUpperCase() && character !== character.toLowerCase()) {
            new_text.splice(Math.floor(new_text.length / 2), 0, character);
        }
    }
    if (new_text.length === 0) {
        new_text = ['-'];
    }
    return new_text.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("String matching is a big part of RexEx library."),"RES");
}

test();
