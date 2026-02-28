function f(text: string, rules: string[]): string {
    for (let rule of rules) {
        if (rule === '@') {
            text = text.split('').reverse().join('');
        } else if (rule === '~') {
            text = text.toUpperCase();
        } else if (text && text[text.length - 1] === rule) {
            text = text.substring(0, text.length - 1);
        }
    }
    return text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("hi~!", ["~", "`", "!", "&"]),"HI~");
}

test();
