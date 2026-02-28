function f(st){
    if (st[0] === '~') {
        let e = st.padStart(10, 's');
        return f(e);
    } else {
        return st.padStart(10, 'n');
    }
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("eqe-;ew22"),"neqe-;ew22");
}

test();
