function f(text: string, sign: string): string {
    let length = text.length;
    let new_text: string[] = Array.from(text);
    let sign_chars: string[] = Array.from(sign);
    for(let i = 0; i < sign_chars.length; i++) {
        let position = Math.floor((i * length - 1) / 2) + Math.floor((i + 1) / 2);
        new_text.splice(position, 0, sign_chars[i]);
    }
    return new_text.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("akoon", "sXo"),"akoXoosn");
}

test();
