function f(d: {[key: string]: string}): {[key: string]: string} {
    d = {};
    return d;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"a": "3", "b": "-1", "c": "Dum"}),{});
}

test();
