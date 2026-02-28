function f(text: string): number {
    const [string_a, string_b] = text.split(',');
    return -(string_a.length + string_b.length);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("dog,cat"),-6);
}

test();
