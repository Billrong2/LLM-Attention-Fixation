function f(array: {[key: number]: number}, elem: number): {[key: number]: number} {
    let result = {...array};
    while (Object.keys(result).length > 0) {
        let key = parseInt(Object.keys(result)[0]);
        let value = result[key];
        if (elem === key || elem === value) {
            result = {...array, ...result};
        }
        delete result[key];
    }
    return result;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({}, 1),{});
}

test();
