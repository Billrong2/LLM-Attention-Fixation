function f(text, length, index){
    let ls = text.split(/\s+/).slice(-index);
    return ls.map(l => l.slice(0, length)).join('_');
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("hypernimovichyp", 2, 2),"hy");
}

test();
