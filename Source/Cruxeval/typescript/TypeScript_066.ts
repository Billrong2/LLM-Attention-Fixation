function f(text: string, prefix: string): string {
    const prefixLength: number = prefix.length;
    if (text.startsWith(prefix)) {
        return text.substr((prefixLength - 1) / 2,
                           (prefixLength + 1) / 2 * -1).split('').reverse().join('');
    } else {
        return text;
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("happy", "ha"),"");
}

test();
