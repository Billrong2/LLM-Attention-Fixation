function f(text){
    let count = text.split(text[0]).length - 1;
    let ls = text.split('');
    for (let i = 0; i < count; i++) {
        ls.shift();
    }
    return ls.join('');
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(";,,,?"),",,,?");
}

test();
