function f(key, value){
    var dict_ = {};
    dict_[key] = value;
    return Object.entries(dict_)[0];
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("read", "Is"),["read", "Is"]);
}

test();
