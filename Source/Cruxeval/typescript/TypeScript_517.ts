function f(text: string): string {
    for (let i = text.length - 1; i > 0; i--) {
        if (text[i] !== text[i].toUpperCase()) {
            return text.substring(0, i);
        }
    }
    return '';
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("SzHjifnzog"),"SzHjifnzo");
}

test();
