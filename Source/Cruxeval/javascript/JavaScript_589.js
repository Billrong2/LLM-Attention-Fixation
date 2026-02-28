function f(num){
    num.push(num[num.length - 1]);
    return num;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([-70, 20, 9, 1]),[-70, 20, 9, 1, 1]);
}

test();
