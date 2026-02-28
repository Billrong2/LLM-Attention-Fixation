function f(s, ch){
    if (!s.includes(ch)) {
        return '';
    }
    let reversed = s.split(ch).pop().split('').reverse().join('');
    for (let i = 0; i < reversed.length; i++) {
        reversed = reversed.split(ch).pop().split('').reverse().join('');
    }
    return reversed;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("shivajimonto6", "6"),"");
}

test();
