function f(text: string, pref: string): boolean {
    if (Array.isArray(pref)) {
        return pref.some((x: string) => text.startsWith(x));
    } else {
        return text.startsWith(pref);
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("Hello World", "W"),false);
}

test();
