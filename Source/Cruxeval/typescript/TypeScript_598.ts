function f(text: string, n: number): string {
    const length: number = text.length;
    return text.substring(length * (n % 4), length);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("abc", 1),"");
}

test();
