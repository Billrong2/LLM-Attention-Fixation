function f(ets: {[key: number]: number}): {[key: number]: number} {
    while (Object.keys(ets).length > 0) {
        let [k, v] = Object.entries(ets).pop() as [string, number];
        ets[parseInt(k)] = Math.pow(v, 2);
    }
    return ets;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({}),{});
}

test();
