function f(text: string): boolean {
    if (text === '42.42') {
        return true;
    }
    for (let i = 3; i < text.length - 3; i++) {
        if (text[i] === '.' && !isNaN(parseFloat(text.slice(i - 3))) && !isNaN(parseFloat(text.slice(0, i)))) {
            return true;
        }
    }
    return false;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("123E-10"),false);
}

test();
