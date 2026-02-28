function f(s: string): {[key: string]: number} {
    const count: {[key: string]: number} = {};
    for (const i of s) {
        if (i.toLowerCase() === i) {
            count[i] = s.split(i).length - 1 + (count[i] || 0);
        } else {
            count[i.toLowerCase()] = s.split(i.toUpperCase()).length - 1 + (count[i.toLowerCase()] || 0);
        }
    }
    return count;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("FSA"),{"f": 1, "s": 1, "a": 1});
}

test();
