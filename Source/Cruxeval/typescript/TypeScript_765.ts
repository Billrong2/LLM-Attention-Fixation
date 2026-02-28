function f(text: string): number {
    return text.split('').reduce((count, c) => {
        if (/\d/.test(c)) {
            return count + 1;
        }
        return count;
    }, 0);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("so456"),3);
}

test();
