function f(obj: {[key: string]: number}): {[key: string]: number} {
    for (let key in obj) {
        if (obj[key] >= 0) {
            obj[key] = -obj[key];
        }
    }
    return obj;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"R": 0, "T": 3, "F": -6, "K": 0}),{"R": 0, "T": -3, "F": -6, "K": 0});
}

test();
