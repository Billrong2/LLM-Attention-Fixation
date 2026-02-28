function f(char_freq){
    let result = {};
    for (let [k, v] of Object.entries({...char_freq})) {
        result[k] = Math.floor(v / 2);
    }
    return result;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"u": 20, "v": 5, "b": 7, "w": 3, "x": 3}),{"u": 10, "v": 2, "b": 3, "w": 1, "x": 1});
}

test();
