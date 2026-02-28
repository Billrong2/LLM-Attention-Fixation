function f(text, char){
    let char_index = text.indexOf(char);
    let result = [];
    if (char_index > 0) {
        result = text.substring(0, char_index).split('');
    }
    result = result.concat(char.split('')).concat(text.substring(char_index + char.length).split(''));
    return result.join('');
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("llomnrpc", "x"),"xllomnrpc");
}

test();
