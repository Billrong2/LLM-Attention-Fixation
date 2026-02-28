function f(line, equalityMap){
    let rs = {};
    equalityMap.forEach(k => {
        rs[k[0]] = k[1];
    });
    return line.split('').map(char => rs[char] || char).join('');
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("abab", [["a", "b"], ["b", "a"]]),"baba");
}

test();
