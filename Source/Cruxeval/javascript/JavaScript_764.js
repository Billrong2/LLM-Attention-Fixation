function f(text, old, replacement){
    let text2 = text.replace(old, replacement);
    let old2 = old.split('').reverse().join('');
    while (text2.includes(old2)) {
        text2 = text2.replace(old2, replacement);
    }
    return text2;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("some test string", "some", "any"),"any test string");
}

test();
