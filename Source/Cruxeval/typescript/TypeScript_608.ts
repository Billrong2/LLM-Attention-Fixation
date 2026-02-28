function f(aDict: {[key: number]: number}): {[key: number]: number} {
    return Object.entries(aDict).reduce((obj, [k, v]) => {
        obj[v] = Number(k);
        return obj;
    }, {} as {[key: number]: number});
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({1: 1, 2: 2, 3: 3}),{1: 1, 2: 2, 3: 3});
}

test();
