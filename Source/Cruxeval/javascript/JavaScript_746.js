function f(dct){
    let values = Object.values(dct);
    let result = {};
    for (let value of values) {
        let item = value.split('.')[0] + '@pinc.uk';
        result[value] = item;
    }
    return result;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({}),{});
}

test();
