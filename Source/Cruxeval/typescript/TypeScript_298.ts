function f(text: string): string {
    let new_text = text.split('');
    for (let i = 0; i < new_text.length; i++) {
        let character = new_text[i];
        let new_character = character === character.toUpperCase() ? character.toLowerCase() : character.toUpperCase();
        new_text[i] = new_character;
    }
    return new_text.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("dst vavf n dmv dfvm gamcu dgcvb."),"DST VAVF N DMV DFVM GAMCU DGCVB.");
}

test();
