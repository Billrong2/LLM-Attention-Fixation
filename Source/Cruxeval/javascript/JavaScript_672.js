function f(text, position, value){
    let length = text.length;
    let index = (position % (length + 2)) - 1;
    if (index >= length || index < 0) {
        return text;
    }
    let text_list = text.split('');
    text_list[index] = value;
    return text_list.join('');
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("1zd", 0, "m"),"1zd");
}

test();
