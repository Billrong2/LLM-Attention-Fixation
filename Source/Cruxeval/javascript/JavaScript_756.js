function f(text){
    if (text.match(/^[0-9]+$/) !== null) {
        return 'integer';
    }
    return 'string';
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(""),"string");
}

test();
