function f(string: string, sep: string): string {
    const cnt: number = string.split(sep).length - 1;
    return (string + sep).repeat(cnt).split('').reverse().join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("caabcfcabfc", "ab"),"bacfbacfcbaacbacfbacfcbaac");
}

test();
