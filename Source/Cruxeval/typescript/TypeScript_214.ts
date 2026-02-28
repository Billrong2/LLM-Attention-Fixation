function f(sample: string): number {
    let i = -1;
    while (sample.indexOf('/', i + 1) !== -1) {
        i = sample.indexOf('/', i + 1);
    }
    return sample.lastIndexOf('/', i - 1);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("present/here/car%2Fwe"),7);
}

test();
