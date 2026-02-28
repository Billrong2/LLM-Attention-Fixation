function f(text: string, strip_chars: string): string {
    return text.split('').reverse().join('').replace(new RegExp(`^[${strip_chars}]+|[${strip_chars}]+$`, 'g'), '').split('').reverse().join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("tcmfsmj", "cfj"),"tcmfsm");
}

test();
