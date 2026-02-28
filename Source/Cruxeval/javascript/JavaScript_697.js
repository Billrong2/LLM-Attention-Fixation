function f(s, sep){
    let sepIndex = s.indexOf(sep);
    let prefix = s.slice(0, sepIndex);
    let middle = s.slice(sepIndex, sepIndex + sep.length);
    let rightStr = s.slice(sepIndex + sep.length);
    return [prefix, middle, rightStr];
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("not it", ""),["", "", "not it"]);
}

test();
