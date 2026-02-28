function f(prefix: string, text: string): string {
    if (text.startsWith(prefix)) {
        return text;
    } else {
        return prefix + text;
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("mjs", "mjqwmjsqjwisojqwiso"),"mjsmjqwmjsqjwisojqwiso");
}

test();
