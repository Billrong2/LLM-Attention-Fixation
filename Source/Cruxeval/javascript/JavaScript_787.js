function f(text){
    if (text.length === 0) {
        return '';
    }
    text = text.toLowerCase();
    return text.charAt(0).toUpperCase() + text.slice(1);
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("xzd"),"Xzd");
}

test();
