function f(d: {[key: string]: number}): [string, {[key: string]: number}] {
    let keys = Object.keys(d);
    let i = keys.length - 1;
    let key = keys[i];
    delete d[key];
    return [key, d];
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"e": 1, "d": 2, "c": 3}),["c", {"e": 1, "d": 2}]);
}

test();
