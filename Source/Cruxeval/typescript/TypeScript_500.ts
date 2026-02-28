function f(text: string, delim: string): string {
    return text.slice(0, text.split('').reverse().join('').indexOf(delim)).split('').reverse().join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("dsj osq wi w", " "),"d");
}

test();
