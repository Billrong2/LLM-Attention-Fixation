function f(text){
    text = text.toLowerCase();
    var capitalize = text.charAt(0).toUpperCase() + text.slice(1);
    return text.charAt(0) + capitalize.slice(1);
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("this And cPanel"),"this and cpanel");
}

test();
