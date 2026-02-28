function f(text, keyword){
    let cites = [text.slice(text.indexOf(keyword) + keyword.length).length];
    for (let char of text) {
        if (char === keyword) {
            cites.push(text.slice(text.indexOf(keyword) + keyword.length).length);
        }
    }
    return cites;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("010100", "010"),[3]);
}

test();
