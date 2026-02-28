function f(letters: string, maxsplit: number): string {
    return letters.split(' ').slice(-maxsplit).join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("elrts,SS ee", 6),"elrts,SSee");
}

test();
