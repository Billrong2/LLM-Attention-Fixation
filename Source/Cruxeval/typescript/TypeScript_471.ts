function f(val: string, text: string): number {
    const indices: number[] = text.split('').map((char, index) => char === val ? index : -1).filter(index => index !== -1);
    if (indices.length === 0) {
        return -1;
    } else {
        return indices[0];
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("o", "fnmart"),-1);
}

test();
