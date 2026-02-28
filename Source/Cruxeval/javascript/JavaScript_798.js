function f(text, pre){
    if (!text.startsWith(pre)) {
        return text;
    }
    return text.substring(pre.length);
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("@hihu@!", "@hihu"),"@!");
}

test();
