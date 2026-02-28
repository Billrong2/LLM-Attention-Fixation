function f(text: string, length: number, index: number): string {
    const ls = text.split(' ').slice(0, index).reverse();
    return ls.map(l => l.slice(0, length)).join('_');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("hypernimovichyp", 2, 2),"hy");
}

test();
