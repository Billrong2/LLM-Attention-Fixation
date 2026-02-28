function f(dict1, dict2){
    let result = Object.assign({}, dict1);
    for (let key in dict2) {
        result[key] = dict2[key];
    }
    return result;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"disface": 9, "cam": 7}, {"mforce": 5}),{"disface": 9, "cam": 7, "mforce": 5});
}

test();
