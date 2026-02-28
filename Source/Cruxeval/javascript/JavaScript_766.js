function f(values, value){
    let length = values.length;
    let newDict = Object.fromEntries(values.map(key => [key, value]));
    newDict[values.sort().join('')] = value * 3;
    return newDict;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["0", "3"], 117),{"0": 117, "3": 117, "03": 351});
}

test();
