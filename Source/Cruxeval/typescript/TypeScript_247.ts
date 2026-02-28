function f(s: string): string {
    if (/^[a-zA-Z]+$/.test(s)) {
        return "yes";
    }
    if (s === "") {
        return "str is empty";
    }
    return "no";
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("Boolean"),"yes");
}

test();
