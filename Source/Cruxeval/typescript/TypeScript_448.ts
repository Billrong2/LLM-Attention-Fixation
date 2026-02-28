function f(text: string, suffix: string): boolean {
    if (suffix === '') {
        suffix = null;
    }
    return text.endsWith(suffix);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("uMeGndkGh", "kG"),false);
}

test();
