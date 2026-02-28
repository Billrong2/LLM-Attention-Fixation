function f(text: string, char: string): string {
    let textArray: string[] = text.split('');
    for (let i = 0; i < textArray.length; i++) {
        if (textArray[i] === char) {
            textArray.splice(i, 1);
            return textArray.join('');
        }
    }
    return textArray.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("pn", "p"),"n");
}

test();
