function f(text: string, comparison: string): number {
    const length: number = comparison.length;
    if (length <= text.length) {
        for (let i = 0; i < length; i++) {
            if (comparison[length - i - 1] !== text[text.length - i - 1]) {
                return i;
            }
        }
    }
    return length;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("managed", ""),0);
}

test();
