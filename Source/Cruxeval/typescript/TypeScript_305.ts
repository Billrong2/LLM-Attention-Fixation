function f(text: string, char: string): string {
    let length: number = text.length;
    let index: number = -1;
    for (let i = 0; i < length; i++) {
        if (text[i] === char) {
            index = i;
        }
    }
    if (index === -1) {
        index = Math.floor(length / 2);
    }
    let new_text: string[] = text.split('');
    new_text.splice(index, 1);
    return new_text.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("o horseto", "r"),"o hoseto");
}

test();
