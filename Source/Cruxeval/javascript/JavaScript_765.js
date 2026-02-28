function f(text){
    return text.split('').reduce((count, c) => {
        if (!isNaN(parseInt(c))) {
            return count + 1;
        }
        return count;
    }, 0);
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("so456"),3);
}

test();
