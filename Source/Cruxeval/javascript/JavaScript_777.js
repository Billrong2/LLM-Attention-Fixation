function f(names, excluded){
    let result = names.map(name => name.replace(excluded, ""));
    return result;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["avc  a .d e"], ""),["avc  a .d e"]);
}

test();
