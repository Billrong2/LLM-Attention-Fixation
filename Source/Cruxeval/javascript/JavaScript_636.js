function f(d) {
    let r = {};
    while (Object.keys(d).length > 0) {
        r = {...r, ...d};
        delete d[Math.max(...Object.keys(d))];
    }
    return r;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({3: "A3", 1: "A1", 2: "A2"}),{3: "A3", 1: "A1", 2: "A2"});
}

test();
