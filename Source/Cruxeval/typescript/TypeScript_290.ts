function f(text: string, prefix: string): string {
    if (text.startsWith(prefix)) {
        return text.substring(prefix.length);
    }
    if (text.includes(prefix)) {
        return text.replace(prefix, '').trim();
    }
    return text.toUpperCase();
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("abixaaaily", "al"),"ABIXAAAILY");
}

test();
