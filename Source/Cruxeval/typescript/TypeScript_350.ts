function f(d: {[key: string]: number}): number[] {
    const size: number = Object.keys(d).length;
    const v: number[] = new Array(size).fill(0);
    if (size === 0) {
        return v;
    }
    const values = Object.values(d);
    for (let i = 0; i < size; i++) {
        v[i] = values[i];
    }
    return v;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"a": 1, "b": 2, "c": 3}),[1, 2, 3]);
}

test();
