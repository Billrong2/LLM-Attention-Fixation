function f(s: string, sep: string): string {
    const reverse = s.split(sep).map(e => '*' + e);
    return reverse.reverse().join(';');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("volume", "l"),"*ume;*vo");
}

test();
