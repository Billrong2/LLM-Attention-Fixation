function f(text){
    let my_list = text.split(" ");
    my_list.sort((a, b) => b.localeCompare(a));
    return my_list.join(" ");
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("a loved"),"loved a");
}

test();
