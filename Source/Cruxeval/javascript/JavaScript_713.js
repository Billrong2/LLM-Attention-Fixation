function f(text, char){
    if (text.includes(char)) {
        text = text.split(char).map(t => t.trim()).filter(t => t.length > 0);
        if (text.length > 1) {
            return true;
        }
    }
    return false;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("only one line", " "),true);
}

test();
