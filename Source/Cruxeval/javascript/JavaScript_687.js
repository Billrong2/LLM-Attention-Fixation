function f(text){
    let t = text.split('');
    t.splice(Math.floor(t.length / 2), 1);
    t.push(text.toLowerCase());
    return t.map(c => c).join(':');
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("Rjug nzufE"),"R:j:u:g: :z:u:f:E:rjug nzufe");
}

test();
