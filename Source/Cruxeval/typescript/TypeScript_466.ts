function f(text: string): string {
    let length: number = text.length;
    let index: number = 0;
    while (index < length && text[index].match(/\s/)) {
        index++;
    }
    return text.substring(index, index + 5);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("-----	\n	th\n-----"),"-----");
}

test();
