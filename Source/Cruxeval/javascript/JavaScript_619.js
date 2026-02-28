function f(title){
    return title.toLowerCase();
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("   Rock   Paper   SCISSORS  "),"   rock   paper   scissors  ");
}

test();
