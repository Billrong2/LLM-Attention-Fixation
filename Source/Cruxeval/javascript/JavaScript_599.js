function f(a, b){
    a = a.join(b);
    let lst = [];
    for (let i = 1; i <= a.length; i += 2) {
        lst.push(a.slice(i-1, i-1+i));
        lst.push(a.slice(i-1).slice(i));
    }
    return lst;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["a", "b", "c"], " "),["a", " b c", "b c", "", "c", ""]);
}

test();
