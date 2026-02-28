function f(numbers, prefix){
    return numbers.map(n => n.substring(prefix.length)).filter(n => n.startsWith(prefix)).sort();
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["ix", "dxh", "snegi", "wiubvu"], ""),["dxh", "ix", "snegi", "wiubvu"]);
}

test();
