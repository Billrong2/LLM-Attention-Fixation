function f(d: {[key: string]: number}): {[key: string]: number} {
    let dCopy = { ...d };
    delete dCopy[Object.keys(dCopy)[Object.keys(dCopy).length - 1]];
    return dCopy;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"l": 1, "t": 2, "x:": 3}),{"l": 1, "t": 2});
}

test();
