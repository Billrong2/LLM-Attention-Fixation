function f(text: string): string {
    let result: string = '';
    for (let i = text.length - 1; i >= 0; i--) {
        result += text[i];
    }
    return result;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("was,"),",saw");
}

test();
