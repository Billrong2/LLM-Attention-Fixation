function f(txt: string): number {
    let coincidences: {[key: string]: number} = {};
    for (let c of txt) {
        if (coincidences[c]) {
            coincidences[c] += 1;
        } else {
            coincidences[c] = 1;
        }
    }
    return Object.values(coincidences).reduce((acc, val) => acc + val, 0);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("11 1 1"),6);
}

test();
