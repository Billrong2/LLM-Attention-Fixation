function f(text: string): boolean {
    const valid_chars: string[] = ['-', '_', '+', '.', '/', ' '];
    text = text.toUpperCase();
    for (let char of text) {
        if (!char.match(/[a-zA-Z0-9]/) && !valid_chars.includes(char)) {
            return false;
        }
    }
    return true;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("9.twCpTf.H7 HPeaQ^ C7I6U,C:YtW"),false);
}

test();
