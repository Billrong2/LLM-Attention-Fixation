function f(text){
    let a = text.trim().split(' ');
    for (let i = 0; i < a.length; i++) {
        if (isNaN(parseInt(a[i]))) {
            return '-';
        }
    }
    return a.join(' ');
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("d khqw whi fwi bbn 41"),"-");
}

test();
