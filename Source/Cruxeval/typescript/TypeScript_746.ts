function f(dct: {[key: string]: string}): {[key: string]: string} {
    const values = Object.values(dct);
    const result: {[key: string]: string} = {};
    values.forEach((value) => {
        const item = value.split('.')[0] + '@pinc.uk';
        result[value] = item;
    });
    return result;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({}),{});
}

test();
