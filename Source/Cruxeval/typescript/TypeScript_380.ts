function f(text: string, delimiter: string): string {
    const splitText = text.split(delimiter);
    return splitText.slice(0, splitText.length - 1).join(delimiter) + splitText[splitText.length - 1];
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("xxjarczx", "x"),"xxjarcz");
}

test();
