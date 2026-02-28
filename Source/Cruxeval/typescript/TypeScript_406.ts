function f(text: string): boolean {
    let ls: string[] = text.split('');
    [ls[0], ls[ls.length - 1]] = [ls[ls.length - 1].toUpperCase(), ls[0].toUpperCase()];
    return ls.join('').match(/^[A-Z][a-z]* [A-Z][a-z]*$/g) !== null;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("Josh"),false);
}

test();
