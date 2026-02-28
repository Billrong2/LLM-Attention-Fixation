function f(text: string, s: number, e: number): number {
    const sublist: string = text.substring(s, e);
    if (!sublist) {
        return -1;
    }
    return sublist.indexOf(sublist.split('').sort()[0]);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("happy", 0, 3),1);
}

test();
