function f(text: string, pref: string): string {
    if (text.startsWith(pref)) {
        const n = pref.length;
        text = text.slice(n).split('.').slice(1).concat(text.slice(0, n).split('.').slice(0, -1)).join('.');
    }
    return text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("omeunhwpvr.dq", "omeunh"),"dq");
}

test();
