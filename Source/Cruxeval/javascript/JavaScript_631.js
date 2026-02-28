function f(text, num){
    let req = num - text.length;
    text = text.padStart((text.length + req) / 2, '*').padEnd(num, '*');
    return text.slice(req/2, -req/2);
}

const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("a", 19),"*");
}

test();
