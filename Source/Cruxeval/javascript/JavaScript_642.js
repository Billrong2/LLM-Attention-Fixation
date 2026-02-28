function f(text){
    let i = 0;
    while (i < text.length && text[i].trim() === '') {
        i++;
    }
    if (i === text.length) {
        return 'space';
    }
    return 'no';
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("     "),"space");
}

test();
