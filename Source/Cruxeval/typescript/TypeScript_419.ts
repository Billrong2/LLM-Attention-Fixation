function f(text: string, value: string): string {
    if (!text.includes(value)) {
        return '';
    }
    return text.substring(0, text.lastIndexOf(value));
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("mmfbifen", "i"),"mmfb");
}

test();
