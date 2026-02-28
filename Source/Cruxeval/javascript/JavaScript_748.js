function f(d){
    let keys = Object.keys(d);
    let values = Object.values(d);
    return [ [keys[0], values[0]], [keys[1], values[1]] ];
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"a": 123, "b": 456, "c": 789}),[["a", 123], ["b", 456]]);
}

test();
