function f(text: string, value: string): string {
    return text.toLowerCase().startsWith(value.toLowerCase()) ? text.slice(value.length) : text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("coscifysu", "cos"),"cifysu");
}

test();
