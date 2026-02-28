function f(text: string): string {
    let new_text: string = '';
    for (const ch of text.toLowerCase().trim()) {
        if (!isNaN(parseInt(ch, 10)) || ['ä', 'ö', 'ü', 'ï'].includes(ch)) {
            new_text += ch;
        }
    }
    return new_text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(""),"");
}

test();
