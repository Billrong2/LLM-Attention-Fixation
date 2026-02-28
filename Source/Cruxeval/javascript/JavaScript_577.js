function f(items) {
    let result = [];
    for (let i = 0; i < items.length; i++) {
        let d = Object.fromEntries(items.slice(0, i));
        result.push(d);
    }
    return result;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([[1, "pos"]]),[{}]);
}

test();
