function f(string){
    let l = string.split('');
    for (let i = l.length - 1; i >= 0; i--) {
        if (l[i] !== ' ') {
            break;
        }
        l.splice(i, 1);
    }
    return l.join('');
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("    jcmfxv     "),"    jcmfxv");
}

test();
