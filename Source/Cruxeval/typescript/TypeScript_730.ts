function f(text: string): number {
    let m: number = 0;
    let cnt: number = 0;
    text.split(' ').forEach((word: string) => {
        if (word.length > m) {
            cnt++;
            m = word.length;
        }
    });
    return cnt;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("wys silak v5 e4fi rotbi fwj 78 wigf t8s lcl"),2);
}

test();
