function f(text: string, pre: string): string {
    if (!text.startsWith(pre)) {
        return text;
    }
    return text.substring(pre.length);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("@hihu@!", "@hihu"),"@!");
}

test();
