function f(text: string, prefix: string): string {
    return text.substring(prefix.length);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("123x John z", "z"),"23x John z");
}

test();
