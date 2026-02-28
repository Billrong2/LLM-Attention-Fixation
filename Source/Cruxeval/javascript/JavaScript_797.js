function f(dct){
    let lst = [];
    Object.keys(dct).sort().forEach(function(key) {
        lst.push([key, dct[key]]);
    });
    return lst;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"a": 1, "b": 2, "c": 3}),[["a", 1], ["b", 2], ["c", 3]]);
}

test();
