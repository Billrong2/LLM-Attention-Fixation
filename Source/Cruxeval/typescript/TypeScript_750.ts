function f(char_map: {[key: string]: string}, text: string): string {
    let new_text = '';
    for (let ch of text) {
        let val = char_map[ch];
        if (val === undefined) {
            new_text += ch;
        } else {
            new_text += val;
        }
    }
    return new_text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({}, "hbd"),"hbd");
}

test();
