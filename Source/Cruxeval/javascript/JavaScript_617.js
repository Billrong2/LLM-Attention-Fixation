function f(text){
    if (text.split('').every(char => char.charCodeAt(0) <= 127)) {
        return 'ascii';
    } else {
        return 'non ascii';
    }
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("<<<<"),"ascii");
}

test();
