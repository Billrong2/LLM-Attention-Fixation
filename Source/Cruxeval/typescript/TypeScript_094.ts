function f(a: {[key: string]: number}, b: {[key: string]: number}): {[key: string]: number} {
    return {...a, ...b};
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"w": 5, "wi": 10}, {"w": 3}),{"w": 3, "wi": 10});
}

test();
