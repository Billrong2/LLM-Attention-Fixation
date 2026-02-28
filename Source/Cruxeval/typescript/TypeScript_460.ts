function f(text: string, amount: number): string {
    const length: number = text.length;
    let pre_text: string = '|';
    if (amount >= length) {
        const extra_space: number = amount - length;
        pre_text += ' '.repeat(Math.floor(extra_space / 2));
        return pre_text + text + pre_text;
    }
    return text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("GENERAL NAGOOR", 5),"GENERAL NAGOOR");
}

test();
