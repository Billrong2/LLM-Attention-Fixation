function f(s, suffix){
    if (suffix === ''){
        return s;
    }
    while (s.endsWith(suffix)){
        s = s.slice(0, -suffix.length);
    }
    return s;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("ababa", "ab"),"ababa");
}

test();
