function f(text){
    var n = parseInt(text.indexOf('8'));
    return 'x0'.repeat(n);
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("sa832d83r xd 8g 26a81xdf"),"x0x0");
}

test();
