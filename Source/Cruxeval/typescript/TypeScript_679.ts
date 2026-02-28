function f(text: string): boolean {
    if (text === '') {
        return false;
    }
    const first_char = text[0];
    if (!isNaN(parseInt(text[0]))) {
        return false;
    }
    for (let i = 0; i < text.length; i++) {
        const last_char = text[i];
        if (last_char !== '_' && !/^[a-zA-Z0-9_]*$/.test(last_char)) {
            return false;
        }
    }
    return true;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("meet"),true);
}

test();
