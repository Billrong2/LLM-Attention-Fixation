function f(text: string): number[] {
    let d: { [key: string]: number } = {};
    for (let char of text.replace(/-/g, '').toLowerCase()) {
        d[char] = d[char] + 1 || 1;
    }
    const sortedD = Object.entries(d).sort((a, b) => a[1] - b[1]);
    return sortedD.map(([key, val]) => val);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("x--y-z-5-C"),[1, 1, 1, 1, 1]);
}

test();
