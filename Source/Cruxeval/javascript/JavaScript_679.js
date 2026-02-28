function f(text){
    if (text === '') {
        return false;
    }
    var first_char = text[0];
    if (!isNaN(parseInt(text[0]))) {
        return false;
    }
    for (var i = 0; i < text.length; i++) {
        var last_char = text[i];
        if (last_char !== '_' && !last_char.match(/[a-zA-Z0-9_]/)) {
            return false;
        }
    }
    return true;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("meet"),true);
}

test();
