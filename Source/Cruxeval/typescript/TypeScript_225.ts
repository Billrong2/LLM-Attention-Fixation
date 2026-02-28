function f(text: string): boolean {
    if (text.length === 0) {
        return false;
    }
    let hasLower = false;
    for (let i = 0; i < text.length; i++) {
        if (text[i] >= 'a' && text[i] <= 'z') {
            hasLower = true;
        } else if (text[i] >= 'A' && text[i] <= 'Z') {
            return false;
        }
    }
    return hasLower;
}

declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("54882"),false);
}

test();
