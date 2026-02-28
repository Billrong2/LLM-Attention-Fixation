function f(array: string[]): string {
    let s: string = ' ';
    s += array.join('');
    return s;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([" ", "  ", "    ", "   "]),"           ");
}

test();
