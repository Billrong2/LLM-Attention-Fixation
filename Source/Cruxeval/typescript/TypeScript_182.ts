function f(dic: {[key: string]: number}): [string, number][] {
    return Object.entries(dic).sort((a, b) => a[0].localeCompare(b[0]));
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"b": 1, "a": 2}),[["a", 2], ["b", 1]]);
}

test();
