function f(text: string): string {
    for (let i = 0; i < text.length; i++) {
        if (text.substring(0, i).startsWith("two")) {
            return text.substring(i);
        }
    }
    return 'no';
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("2two programmers"),"no");
}

test();
