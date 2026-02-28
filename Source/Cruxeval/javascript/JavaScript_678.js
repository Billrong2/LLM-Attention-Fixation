function f(text){
    let freq = {};
    text.toLowerCase().split('').forEach(c => {
        freq[c] = (freq[c] || 0) + 1;
    });
    return freq;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("HI"),{"h": 1, "i": 1});
}

test();
