function f(text){
    let ls = text.split('');
    for(let x = ls.length - 1; x >= 0; x--){
        if (ls.length <= 1) break;
        if (!'zyxwvutsrqponmlkjihgfedcba'.includes(ls[x])) ls.splice(x, 1);
    }
    return ls.join('');
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("qq"),"qq");
}

test();
