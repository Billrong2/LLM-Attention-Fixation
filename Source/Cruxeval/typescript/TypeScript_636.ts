function f(d: {[key: number]: string}): {[key: number]: string} {
    let r: {[key: number]: string} = {};
    while (Object.keys(d).length > 0) {
        r = {...r, ...d};
        delete d[Math.max(...Object.keys(d).map(Number))];
    }
    return r;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({3: "A3", 1: "A1", 2: "A2"}),{3: "A3", 1: "A1", 2: "A2"});
}

test();
