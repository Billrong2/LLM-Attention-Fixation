function f(text: string): string {
    const uppercaseIndex: number = text.indexOf('A');
    if (uppercaseIndex >= 0) {
        return text.slice(0, uppercaseIndex) + text.slice(text.indexOf('a') + 1);
    } else {
        return text.split('').sort().join('');
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("E jIkx HtDpV G"),"   DEGHIVjkptx");
}

test();
