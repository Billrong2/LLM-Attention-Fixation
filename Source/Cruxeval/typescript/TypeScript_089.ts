function f(char: string): string {
    if (!'aeiouAEIOU'.includes(char)) {
        return null;
    }
    if ('AEIOU'.includes(char)) {
        return char.toLowerCase();
    }
    return char.toUpperCase();
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("o"),"O");
}

test();
