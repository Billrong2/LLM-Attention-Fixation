function f(array, elem){
    let result = {...array};
    while (Object.keys(result).length > 0) {
        let key = Object.keys(result)[0];
        let value = result[key];
        if (elem === key || elem === value) {
            result = {...array};
        }
        delete result[key];
    }
    return result;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({}, 1),{});
}

test();
