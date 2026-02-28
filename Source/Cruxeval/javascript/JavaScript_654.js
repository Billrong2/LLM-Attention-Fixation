function f(s, from_c, to_c){
    let table = {};
    for (let i = 0; i < from_c.length; i++) {
        table[from_c.charCodeAt(i)] = to_c.charCodeAt(i);
    }
    
    let result = "";
    for (let char of s) {
        result += typeof table[char.charCodeAt(0)] !== 'undefined' ? String.fromCharCode(table[char.charCodeAt(0)]) : char;
    }
    
    return result;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("aphid", "i", "?"),"aph?d");
}

test();
