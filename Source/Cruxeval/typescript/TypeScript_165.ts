function f(text: string, lower: number, upper: number): boolean {
    return text.substring(lower, upper).split('').every(char => char.charCodeAt(0) < 128);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("=xtanp|sugv?z", 3, 6),true);
}

test();
