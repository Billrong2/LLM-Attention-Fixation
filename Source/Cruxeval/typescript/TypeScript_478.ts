function f(sb: string): {[key: string]: number} {
    const d: {[key: string]: number} = {};
    for (const s of sb) {
        d[s] = d[s] ? d[s] + 1 : 1;
    }
    return d;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("meow meow"),{"m": 2, "e": 2, "o": 2, "w": 2, " ": 1});
}

test();
