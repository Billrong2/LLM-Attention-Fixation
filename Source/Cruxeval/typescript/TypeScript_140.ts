function f(st: string): string {
    let lowerSt = st.toLowerCase();
    let rindexH = lowerSt.lastIndexOf('h');
    if (lowerSt.lastIndexOf('i', rindexH) >= lowerSt.lastIndexOf('i')) {
        return 'Hey';
    } else {
        return 'Hi';
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("Hi there"),"Hey");
}

test();
