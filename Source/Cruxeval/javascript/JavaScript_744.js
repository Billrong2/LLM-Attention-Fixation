function f(text, new_ending){
    let result = text.split('');
    result.push(...new_ending);
    return result.join('');
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("jro", "wdlp"),"jrowdlp");
}

test();
