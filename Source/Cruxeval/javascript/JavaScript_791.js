function f(integer, n){
    let i = 1;
    let text = integer.toString();
    while (i + text.length < n) {
        i += text.length;
    }
    return text.padStart(i + text.length, '0');
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(8999, 2),"08999");
}

test();
