function f(char_freq: {[key: string]: number}): {[key: string]: number} {
    const result: {[key: string]: number} = {};
    for (const [k, v] of Object.entries({...char_freq})) {
        result[k] = Math.floor(v / 2);
    }
    return result;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"u": 20, "v": 5, "b": 7, "w": 3, "x": 3}),{"u": 10, "v": 2, "b": 3, "w": 1, "x": 1});
}

test();
