function f(integer: number, n: number): string {
    let i: number = 1;
    let text: string = integer.toString();
    while (i + text.length < n) {
        i += text.length;
    }
    return text.padStart(i + text.length, '0');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(8999, 2),"08999");
}

test();
