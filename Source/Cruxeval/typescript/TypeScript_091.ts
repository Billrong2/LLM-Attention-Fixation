function f(s: string): string[] {
    const d: { [key: string]: number } = {};
    const keys = Array.from(new Set(s.split('')));
    return keys;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("12ab23xy"),["1", "2", "a", "b", "3", "x", "y"]);
}

test();
