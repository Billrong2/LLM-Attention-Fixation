function f(dictionary){
    let a = Object.assign({}, dictionary);
    for (let key in a){
        if (key % 2 !== 0){
            delete a[key];
            a['$' + key] = a[key];
        }
    }
    return a;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({}),{});
}

test();
