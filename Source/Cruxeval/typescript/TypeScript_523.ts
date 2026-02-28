function f(text: string): string {
    let textArray = text.split('');
    for (let i = textArray.length - 1; i >= 0; i--) {
        if (textArray[i] === ' ') {
            textArray[i] = '&nbsp;';
        }
    }
    return textArray.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("   "),"&nbsp;&nbsp;&nbsp;");
}

test();
