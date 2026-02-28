function f(text: string): number {
    return text.split(':')[0].split('').filter(char => char === '#').length;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("#! : #!"),1);
}

test();
