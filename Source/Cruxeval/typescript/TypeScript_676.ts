function f(text: string, tab_size: number): string {
    return text.replace(/\t/g, ' '.repeat(tab_size));
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("a", 100),"a");
}

test();
