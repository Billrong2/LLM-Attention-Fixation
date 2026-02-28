function f(keys: number[], value: number): {[key: number]: number} {
    const d: {[key: number]: number} = {};
    keys.forEach(key => {
        d[key] = value;
    });

    Object.keys(d).forEach((key, index) => {
        if (d[parseInt(key)] === d[index + 1]) {
            delete d[index + 1];
        }
    });

    return d;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 2, 1, 1], 3),{});
}

test();
