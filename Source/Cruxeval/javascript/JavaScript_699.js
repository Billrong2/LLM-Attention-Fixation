function f(text, elem){
    let result = [elem, text];
    if (elem !== '') {
        while (text.startsWith(elem)) {
            text = text.replace(elem, '');
        }
        while (elem.startsWith(text)) {
            elem = elem.replace(text, '');
        }
    }
    return result;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("some", "1"),["1", "some"]);
}

test();
