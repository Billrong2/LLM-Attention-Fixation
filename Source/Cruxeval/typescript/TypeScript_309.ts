function f(text: string, suffix: string): string {
    while (text.slice(-suffix.length) === suffix) {
        text = text.slice(0, -1);
    }
    return text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("faqo osax f", "f"),"faqo osax ");
}

test();
