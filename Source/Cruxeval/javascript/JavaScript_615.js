function f(in_list, num){
    in_list.push(num);
    return in_list.slice(0, -1).indexOf(Math.max(...in_list.slice(0, -1)));
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([-1, 12, -6, -2], -1),1);
}

test();
