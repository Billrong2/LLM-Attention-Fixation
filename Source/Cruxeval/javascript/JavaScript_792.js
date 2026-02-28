function f(l1, l2){
    if(l1.length !== l2.length){
        return {};
    }
    let result = {};
    l1.forEach(key => {
        result[key] = [...l2];
    });
    return result;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["a", "b"], ["car", "dog"]),{"a": ["car", "dog"], "b": ["car", "dog"]});
}

test();
