function f(text: string, digit: string): number {
    const count: number = text.split(digit).length - 1;
    return parseInt(digit, 10) * count;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("7Ljnw4Lj", "7"),7);
}

test();
