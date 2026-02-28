function f(text){
    let result_list = ['3', '3', '3', '3'];
    if (result_list.length > 0) {
        result_list = [];
    }
    return text.length;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("mrq7y"),5);
}

test();
