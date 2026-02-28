function f(d){
    let r = {
        c: Object.assign({}, d),
        d: Object.assign({}, d)
    };
    return [r.c === r.d, JSON.stringify(r.c) === JSON.stringify(r.d)];
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"i": "1", "love": "parakeets"}),[false, true]);
}

test();
