function f(s, o){
    if(s.startsWith(o)){
        return s;
    }
    return o + f(s, o.split('').reverse().join('').slice(1));
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("abba", "bab"),"bababba");
}

test();
