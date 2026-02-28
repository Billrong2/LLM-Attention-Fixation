function f(base: string[], delta: string| string[][]): string[] {
    for (let j = 0; j < delta.length; j++) {
        for (let i = 0; i < base.length; i++) {
            if (base[i] === delta[j][0]) {
                if (delta[j][1] !== base[i]) {
                    base[i] = delta[j][1];
                } else {
                    throw new Error('Assertion Error');
                }
            }
        }
    }
    return base;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["gloss", "banana", "barn", "lawn"], []),["gloss", "banana", "barn", "lawn"]);
}

test();
