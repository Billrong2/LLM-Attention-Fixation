function f(text: string): string {
    const length: number = Math.floor(text.length / 2);
    const left_half: string = text.substring(0, length);
    const right_half: string = text.substring(length).split('').reverse().join('');
    return left_half + right_half;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("n"),"n");
}

test();
