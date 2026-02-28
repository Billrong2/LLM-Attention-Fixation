function f(st, pattern){
    for(let p of pattern){
        if(!st.startsWith(p)){
            return false;
        }
        st = st.substring(p.length);
    }
    return true;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("qwbnjrxs", ["jr", "b", "r", "qw"]),false);
}

test();
