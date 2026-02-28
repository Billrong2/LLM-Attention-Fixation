function f(text){
    text = text.split(' ');
    for (let t of text) {
        if (isNaN(t)) {
            return 'no';
        }
    }
    return 'yes';
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("03625163633 d"),"no");
}

test();
