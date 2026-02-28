function f(text: string): string {
    const n: number = text.indexOf('8');
    return 'x0'.repeat(n);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("sa832d83r xd 8g 26a81xdf"),"x0x0");
}

test();
