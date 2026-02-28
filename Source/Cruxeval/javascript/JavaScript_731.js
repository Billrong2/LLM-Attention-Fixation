function f(text, use){
    return text.split(use).join('');
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("Chris requires a ride to the airport on Friday.", "a"),"Chris requires  ride to the irport on Fridy.");
}

test();
