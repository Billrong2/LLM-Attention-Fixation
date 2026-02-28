function f(n: string, m: string, text: string): string {
    if (text.trim() === '') {
        return text;
    }
    let head = text[0];
    let mid = text.slice(1, -1);
    let tail = text[text.length - 1];
    let joined = head.replace(n, m) + mid.replace(n, m) + tail.replace(n, m);
    return joined;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("x", "$", "2xz&5H3*1a@#a*1hris"),"2$z&5H3*1a@#a*1hris");
}

test();
