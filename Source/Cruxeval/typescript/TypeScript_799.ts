function f(st: string): string {
    if (st[0] === '~') {
        let e: string = st.padStart(10, 's');
        return f(e);
    } else {
        return st.padStart(10, 'n');
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("eqe-;ew22"),"neqe-;ew22");
}

test();
