function f(num: string, l: number): string {
    let t: string = "";
    while (l > num.length) {
        t += '0';
        l--;
    }
    return t + num;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("1", 3),"001");
}

test();
