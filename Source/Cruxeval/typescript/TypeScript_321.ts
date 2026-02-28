function f(update: {[key: string]: number}, starting: {[key: string]: number}): {[key: string]: number} {
    const d: {[key: string]: number} = {...starting};
    for (const k in update) {
        if (k in d) {
            d[k] += update[k];
        } else {
            d[k] = update[k];
        }
    }
    return d;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({}, {"desciduous": 2}),{"desciduous": 2});
}

test();
