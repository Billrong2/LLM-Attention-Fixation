function f(n: string): string {
    let length: number = n.length + 2;
    let revn: string[] = n.split('');
    let result: string = revn.join('');
    revn = [];
    return result + '!'.repeat(length);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("iq"),"iq!!!!");
}

test();
