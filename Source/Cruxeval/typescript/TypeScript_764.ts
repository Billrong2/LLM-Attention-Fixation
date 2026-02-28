function f(text: string, old: string, newStr: string): string {
    let text2: string = text.replace(old, newStr);
    let old2: string = old.split('').reverse().join('');
    while (text2.indexOf(old2) !== -1) {
        text2 = text2.replace(old2, newStr);
    }
    return text2;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("some test string", "some", "any"),"any test string");
}

test();
