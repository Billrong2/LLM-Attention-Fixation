function f(text: string): boolean {
    return text.split('').join('').trim() === '';
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(" 	  　"),true);
}

test();
