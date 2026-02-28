function f(d){
    let result = {};
    for (let ki in d) {
        result[ki] = [];
        for (let kj = 0; kj < d[ki].length; kj++) {
            result[ki].push({});
            for (let kk in d[ki][kj]) {
                result[ki][kj][kk] = Object.assign({}, d[ki][kj][kk]);
            }
        }
    }
    return result;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({}),{});
}

test();
