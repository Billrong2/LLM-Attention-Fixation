function f(text, substr, occ){
    let n = 0;
    while (true) {
        let i = text.lastIndexOf(substr);
        if (i === -1) {
            break;
        } else if (n === occ) {
            return i;
        } else {
            n++;
            text = text.substring(0, i);
        }
    }
    return -1;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("zjegiymjc", "j", 2),-1);
}

test();
