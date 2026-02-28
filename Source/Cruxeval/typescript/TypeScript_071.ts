function f(d: {[key: number]: number}, n: number): {[key: number]: number} {
    for(let i = 0; i < n; i++) {
        const item = Object.entries(d).pop();
        delete d[item[0]];
        d[item[1]] = parseInt(item[0]);
    }
    return d;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({1: 2, 3: 4, 5: 6, 7: 8, 9: 10}, 1),{1: 2, 3: 4, 5: 6, 7: 8, 10: 9});
}

test();
