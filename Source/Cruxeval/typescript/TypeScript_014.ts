function f(s: string): string {
    const arr: string[] = s.trim().split('');
    arr.reverse();
    return arr.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("   OOP   "),"POO");
}

test();
