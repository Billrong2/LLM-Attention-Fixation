function f(s1: string, s2: string): number[] {
    let res: number[] = [];
    let i = s1.lastIndexOf(s2);
    while (i != -1) {
        res.push(i + s2.length - 1);
        if (i == 0) break;
        i = s1.lastIndexOf(s2, i - 1);
    }
    return res;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("abcdefghabc", "abc"),[10, 2]);
}

test();
