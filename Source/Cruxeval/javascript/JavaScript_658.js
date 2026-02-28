function f(d, get_ary){
    let result = [];
    for (let key of get_ary) {
        result.push(d[key]);
    }
    return result;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({3: "swims like a bull"}, [3, 2, 5]),["swims like a bull", undefined, undefined]);
}

test();
