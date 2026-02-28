function f(string){
    if (!string || isNaN(parseInt(string[0]))) {
        return 'INVALID';
    }
    let cur = 0;
    for (let i = 0; i < string.length; i++) {
        cur = cur * 10 + parseInt(string[i]);
    }
    return cur.toString();
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("3"),"3");
}

test();
