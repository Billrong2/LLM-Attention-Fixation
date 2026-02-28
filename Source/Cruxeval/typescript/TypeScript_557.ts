function f(s: string): string {
    const d = s.lastIndexOf('ar');
    if (d === -1) {
        return s;
    }
    return s.substring(0, d) + ' ' + s.substring(d, d + 2) + ' ' + s.substring(d + 2);
}

declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("xxxarmmarxx"),"xxxarmm ar xx");
}

test();
