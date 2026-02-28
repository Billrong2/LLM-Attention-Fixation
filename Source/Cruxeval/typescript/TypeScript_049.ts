function f(text: string): string {
    if (/^\w+$/.test(text)) {
        return text.split('').filter(c => /^\d$/.test(c)).join('');
    } else {
        return text.split('').join('');
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("816"),"816");
}

test();
