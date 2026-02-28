function f(text: string, char: string): boolean {
    if (text.includes(char)) {
        const trimmedText = text.split(char).map(t => t.trim()).filter(t => t);
        if (trimmedText.length > 1) {
            return true;
        }
    }
    return false;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("only one line", " "),true);
}

test();
