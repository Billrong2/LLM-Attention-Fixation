function f(values: string[], value: number): {[key: string]: number} {
    const length: number = values.length;
    const new_dict: {[key: string]: number} = {};
    values.forEach(v => {
        new_dict[v] = value;
    });
    new_dict[values.sort().join('')] = value * 3;
    return new_dict;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["0", "3"], 117),{"0": 117, "3": 117, "03": 351});
}

test();
