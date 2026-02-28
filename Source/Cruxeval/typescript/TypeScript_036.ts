function f(text: string, chars: string): string {
    return text.replace(new RegExp(`[${chars}] *$`), '');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("ha", ""),"ha");
}

test();
