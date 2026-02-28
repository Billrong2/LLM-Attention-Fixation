function f(text: string, search_chars: string, replace_chars: string): string {
    const trans_table = new Map<string, string>();
    for (let i = 0; i < search_chars.length; i++) {
        trans_table.set(search_chars[i], replace_chars[i]);
    }
    return text.split('').map(char => trans_table.has(char) ? trans_table.get(char) : char).join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("mmm34mIm", "mm3", ",po"),"pppo4pIp");
}

test();
