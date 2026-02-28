function f(text){
    return text.split('').filter(x => x !== ')').join('');
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("(((((((((((d))))))))).))))((((("),"(((((((((((d.(((((");
}

test();
