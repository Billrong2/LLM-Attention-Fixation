function f(char_map, text){
    let new_text = '';
    for(let i = 0; i < text.length; i++){
        let ch = text[i];
        let val = char_map[ch];
        if (val === undefined){
            new_text += ch;
        } else {
            new_text += val;
        }
    }
    return new_text;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({}, "hbd"),"hbd");
}

test();
