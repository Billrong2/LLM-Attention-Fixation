function f(text: string): number {
    let number: number = 0;
    for (let t of text) {
        if (!isNaN(parseInt(t))) {
            number += 1;
        }
    }
    return number;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("Thisisastring"),0);
}

test();
