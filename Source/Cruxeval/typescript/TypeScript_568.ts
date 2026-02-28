function f(num: string): string {
    let letter: number = 1;
    for (const i of '1234567890') {
        num = num.replace(i, '');
        if (num.length === 0) break;
        num = num.slice(letter) + num.slice(0, letter);
        letter++;
    }
    return num;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("bwmm7h"),"mhbwm");
}

test();
