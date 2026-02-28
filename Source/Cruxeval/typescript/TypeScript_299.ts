function f(text: string, char: string): string {
    if (!text.endsWith(char)) {
        return f(char + text, char);
    }
    return text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("staovk", "k"),"staovk");
}

test();
