function f(dct: {[key: string]: number}): [string, number][] {
    const lst: [string, number][] = [];
    for (const key of Object.keys(dct).sort()) {
        lst.push([key, dct[key]]);
    }
    return lst;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"a": 1, "b": 2, "c": 3}),[["a", 1], ["b", 2], ["c", 3]]);
}

test();
