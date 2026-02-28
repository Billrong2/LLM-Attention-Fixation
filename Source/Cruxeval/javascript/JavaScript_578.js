function f(obj){
    for(let k in obj){
        if(obj[k] >= 0){
            obj[k] = -obj[k];
        }
    }
    return obj;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"R": 0, "T": 3, "F": -6, "K": 0}),{"R": 0, "T": -3, "F": -6, "K": 0});
}

test();
