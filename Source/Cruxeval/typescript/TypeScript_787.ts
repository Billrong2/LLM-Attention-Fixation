function f(text: string): string {
    if (text.length === 0) {
        return '';
    }
    text = text.toLowerCase();
    return text[0].toUpperCase() + text.slice(1);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("xzd"),"Xzd");
}

test();
