function f(text){
    let new_text = [];
    for (let i = 0; i < Math.floor(text.length / 3); i++) {
        new_text.push(`< ${text.slice(i * 3, i * 3 + 3)} level=${i} >`);
    }
    let last_item = text.slice(Math.floor(text.length / 3) * 3);
    new_text.push(`< ${last_item} level=${Math.floor(text.length / 3)} >`);
    return new_text;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("C7"),["< C7 level=0 >"]);
}

test();
