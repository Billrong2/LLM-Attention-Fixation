function f(dict1: {[key: string]: number}, dict2: {[key: string]: number}): {[key: string]: number} {
    const result = {...dict1};
    Object.keys(dict2).forEach(key => {
        result[key] = dict2[key];
    });
    return result;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"disface": 9, "cam": 7}, {"mforce": 5}),{"disface": 9, "cam": 7, "mforce": 5});
}

test();
