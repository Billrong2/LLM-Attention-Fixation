function f(text: string, num: number): string {
    const req = num - text.length;
    text = text.padStart((text.length + req) / 2).padEnd(num, '*');
    return text.slice(req / 2, -(req / 2));
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("a", 19),"*");
}

test();
