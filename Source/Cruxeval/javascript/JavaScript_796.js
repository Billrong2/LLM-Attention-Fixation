function f(str, toget){
    if (str.startsWith(toget)) {
        return str.slice(toget.length);
    } else {
        return str;
    }
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("fnuiyh", "ni"),"fnuiyh");
}

test();
