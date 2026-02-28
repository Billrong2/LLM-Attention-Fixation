function f(s: string): string {
    if (/^[a-zA-Z0-9]+$/.test(s)) {
        return "True";
    }
    return "False";
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("777"),"True");
}

test();
