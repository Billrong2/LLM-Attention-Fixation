function f(d){
    let l = [];
    while (Object.keys(d).length > 0) {
        let key = Object.keys(d)[Object.keys(d).length - 1];
        l.push(key);
        delete d[key];
    }
    return l;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"f": 1, "h": 2, "j": 3, "k": 4}),["k", "j", "h", "f"]);
}

test();
