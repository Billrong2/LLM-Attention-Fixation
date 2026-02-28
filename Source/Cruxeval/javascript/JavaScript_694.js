function f(d) {
    let i = Object.keys(d).length - 1;
    let key = Object.keys(d)[i];
    delete d[key];
    return [key, d];
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"e": 1, "d": 2, "c": 3}),["c", {"e": 1, "d": 2}]);
}

test();
