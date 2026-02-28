function f(text: string, length: number): string {
    length = length < 0 ? -length : length;
    let output: string = '';
    for (let idx = 0; idx < length; idx++) {
        if (text[idx % text.length] !== ' ') {
            output += text[idx % text.length];
        } else {
            break;
        }
    }
    return output;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("I got 1 and 0.", 5),"I");
}

test();
