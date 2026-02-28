function f(text: string): string {
    text = text.toLowerCase();
    let head = text[0];
    let tail = text.slice(1);
    return head.toUpperCase() + tail;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("Manolo"),"Manolo");
}

test();
