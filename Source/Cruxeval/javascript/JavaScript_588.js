function f(items, target){
    if(items.includes(target)){
        return items.indexOf(target);
    }
    return -1;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["1", "+", "-", "**", "//", "*", "+"], "**"),3);
}

test();
