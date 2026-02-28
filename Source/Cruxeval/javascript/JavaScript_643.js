function f(text, suffix){
    if(text.endsWith(suffix)){
        text = text.slice(0, -1) + text.slice(-1).toUpperCase();
    }
    return text;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("damdrodm", "m"),"damdrodM");
}

test();
