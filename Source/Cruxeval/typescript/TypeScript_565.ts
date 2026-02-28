function f(text: string): number {
    return Math.max(...Array.from('aeiou', ch => text.indexOf(ch)));
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("qsqgijwmmhbchoj"),13);
}

test();
