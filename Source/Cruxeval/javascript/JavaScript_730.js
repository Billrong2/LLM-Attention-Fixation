function f(text){
    let m = 0;
    let cnt = 0;
    text.split(' ').forEach(word => {
        if (word.length > m) {
            cnt++;
            m = word.length;
        }
    });
    return cnt;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("wys silak v5 e4fi rotbi fwj 78 wigf t8s lcl"),2);
}

test();
