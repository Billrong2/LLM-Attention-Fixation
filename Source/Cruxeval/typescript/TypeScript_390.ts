function f(text: string): number {
    if (!text.trim()) {
        return text.trim().length;
    }
    return null;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(" 	 "),0);
}

test();
