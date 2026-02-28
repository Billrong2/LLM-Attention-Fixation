function f(a, b){
    let d = {};
    for (let i = 0; i < a.length; i++) {
        d[a[i]] = b[i];
    }

    a.sort((x, y) => d[y] - d[x]);

    return a.map(x => d[x]);
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["12", "ab"], [2, 2]),[2, 2]);
}

test();
