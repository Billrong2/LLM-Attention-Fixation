function f(x: string): string {
    if (x === x.toLowerCase()) {
        return x;
    } else {
        return x.split('').reverse().join('');
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("ykdfhp"),"ykdfhp");
}

test();
