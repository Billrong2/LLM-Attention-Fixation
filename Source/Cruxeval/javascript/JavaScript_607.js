function f(text){
    var punctuations = ['.', '!', '?'];
    for (var i = 0; i < punctuations.length; i++) {
        if (text.endsWith(punctuations[i])) {
            return true;
        }
    }
    return false;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(". C."),true);
}

test();
