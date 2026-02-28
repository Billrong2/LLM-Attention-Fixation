function f(text){
    let result = '';
    let mid = Math.floor((text.length - 1) / 2);
    for (let i = 0; i < mid; i++) {
        result += text[i];
    }
    for (let i = mid; i < text.length - 1; i++) {
        result += text[mid + text.length - 1 - i];
    }
    return result.padEnd(text.length, text[text.length - 1]);
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("eat!"),"e!t!");
}

test();
