function f(text, n){
if (n < 0 || text.length <= n) {
    return text;
}
let result = text.substring(0, n);
let i = result.length - 1;
while (i >= 0) {
    if (result[i] !== text[i]) {
        break;
    }
    i--;
}
return text.substring(0, i + 1);
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("bR", -1),"bR");
}

test();
