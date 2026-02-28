function f(text: string): string {
    let ls = text.split('');
    let length = ls.length;
    for (let i = 0; i < length; i++) {
        ls.splice(i, 0, ls[i]);
    }
    return ls.join('').padEnd(length * 2, ' ');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("hzcw"),"hhhhhzcw");
}

test();
