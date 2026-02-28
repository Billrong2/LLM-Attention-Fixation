function f(text: string, num_digits: number): string {
    const width: number = Math.max(1, num_digits);
    return text.padStart(width, '0');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("19", 5),"00019");
}

test();
