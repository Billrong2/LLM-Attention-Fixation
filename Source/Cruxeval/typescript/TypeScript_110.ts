function f(text: string): number {
    let a: string[] = [''];
    let b: string = '';
    for (let i of text) {
        if (i !== ' ') {
            a.push(b);
            b = '';
        } else {
            b += i;
        }
    }
    return a.length;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("       "),1);
}

test();
