function f(string: string, substring: string): string {
    while (string.startsWith(substring)) {
        string = string.substring(substring.length);
    }
    return string;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("", "A"),"");
}

test();
