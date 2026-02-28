function f(d: {[key: number]: number}, index: number): number {
    let length = Object.keys(d).length;
    let idx = index % length;
    let v = d[Object.keys(d)[Object.keys(d).length-1]];
    for(let i=0; i<idx; i++){
        delete d[Object.keys(d)[Object.keys(d).length-1]];
    }
    return v;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({27: 39}, 1),39);
}

test();
