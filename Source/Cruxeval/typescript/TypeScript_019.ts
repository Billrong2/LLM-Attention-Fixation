function f(x: string, y: string): string {
    let tmp: string = y.split('').reverse().map(c => c === '9' ? '0' : '9').join('');
    if (Number.isInteger(parseInt(x)) && Number.isInteger(parseInt(tmp))) {
        return x + tmp;
    } else {
        return x;
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("", "sdasdnakjsda80"),"");
}

test();
