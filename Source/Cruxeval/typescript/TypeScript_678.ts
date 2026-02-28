function f(text: string): {[key: string]: number} {
    const freq: {[key: string]: number} = {};
    for (const c of text.toLowerCase()) {
        if (freq[c]) {
            freq[c] += 1;
        } else {
            freq[c] = 1;
        }
    }
    return freq;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("HI"),{"h": 1, "i": 1});
}

test();
