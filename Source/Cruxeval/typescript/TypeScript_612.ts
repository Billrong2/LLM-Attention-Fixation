function f(d: {[key: string]: number}): {[key: string]: number} {
    return Object.fromEntries(Object.entries(d));
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"a": 42, "b": 1337, "c": -1, "d": 5}),{"a": 42, "b": 1337, "c": -1, "d": 5});
}

test();
