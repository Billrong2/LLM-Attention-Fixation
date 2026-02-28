function f(string: string): number {
    let upper: number = 0;
    for (let i = 0; i < string.length; i++) {
        if (string[i] === string[i].toUpperCase()) {
            upper += 1;
        }
    }
    return upper * (upper % 2 === 0 ? 2 : 1);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("PoIOarTvpoead"),8);
}

test();
