function f(text: string, suffix: string): string {
    if (text.endsWith(suffix)) {
        return text.slice(0, -suffix.length);
    }
    return text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("zejrohaj", "owc"),"zejrohaj");
}

test();
