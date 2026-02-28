function f(text: string): boolean {
    for (const i of ['.', '!', '?']) {
        if (text.endsWith(i)) {
            return true;
        }
    }
    return false;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(". C."),true);
}

test();
