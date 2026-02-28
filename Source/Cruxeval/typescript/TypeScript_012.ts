function f(s: string, x: string): string {
    let count: number = 0;
    while (s.substr(0, x.length) === x && count < s.length - x.length) {
        s = s.substr(x.length);
        count += x.length;
    }
    return s;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("If you want to live a happy life! Daniel", "Daniel"),"If you want to live a happy life! Daniel");
}

test();
