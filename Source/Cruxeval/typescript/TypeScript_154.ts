function f(s: string, c: string): string {
    let splitS = s.split(' ');
    return c + "  " + splitS.reverse().join("  ");
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("Hello There", "*"),"*  There  Hello");
}

test();
