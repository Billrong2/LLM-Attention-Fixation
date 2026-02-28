function f(text: string, suffix: string): string {
    if (suffix.startsWith("/")) {
        return text + suffix.substring(1);
    }
    return text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("hello.txt", "/"),"hello.txt");
}

test();
