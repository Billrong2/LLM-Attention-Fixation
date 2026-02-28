function f(text: string, suffix: string): string {
    if (suffix && text && text.endsWith(suffix)) {
        return text.slice(0, text.length - suffix.length);
    } else {
        return text;
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("spider", "ed"),"spider");
}

test();
