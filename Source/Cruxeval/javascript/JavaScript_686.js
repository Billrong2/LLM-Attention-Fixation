function f(d, l){
    let new_d = {};

    l.forEach(k => {
        if (d[k] !== undefined) {
            new_d[k] = d[k];
        }
    });

    return Object.assign({}, new_d);
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"lorem ipsum": 12, "dolor": 23}, ["lorem ipsum", "dolor"]),{"lorem ipsum": 12, "dolor": 23});
}

test();
