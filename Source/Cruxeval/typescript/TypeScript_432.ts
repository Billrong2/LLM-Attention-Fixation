function f(length: number, text: string): string| boolean {
    if (text.length === length) {
        return text.split('').reverse().join('');
    }
    return false;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(-5, "G5ogb6f,c7e.EMm"),false);
}

test();
