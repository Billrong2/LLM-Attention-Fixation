function f(original: {[key: number]: number}, string: {[key: number]: number}): {[key: number]: number} {
    let temp: {[key: number]: number} = {...original};
    for (let key in string) {
        temp[string[key]] = parseInt(key);
    }
    return temp;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({1: -9, 0: -7}, {1: 2, 0: 3}),{1: -9, 0: -7, 2: 1, 3: 0});
}

test();
