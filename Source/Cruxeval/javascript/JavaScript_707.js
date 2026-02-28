function f(text, position){
    let length = text.length;
    let index = position % (length + 1);
    if (position < 0 || index < 0) {
        index = -1;
    }
    let new_text = text.split('');
    new_text.splice(index, 1);
    return new_text.join('');
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("undbs l", 1),"udbs l");
}

test();
