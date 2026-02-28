function f(num, name){
    let f_str = 'quiz leader = {}, count = {}';
    return f_str.replace('{}', name).replace('{}', num);
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(23, "Cornareti"),"quiz leader = Cornareti, count = 23");
}

test();
