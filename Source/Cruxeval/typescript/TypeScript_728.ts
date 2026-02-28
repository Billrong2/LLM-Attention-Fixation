function f(text: string): string {
    let result: string[] = [];
    for (let i = 0; i < text.length; i++) {
        let ch = text[i];
        if (ch === ch.toLowerCase()) {
            continue;
        }
        if (text.length - 1 - i < text.lastIndexOf(ch.toLowerCase())) {
            result.push(ch);
        }
    }
    return result.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("ru"),"");
}

test();
