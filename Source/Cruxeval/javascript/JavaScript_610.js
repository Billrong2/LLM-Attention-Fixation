function f(keys, value){
    let d = {};
    keys.forEach(key => {
        d[key] = value;
    });

    let keysCopy = Object.keys(d);
    keysCopy.forEach((k, i) => {
        if (d[k] === d[keys[i]]) {
            delete d[keys[i]];
        }
    });

    return d;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 2, 1, 1], 3),{});
}

test();
